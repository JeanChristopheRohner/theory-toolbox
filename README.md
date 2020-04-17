# theory-toolbox
A collection of Prolog predicates for reasoning about scientific theories written in clausal form logic.

## Installation
* Theory Toolbox requires the latest version of [SWI-Prolog](https://www.swi-prolog.org/Download.html).
* Clone the theory-toolbox repository to your computer. Instructions on how to do this can be found [here](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository).

## Operation
* To get started load (consult) one of the examples such as genealogyExample.pl and run the queries at the bottom of the file. Instructions on consulting Prolog files can be found [here](https://www.swi-prolog.org/pldoc/man?section=quickstart).
* To use the toolbox on your own theory create a text file (UTF-8 with BOM encoding) and write `:-import(theoryToolbox.pl)` at the top of this file. Your file has to be in the same directory as theoryToolbox.pl (alternatively you can modify the include directory to point to another directory that contains theoryToolbox.pl).
* Load (consult) your file from SWI Prolog.
* The import directive
  * Enables symbols from classic logic as operators: `∧`, `∨`, `⇐`, `¬` (in theoryToolbox.pl these are defined as operators and `term_expansion/2` and `goal_expansion/2` are used to replace the first three logical symbols with standard Prolog operators).
  * Enables the following Theory Toolbox predicates: `provable/3`, `prove/3`, `maxValue/3`, `minValue/3`, `incoherence/6` and `falsifiability/3` (for more information see the comments in theoryToolbox.pl.
* SWI Prolog can be run from a terminal or as a standalone application. Complementing the SWI Prolog installation with [Visual Studio Code](https://code.visualstudio.com/download) and the [VSC Prolog extension](https://marketplace.visualstudio.com/items?itemName=arthurwang.vsc-prolog) is very handy. Visual Studio Code has built-in GitHub support and it can be used to define user snippets (for logical or other symbols).

## Help
For additional help, see [these](www.vimeo.com) videos.

## Legal
The files in this repository are available under the conditions of a GPL3 license (see the license file).

## Acknowledgements
I want to extend a big thank you to the following people for patiently answering my questions while I learned logic programming: Alan Baljeu, Anne Ogborn, Carlo Capelli, Daniel Lyons, David Tonhofer, Eric Taucher, Fabrizio Riguzzi, false, Guy Coder, Håkan Kjellerstrand, Jan Wielemaker, lurker, Mostowski Collapse, Paul Brown, Paulo Moura, Peter Ludemann, and repeat.