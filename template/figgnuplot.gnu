# gnuplot epslatex template
# Pau Amaro Seoane, Berlin, 25/Apr/2020
#
# This style is meant to be used along with Gnuplot.sh
# and GpTex.sh
# 
# To be used as
#
#       $ Gnuplot.sh myscript.gnu
#
# This produces out.pdf and opens it with a pdf viewer

            # ******************** load snippets ******************** #

# This assumes that you have a symlink ~/.gnuplot pointing to gnuplotrc
# In my case it is .gnuplot@ -> /home/pau/fitx_confg/gnuplot/gnuplotrc
# In gnuplotrc you add the line:
# set loadpath "/home/user/path/snippets:/home/user/path/palettes"
# Do not use $HOME because it won't expand.

load 'header.cfg'
load 'lines.cfg'
load 'grid.cfg'
load 'lightborder.cfg'
load 'arrows.cfg'
load 'constants.cfg'
load 'convfactors.cfg'

            # ******************** definitions and styles ******************** #

# Scales, ranges and tics
#set logscale xy
# set xtics rotate by 45 right # if you want them rotated by 45 (suprise!)
set mxtics 2 # 10 for log style
set mytics 2 # 10 for log style
set xrange [*:*]
set yrange [*:*]
#set y2range [*:*] # unset if second y-axis, and multiply by the 
                   # conversion factor both, ymin and ymax, unless you want
                   # different curves in the plot. E.g.
                   # set yrange [1, 10] in meters
                   # set y2range [1/1e3, 10/1e3] in km 
#set xtics add ('0' 0, '1' 1) # "add" is important in log
#set ytics add ('0' 0, '1' 1) # otherwise mx- and mytics disappear
# set my2tics 2 # unset this if second y-axis
#set y2tics ystart,ystep # the first parameter is the starting value at the bottom of the graph, 
                         # and the second is the interval between tics on the axis (optional)
#set ytics nomirror # unset this if second y-axis

# Power styles
# Sometimes this might be bugy
# if used with set logscale xy
# Try to comment it out if strange 
# problems appear
#set format x "$%.0s \\times 10^{%S}$" # Not setting the $$ might lead to
#set format y "$%.0s \\times 10^{%S}$" # problems if using y2
                                       # Another possibility: "$10^{%L}$"

# If you want a factor "x 100" to be multiplying to an axis, define
# set format x "%.0f"
# factorX    = 1000
# set label 1 at graph 1, 0 sprintf("$\\times 10^{%d}$",log10(factorX)) offset 0.6,0.6
# set label 2 at graph 0, 1 sprintf("× 10^{%d}",log10(factorY)) offset 0,0.7
# And then rescale the plot like
# plot $Data u ($1/factorX):($2/factorY) w l

            # ******************** key ******************** #

set key left bottom
#unset key
#set key at X,Y #  X on the right side of the legend  ------ Y
                #  Y at the top of the legend              | X
#set key font ",20" # sets it to 20

            # ******************** labels ******************** #

set xlabel "Xlabel (pc)"
set ylabel "Ylabel ($t^{-1}$)" # offset -1.5,2,0 # moves ylabel -1.5 characters 
                                               # away the x axis, 2 towards y,
                                               # and 0 towards z  
                                               # (relative to its original position)
# set y2label "Y2label ($T^{-1}$)" # offset 0.1,0 # if second y-axis is used

            # ******************** main plot ******************** #

# set samples 1000 # get smoother curves
                   # NB: If using log scale, gnuplot might cut the
                   # curve because of a lack of resolution; make
                   # samples much larger

#set multiplot # uncomment only if you have embedded, smaller plots

plot f(x) title "" with lines ls 1, \
     g(x) title "" with lines ls 2, \
     h(x) title "" with lines ls 3, \
     i(x) title "" with lines ls 4
# Want a power-line? Do this:
#plot f(x) title "" with lines ls 1, \
     # [1:2] 3e4 * x**(-1.75) with lines ls 1 dashtype 3 linewidth 2 title "bo"
     # [rang in x axis] multiplying factor * x**(yourpower) with lines ls 1 dashtype 3 linewidth 2 title "straight line"

# If second y-axis present, then
#plot f(x) title "" with lines ls 1 axis x1y1, \
#     g(x) title "" with lines ls 2 axis x1y1, \
#     h(x) title "" with lines ls 3 axis x1y1, \
#     i(x) title "" with lines ls 4 axis x1y1, \
#     j(x) title "" with lines ls 1 axis x1y2, \
#     k(x) title "" with lines ls 2 axis x1y2, \
#     l(x) title "" with lines ls 3 axis x1y2, \
#     m(x) title "" with lines ls 4 axis x1y2

# Reading data files
# set datafile commentschars { "#" | "%" }
# set datafile separator { "," | whitespace }

            # ******************** embedded, smaller plots (zooms) ******************** #

# You need to uncomment the "set multiplot" line above

# It's better to remove the grid from the larger plot and 
# add only grids to the smaller plots, because they otherwise
# overlap

# Grid
#set style line 102 lc rgb '#808080' lt 0 lw 1
#set grid back ls 102

# Origin
#set origin X,Y              # between [0, 1]
#set size X-length, Y-length # between [0, 1]
#set xrange [xmin:xmax]
#set yrange [ymin:ymax]

# Labels
#unset xlabel
#unset ylabel
#unset label
#set xtics ('1' 1, '2' 2)
#set ytics ('0' 0, '2' 2)

# Format of box and tics
#set tics scale 0.5 front
#set border linewidth 3

# Plot
#plot f(x) title "" with lines ls 1, \
#     g(x) title "" with lines ls 2, \
#     h(x) title "" with lines ls 3, \
#     i(x) title "" with lines ls 4

# After the embedded, smaller plots, we need to unset multiplot
#unset multiplot

            # ******************** back to x11 ******************** #

set terminal x11

            # ******************** dump analytic function to a table ******************** #

# set table "out.dat"
#    plot '+' u (sprintf("%g,%g,%g,%g,%g",x , f(x) , g(x) , h(x) , i(x))) w table
# unset table

            # ******************** use python programmes ******************** #

# You can use python programmes from "outside" which allow you to do more things. 
# One example is the Bessel functions of any order. Gnuplot is limited to first order.
# 
# To defined a new function, simply create a programme.py and call it like this
# 
# bessel(n,x) = real(system(sprintf("python bessel1stkind.py %g %g", n, x)))
# 
# where
# 
# $ cat bessel1stkind.py 
# import sys
# import numpy as np
# from scipy.special import *
# 
# n=float(sys.argv[1])
# x=float(sys.argv[2])
# 
# print (jn(n,x))
# 
# Then simply use it in gnuplot
# 
# gnuplot> print bessel(1,1)
# 0.440050585744934
# gnuplot> print bessel(-2,1)
# 0.114903484931901

            # ******************** style: hints ******************** #

# Some help on style:
# http://en.wikipedia.org/wiki/Wikipedia:How_to_create_charts_for_Wikipedia_articles#gnuplot

# http://en.wikipedia.org/wiki/File:Ps_symbols_color.png
# http://en.wikipedia.org/wiki/File:Ps_symbols_color_solid.png
# http://upload.wikimedia.org/wikipedia/commons/2/2a/Ps_symbols_bw.png

# See also the local files:
# qiv -t ~/treball/documents/manuals/gnuplot/Ps_symbols_color.png
# qiv -t ~/treball/documents/manuals/gnuplot/Ps_symbols_color_solid.png
# qiv -t ~/treball/documents/manuals/gnuplot/Ps_symbols_bw.png

            # ******************** format tics ******************** #

# Some style about format:
# http://lowrank.net/gnuplot/tics-e.html

# gnuplot> set format x "%10.3f"
# 
# The syntax for the digit is "%" + (total length).(precision). The floating
# number 6.2 represents that the total length is six and there are two digits
# following the decimal point, so that tic-labels are shown as "5.00". It is
# possible to omit the length or precision, like 6 or .2. The default values are
# used for the omitted number.
# 
# The display format is expressed by one letter -- 'f', 'e', 'E', 'g', 'x', 'X',
# 'o', 't', 'l', 's', 'T', 'L', 'S', 'c', and 'P'. The default is "%g". When the
# tics-labels can be expressed by appropriate length and precision, those are
# written by "%.0f" format, otherwise "%e" format is used. The next table shows
# the difference among the format 'f', 'e', 'x', and 'o'. The formats 'e' and 'E'
# are the same except that the written text is 'e' or 'E'. The format "%O" exists
# in the gnuplot manual, but it does not work (bug ?) 
# 
# Format Explanation  Example (underscore means blank)
# f      decimal      %6.3f   __6.00
# e,E    exponential  %11.4e  _5.0000e+01
# x,X    hexadecimal  %x      fffffffb
# o,O    octal        %o      37777766 
# 
# The formats, 't', 'l', 'T', and 'L' are related to log-scale plot. 

            # ******************** samples ******************** #

# Gnuplot doesn't really draw curves for functions - it actually computes the
# functions at multiple points and connects them with straight lines, similarly
# to what would happen if you were plotting a data file
# 
# Sometimes when plotting analytical functions which span over many orders of
# magnitude, gnuplot does not have enough resolution, even if you set it to the
# maximum, which is about 8e6. For _one_ curve it should be enough but sometimes
# we are plotting various curves, so that the sampling is divided by the number
# of curves and hence, each curve has a lower sampling. This should be avoided
# because some extreme values might be missing.
# 
# The fix for this is the following
# 
# 1) output to a file with the data
# 
# set table "g.dat"
# 
# 2) Plot each of the curves. If you have the functions g(x), h(x) and i(x),
# 
# set samples 30*number of maxima (as a rule of thumb)
# set table "g.dat"
# plot g(x) 
# unset table
# 
# then
# 
# set table "h.dat"
# plot h(x)
# unset table
# 
# then
# 
# set table "i.dat"
# plot i(x)
# unset table
# 
# After that, in the gnu script you use
# 
# plot "g.dat" u 1:2 with lines ... ,\
#      "h.dat" u 1:2 with lines ... ,\
#      "i.dat" u 1:2 with lines ... ,\
# 
# And this way the functions g(x), h(x) and i(x) will have a higher resolution.
