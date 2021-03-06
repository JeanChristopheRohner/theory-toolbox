### Note: This version is deprecated, go to the [webpage for theory-toolbox-2](https://jeanchristopherohner.github.io/theory-toolbox-2/) instead to find the latest version.


# theory-toolbox

A collection of Prolog predicates for reasoning about scientific theories written in clausal form logic.


## Installation and Setup

It is possible to run SWI-Prolog from Terminal on Mac or the command line in Windows. However, using Visual Studio Code is very handy: It has built in GitHub support and you can define user snippets for different logical symbols. To setup everything to work with Visual Studio Code follow these steps:

* Download and install [SWI Prolog](https://www.swi-prolog.org/Download.html).
* Download and install [Visual Studio Code](https://code.visualstudio.com/download).
* Install the VSC Prolog extension
  - Start Visual Studio Code and click the extensions symbol in the side bar on the far left (the symbol with four squares).
  - Search for the VSC Prolog extension and install it.
* Download and open the Theory Toolbox repository
  - Using a web browser navigate to https://github.com/JeanChristopheRohner/theory-toolbox
  - Click the green Code button and select Download Zip
  - Unpack this folder somewhere on your hard drive
  - In Visual Studio Code, click the File menu, chose Open folder, and open the folder

## Try out Some Examples
* In the folder structure to the left in Visual Studio Code double click an example, e.g. substanceMisuseExample.pl.
* Click the menu View and chose Command Palette... Type `prolog load document` and hit return. Now a terminal should appear.
* Next to `?-` type the name of a query, such as `q3`, followed by a period and hit return.

If you encounter any problems you may have to correct the path to the Prolog executable in Visual Studio Code. To do so, search for swipl on your computer and copy the path to swipl (on mac it is usually `/Applications/SWI-Prolog.app/Contents/MacOS/swipl`; on PC it is usually `C:\Program Files\swipl\bin\swipl.exe`). In Visual Studio Code, go to settings (the cogweel at the far left) chose settings and navigate to the settings for the VSC Prolog extension. Under Prolog Executable Path paste in the path and save.


## To use the toolbox on your own theory

Create a text file (UTF-8 with BOM encoding) and write the following at the top of this file: `:-include('theoryToolbox.pl').` Your file has to be in the same directory as theoryToolbox.pl (alternatively you can modify the include directory to point to another directory that contains theoryToolbox.pl).
Open the file in Visual Studio Code and run a query (as described above).
The include directive
* Enables the use of clpr predicates.
* Enables the use of symbols from classic logic: `∧`, `∨`, `⇐`, `¬` (in theoryToolbox.pl these are defined as operators and term_expansion/2 and goal_expansion/2 are used to replace them with standard Prolog operators).
* Enables the following Theory Toolbox predicates: provable/3, prove/3, maxValue/3, minValue/3, incoherence/6 and falsifiability/3 (for more information see the comments in theoryToolbox.pl).


## Legal

The files in this repository are available under the conditions of a GPL3 license (see the license file).


## Sources

Among other sources, this toolbox was inspired by Leon Sterling's and Ehud Shapiro's _The Art of Prolog_ (1994), and Markus Triska's [The Power of Prolog](https://www.metalevel.at/prolog) (2020).