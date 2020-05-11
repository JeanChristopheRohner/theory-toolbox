# theory-toolbox
A collection of Prolog predicates for reasoning about scientific theories written in clausal form logic.

## Installation
* Theory Toolbox requires the latest version of [SWI-Prolog](https://www.swi-prolog.org/Download.html).
* Clone the theory-toolbox repository to your computer. Instructions on how to do this can be found [here](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository).

## Getting Started Quickly by Running one of the Provided Examples
After downloading SWI-Prolog and the Theory Toolbox repository do the following
1. Launch SWI-Prolog
2. Go to the File menu and choose Consult
3. Navigate to one of the examples, such as substanceMisuseExample.pl, and open it
4. At the prompt, next to ?-, type one of the queries followed by a period, such as `q3.`

## Proper Operation
* To use the toolbox on your own theory create a text file (UTF-8 with BOM encoding) and write `:-include('theoryToolbox.pl').` at the top of this file. Your file has to be in the same directory as theoryToolbox.pl (alternatively you can modify the include directory to point to another directory that contains theoryToolbox.pl).
* Load (consult) your file from SWI Prolog. Instructions for doing so can be found [here](https://www.swi-prolog.org/pldoc/man?section=quickstart).
* The include directive
  * Enables the use of clp(r) predicates; see more information [here](https://www.swi-prolog.org/pldoc/man?section=clpqr).
  * Enables the use of symbols from classic logic: `∧`, `∨`, `⇐`, `¬` (in theoryToolbox.pl these are defined as operators and `term_expansion/2` and `goal_expansion/2` are used to replace them with standard Prolog operators).
  * Enables the following Theory Toolbox predicates: `provable/3`, `prove/3`, `maxValue/3`, `minValue/3`, `incoherence/6` and `falsifiability/3` (for more information see the comments in theoryToolbox.pl).
* SWI Prolog can be run from a terminal or as a standalone application. Complementing the SWI Prolog installation with [Visual Studio Code](https://code.visualstudio.com/download) and the [VSC Prolog extension](https://marketplace.visualstudio.com/items?itemName=arthurwang.vsc-prolog) is very handy. Visual Studio Code has built-in GitHub support and it can be used to define user snippets (for logical or other symbols).

## Legal
The files in this repository are available under the conditions of a GPL3 license (see the license file).

## Acknowledgements
I want to thank the following people for their kind help during the course of this project: Alan Baljeu, Anne Ogborn, Carlo Capelli, Daniel Lyons, David Tonhofer, Eric Taucher, Fabrizio Riguzzi, @false, @Guy Coder, Håkan Kjellerstrand, Jan Wielemaker, @lurker, Markus Triska, @Mostowski Collapse, Paul Brown, Paulo Moura, Peter Ludemann, and @repeat.

Among other sources, this toolbox was inspired by Leon Sterling's and Ehud Shapiro's _The Art of Prolog_ (1994), and Markus Triska's [The Power of Prolog](https://www.metalevel.at/prolog) (2020).