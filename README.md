PvIliamna
=========

Executive Summary
-----------------

The PvIliamna repository is an R package and collection of data files and information related
to historical, aerial surveys of harbor seals (*Phoca vitulina richardii*) in Lake Iliamna, Alaska, USA.

Data Under-Development
----------------------

These data are currently under active development and should not be cited or used for any analysis without first communicating with Josh London at the NOAA National Marine Mammal Laboratory. Once development is complete, data and compliant metadata will be archived and available from the National Ocean Data Center. 

R Data Package Install
----------------------

The R data package can be installed via `devtools` and the `install_github()` function

```r
install.packages("devtools")
devtools::install_github("PvIliamna", "NMML")
```

A develop branch is maintained for active development of this repository. To install the develop branch instead of the master (default), add `ref="develop"`

```r
install.packages("devtools")
devtools::install_github("PvIliamna", "NMML", ref="develop")
```

Data Sources
------------

Data included in this repository were provided by
* NOAA Alaska Fisheries Science Center National Marine Mammal Laboratory
* Alaska Department of Fish & Game
* Pebble Partnership
* Ole Mathisen, Thomas Kline and the University of Alaska Fairbanks
* University of Washington School of Aquatic & Fishery Sciences

Full Data Citations
-------------------

TODO: Add full data citations for the above data sources
