
It is very convenient to define a path where gnuplot knows where the
configuration files are. I also create directories in that location with
styles, definitions, macros, etc, so that I do not have to include them in
every single gnuplot script that I create. I have stolen the idea and some
scripts <a href="http://www.gnuplotting.org/">from this page</a>.

Configuration file and folders
==============================

As most UNIX programmes, gnuplot uses a configuration file which is usually
located in your home directory, `$HOME/.gnuplotrc`. However, I prefer to have
all configuration files stores in a folder which, in my case, is
`$HOME/fitx_confg` (from Catalan "fitxers de configuració", which means "blue
cucumbers" in English, obviously).

In my case, hence, the subfolder is

```~/fitx_confg/gnuplot```

where I have both the file gnuplotrc and another folder, called snippets. 

***(a) gnuplotrc***

First, let gnuplot know where `gnuplotrc` is. In my case, I have to run

```
$ ln -sf  /home/pau/fitx_confg/gnuplot/gnuplotrc  ~/.gnuplot
```

The contents of gnuplotrc are

```
# gnuplotrc configuration file
# Pau Amaro Seoane, Berlin, 24/Jul/2020

# Beause gnuplot does not allow to pass an argument
# to load this file, link its location to $HOME/.gnuplot
# In my case gnuplotrc is in $HOME/fitx_confg/gnuplot/ :

# ln -fs $HOME/fitx_confg/gnuplot/gnuplotrc $HOME/.gnuplot


            # ******************** loadpath ******************* #

set loadpath "/home/pau/fitx_confg/gnuplot/snippets/:/home/pau/fitx_confg/gnuplot/palettes/" # Do not use $HOME herei
```

If you wish, obviously, you can simply add that line to $HOME/.gnuplotrc and avoid the symbolic linking.

***(b) snippets***

The contents of snippets is the following:

```
$ ls snippets 
arrows.cfg       
convfactors.cfg  
header.cfg       
lines.cfg        
xborder.cfg      
yborder.cfg
constants.cfg    
grid.cfg
```

where, again, I have taken over a lot of things from <a href="http://www.gnuplotting.org/">gnuplotting</a>.

The most important file is `header.cfg`, which contains this

```
set terminal epslatex size 8.89cm,6.65cm color colortext 10 header "\\newcommand{\\ft}[0]{\\footnotesize}"
set border linewidth 4
set output "out.tex"
```

because I always use latex with gnuplot thanks to two scripts I wrote.

Using latex with gnuplot
=========================

I have two scripts (one of them is a silly one) to only use latex on the plots. These are included in the folder
`latex_scripts/`.  Make sure you have these two scripts on a folder which is on your path. 

The main script is the second one, which contains this information in the header

```
# This script is meant to quickly and silently produce an eps
# from a File.tex and File.eps created with gnuplot. 
#
#  Usage:  GpTex.sh [-p] filename
#
#  -p  optional, to convert to pdf and crop the file.  
#      This runs epstopdf and pdfcrop if -p is present.
#
#  filename  -- input file.  Presumed to be filename.tex
#
#
# You have to use the epslatex in gnuplot. This is an
# example:
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# set terminal epslatex          <---                                     %
# set output "MyFile.tex"        <---                                     %
# set xlabel "Time ($10^9$ sec)"                                          %
# set ylabel "$e_{\\bullet}$"                                             %
# set mxtics 5                                                            %
# set mytics 5                                                            %
# set nokey                                                               %
#                                                                         %
# plot './orbital_elements.dat' u ($1/1e+9):2 ls 1 w l smooth csplines, \ %
#      'orbital_elements2.dat' u ($1/1e+9):2 ls 1 w l smooth csplines     %
#                                                                         %
# set terminal x11                                                        %
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#
# All latex symbols need to be protected with a second backslash: \\
#
# Write the above script as MyScript.gnuplot and run
# $ gnuplot MyScript.gnuplot
# This produces a .tex file, which is the argument of GpTex.sh
# 
# Pau Amaro Seoane, 20/09/2011, Berlin 
#
#  Note:
#  I've used redirect to /dev/null to quiet LaTeX and dvips output
#  To restore the noise, simply remove those redirects.
```

The second script is just doing what is explained in the header

```
# This is a dummy script which uses
# gnuplot and GpTex -p assuming that
# gnuplot exports always to out.tex
# to then open it with a pdf viewer
```

This way, you just have to run from your terminal

```
$ Gnuplot.sh YourScript.gnu
```

This will create the figure with latex and open a viewer to have a look at the
outputted (and trimmed) pdf which, by default, is going to be called `out.pdf`.

Default template for gnuplot
=============================

I work with vi(m); in my `vimrc` file I have defined this line

```
"""" gnuplot
ab figgnuplot        ^[:r $HOME/fitx_confg/vim/motlles/figgnuplot.gnu^Mggdd
ab gnuplotfig        ^[:r $HOME/fitx_confg/vim/motlles/figgnuplot.gnu^Mggdd
```

so that when I type one of those two words in vim, a template appears with all
of the paths defined and also a skeleton for a general-purpose `.gnu` file. 

I have included the template `figgnuplot.gnu` in the `template` folder.

License
=======

My configuration files and scripts follow this license. Please, again, take
into account that most (if not all, cannot recall) snippets are a copy of the
<a href="http://www.gnuplotting.org/">gnuplotting</a> webpage. They might have
a different license.

```
Copyright 2024 Pau Amaro Seoane

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
```
