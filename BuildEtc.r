# Roxygen to create help files
cd "/media/Hitachi2GB/00NMML/RPackages/spPlotSampCourse_package"
R
library(roxygen2)
roxygenize("spPlotSampCourse", roclets = c("namespace","rd"))

# build R package in Linux
cd "/media/Hitachi2GB/00NMML/ActiveRPack/PvIliamna_package/pkg-source"
R CMD build PvIliamna
R CMD INSTALL PvIliamna_1.0.tar.gz

# knitr
cd "/media/Hitachi2GB/00NMML/ActiveRPack/PvIliamna_package/pkg-source/PvIliamna/inst/doc/jknit"
R
library(knitr)
knit("trendPVA.Rnw")


#-------------------------------------------------------------------------------
#                    GITHUB
#-------------------------------------------------------------------------------

#github cloud commits
cd "/media/Hitachi2GB/00NMML/ActiveRPack/PvIliamna_package"
git add .
git commit -a -m 'set up Jays knitr document'
git push github.PvIliamna master
git pull github.PvIliamna master

#to see an earlier version
cd "/media/Hitachi2GB/00NMML/ActiveRPack/PvIliamna_package"
git log splmm.R
git show c742d1026aa031baf9409c0262b5bc944bb736d1:./covParmIni.R

#initializing stuff
cd "/media/Hitachi2GB/00NMML/ActiveRPack/PvIliamna_package"
git init
git config --global jay.verhoef 'Jay Ver Hoef'
git config --global user.email jay.verhoef@noaa.gov
git remote add github.PvIliamna https://github.com/NMML/PvIliamna.git
git clone https://github.com/NMML/PvIliamna.git remote -v
git remote -v

#clean up directory before committing it
cd "/media/Hitachi2GB/00NMML/RPackages/spPlotSampCourse_package"
find . -type f -iname \*~ -delete
