@echo off
setlocal

REM Get the input file from the first command line argument
set "inputFile=%~1"

REM Extract the first word from the input file name
for /f "delims= " %%a in ("%~n1") do set "firstWord=%%a"

REM Set the output file name to be the same as the input file, but with a .tex ending
set "outputFile=%~dp1%firstWord%.tex"

REM Run pandoc to convert the input file to LaTeX
pandoc "%inputFile%" -f markdown+wikilinks_title_after_pipe -t latex -o "%outputFile%" --pdf-engine=xelatex -V lang:he -V dir:rtl -V --mathml --lua-filter obsidian.lua --lua-filter minted.lua -s --template hebrew.tex -V callouts --pdf-engine-opt=-shell-escape

endlocal
