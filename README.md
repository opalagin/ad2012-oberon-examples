# Oberon examples from Algorithms and Data Structures by N. Wirth

This is a collection of some examples from the book. I use this project to test and play with algorithms w/o modifying them to any other programming
language. The big role in that plays Excelsior's IDE XDS wich supports Oberon-2 and works on Windows and Linux. Note that book doesn't cover 
Oberon syntax and its programming model. But you can learn that from http://inf.ethz.ch/personal/wirth/Oberon/PIO.pdf.


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

## Differences from original code

- Arrays are usually fixed size in the book. Though here size is determined in runtime using LEN() command
- Book introduces notion of NULL-terminated strings but doesn't use them in string search examples. Here all strings are NULL-terminated
  and there length is computed in runtime. Though usually array size is 255.


## Building

1. Download and install XDS SDK from https://www.excelsior-usa.com/xds.html#downloads 
2. Add xc executable to your search path.
3. Use xc to compile a project. For example: xc =project exp/exp.prj

