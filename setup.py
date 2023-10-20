import os
import sys
import glob
import optparse
import multiprocessing

PREFIX_PLACEHOLDER    = '{prefix}'
MODULE_PLACEHOLDER    = '{module}'
SUBMODULE_PLACEHOLDER = '{submodule}'

class RenameTask:
	__slots__ = ('options')

	def __init__(self, options: optparse.Values) -> None:
		self.options: optparse.Values = options

class DirectoryRenameTask(RenameTask):
	def __call__(self, path: str) -> str:
		result_path: str = path.format(submodule=self.options.submodule, module=self.options.module)
		if result_path == path: return ''

		try:
			os.rename(path, result_path)
			print(f'{"[DirectoryRenameTask]":<20}', f'"{path}" -> {result_path}')
		except OSError as error:
			print(f'{"[DirectoryRenameTask]":<20}', f'Failed to rename "{path}" to {self.options.submodule}: {str(error)}')
			return ''
		return result_path


class FileRenameTask(RenameTask):
	def __call__(self, path: str) -> str:
		basename: str = os.path.basename(path)
		directory: str = os.path.dirname(path)
		new_name: str = basename.format(submodule=self.options.submodule, module=self.options.module)
		if new_name == basename: return ''
		try:
			os.rename(path, os.path.join(directory, new_name))
			print(f'{"[FileRenameTask]":<20}', f'"{path}" -> {os.path.join(directory, new_name)}')
		except OSError as error:
			print(f'{"[FileRenameTask]":<20}', f'Failed to rename "{path}" to {new_name}: {str(error)}')
			return ''

		return new_name


class FileReplaceTextTask(RenameTask):
	def __call__(self, path: str) -> str:
		try:
			with open(path, 'r+') as f:
				content: str = (f.read()
					.replace(PREFIX_PLACEHOLDER,    self.options.prefix)
					.replace(MODULE_PLACEHOLDER,    self.options.module)
					.replace(SUBMODULE_PLACEHOLDER, self.options.submodule)
				)

				f.seek(0)
				f.write(content)
				f.truncate()
			print(f'{"[FileReplaceTextTask]":<20}', f'"{path}" updated')

		except Exception as err:
			print(f'{"[FileReplaceTextTask]":<20}', f'Failed to rename text in {path}: {str(err)}')
			return ''
		return path

def main():
	optparser = optparse.OptionParser(usage='usage: %prog -m os -s chrono [-p CHRONO]')
	optparser.add_option('-m', '--module',    dest='module', metavar='MODULE', help='Parent module name')
	optparser.add_option('-s', '--submodule', dest='submodule', metavar='SUBMODULE', help='Your submodule name')
	optparser.add_option('-p', '--prefix',    dest='prefix', metavar='PREFIX', help='Prefix for CMake options')

	(options, args) = optparser.parse_args()
	if not options.submodule or not options.module: return
	if not options.prefix: options.prefix = options.submodule.upper()

	if not options.prefix.startswith('GXZN') or not options.prefix.startswith('GOLXZN'):
		options.prefix = f'GXZN_{options.prefix}'

	current_path: str = os.path.dirname(os.path.realpath(__file__))
	files: list[str] = []
	directories: set[str] = set()
	for entity in glob.glob(f"{current_path}/**", recursive=True):
		if os.path.isfile(entity):
			files.append(entity)
			directories.add(os.path.dirname(entity))
		elif os.path.isdir(entity):
			directories.add(entity)

	with multiprocessing.Pool() as pool:
		pool.map(FileReplaceTextTask(options), files)
		pool.map(FileRenameTask(options), files)
		pool.imap(DirectoryRenameTask(options), sorted(directories, key=len, reverse=True))

	os.remove(os.path.realpath(__file__))

if __name__ == '__main__': main()
