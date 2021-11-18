all:
	@ echo "Now... pushing all changed files to github :)"
	git add .
	git commit -m "commit all file change"
	git push origin HEAD

mm:
	@ echo "Now... pushing memo.md to github :)"
	git add .\memo.md
	git commit -m "postscript"
	git push origin HEAD

td:
	@ echo "Now... pushing TODO.md to github :)"
	git add .\TODO.md
	git commit -m "postscript"
	git push origin HEAD

mf:
	@ echo "Now... pushing Makefile to github :)"
	git add .\Makefile
	git commit -m "edit Makefile"
	git push origin HEAD