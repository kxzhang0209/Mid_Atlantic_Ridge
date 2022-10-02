#!/bin/bash
#To plot 1D profile of T, Q, V, viscosity using GMT
gmt psbasemap -R0/1700/0/200 -JX9c/-16c -Bxa500f100+l"temperature(°C)" -Bya25f50+l"depth(km)" -BWSne+t"temperature profile for 1Ma" -P -K -V > Temp_compare_1Ma.ps
gawk '{print $2, $1}' Temp_aspect.txt | gmt psxy -R -JX -W1.5,red -P -O -K -V  >> Temp_compare_1Ma.ps
gawk '{print $2, $1}' Temperature_Don.txt | gmt psxy -R -JX -W1.5,blue -P -O -K -V  >> Temp_compare_1Ma.ps
gawk '{print $2, $1}' solidus.txt | gmt psxy -R -JX -W1.2 -P -O -V  >> Temp_compare_1Ma.ps
echo "Temp.ps"

gmt psbasemap -R0.0/0.03/0/200 -JX9c/-16c -Bxa0.01f0.005+l"Attenuation" -Bya25f25+l"depth(km)" -BWSen+t"Attenuation profile for 1Ma" -P -K -V > att_compare_1Ma.ps
gawk '{print $2, $1}' Q_aspect.txt | gmt psxy -R -JX -W1.5,red -P -O -K -V >> att_compare_1Ma.ps
gawk '{print $2, $1}' Q_Don.txt | gmt psxy -R -JX -W1.5,blue -P -O -V >> att_compare_1Ma.ps
echo "att.ps"
 
gmt psbasemap -R4/5/0/200 -JX9c/-16c -Bxa0.25f0.05+l"shear velocity(km/s)" -Bya25f50+l"depth(km)" -BWSen+t"Vs profile for 1Ma" -P -K -V > Vs_compare_1Ma.ps
gawk '{print $2,$1}' Vs_aspect.txt | gmt psxy -R -JX -W1.5,red -P -O -K -V >> Vs_compare_1Ma.ps
gawk '{print $2,$1}' Vs_Don.txt | gmt psxy -R -JX -W1.5,blue -P -O -V >> Vs_compare_1Ma.ps
echo "Vs.ps"

gmt psbasemap -R1.0E+18/1.0E+24/0/200 -JX9cl/-16c -Bya25f50+l"depth(km)" -Bxa1f2l+l"Viscosity(log)" -BWSen+t"Viscosity profile for 1Ma" -K -P -V > Visco_compare_1Ma.ps
#gmt psbasemap -R1e+19/1e+23/0/200 -JX9c/-16c -Bx1e22f1e22 -By50f25 -B+t"viscosity profilefor 5Ma" -P -K -V > viscosity_pre_5Ma.ps
gawk '{print $2,$1}' Viscosity-Yamauchi_aspect.txt | gmt psxy -R -JX -W1.5,red -K -P -O -V >> Visco_compare_1Ma.ps
gawk '{print $2,$1}' Viscosity-Yamauchi_Don.txt | gmt psxy -R -JX -W1.5,blue -P -O -V >> Visco_compare_1Ma.ps
echo "Visco.ps"
