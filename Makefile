all:
	git add .
	git commit -m "commit all file change"
	git push origin HEAD

memo:
	git add .\memo.md
	git commit -m "postscript"
	git push origin HEAD

todo:
	git add .\TODO.md
	git commit -m "postscript"
	git push origin HEAD

mf:
	git add .\Makefile
	git commit -m "edit Makefile"
	git push origin HEAD