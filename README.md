# Oberon examples from Algorithms and Data Structures by N. Wirth

This is a collection of examples from the book. I use this project to test and play with examples w/o need to modify them from Oberon to anything else. The book doesn't cover Oberon syntax and its programming model. But it's available in Internet, like [that]( http://inf.ethz.ch/personal/wirth/Oberon/PIO.pdf).

>I used initially Excelsior's XDS SDK for Modula-2/Oberon-2. Which was a good start,
>but unfortunately I couldn't get there debugger to work on Windows 10. So I switched
>to Oxford Oberon-2 Compiler which can be found >[here](http://spivey.oriel.ox.ac.uk/corner/Installing_OBC_release_3.0).


## Algorithms covered

Searching:
- Linear
- Binary

Sorting:
- Straigt Insertion
- Binary Insertion

String:
- KMP search
- BM search

Advanced Sorting:
- Shell Sort
- Heap Sort
- Quick Sort

Sorting Sequences (Files):
- Merge Sort
- Natural Merging
- Balanced Merge
- Polyphase Merge

Recursion:
- Hilbert and Sierpinski curves
- Knight's Tour
- Eight Queens
- Stable Marriage

## Differences from original code

- Arrays are usually fixed size in the book. Though here size is determined in runtime using LEN() command
- Book introduces notion of NULL-terminated strings but doesn't use them in string search examples. Here all strings are NULL-terminated and there length is computed in runtime. Though usually array size is 255.
- All operations on standard input/output are based on Oberon-2 implementation. For example, Text.Scan() is replaced with In.Int() and Out.Int() is used instead of Text.WriteInt().
- Wirth's module "Files" renamed to "Filez" because it clashes with OBC's standard module. Though interface remains the same. 

## Building

### XDS projects (folders were *.prj files exists) on Windows and Linux
1. Download and install XDS SDK from https://www.excelsior-usa.com/xds.html#downloads
2. Add xc executable to your search path.
3. Use xc to compile a project. For example: xc =project exp/exp.prj

### OBC projects on Mac and Linux
1. Download and install Oxford Oberon-2 compiler from [here](http://spivey.oriel.ox.ac.uk/corner/Installing_OBC_release_3.0)
2. Add obc executable to your search path
3. Use make to compile module.
