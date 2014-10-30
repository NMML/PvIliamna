PvIliamna: An R package of data related to harbor seal counts in Lake Iliamna, Alaska
=====================================================================================

This R data package was created in support of the following manuscript

> Ver Hoef, Jay M., P.L. Boveng, D.E. Withrow, and J.M. London. TBD. A Bayesian Analysis of Abundance, Trend and Population Viability for Harbor Seals in Iliamna Lake, Alaska.
(currently in prep/review; updated citation and DOI will be provided when published)

This R data package and associated vignette document should be cited as

> London, Josh M., K.M. Yano, and D.E. Withrow. 2014. PvIliamna: An R package of data related to harbor seal counts in Lake Iliamna, Alaska.

Executive Summary
-----------------

This R data package provides an interface for accessing harbor seal aerial survey data from Iliamna Lake, Alaska, USA. The data have been collated from three previously published sources [@Mathisen1992Har; @Small2001Aer; @ABR2011Cha] and newly available data from the NOAA National Marine Mammal Laboratory. The survey years range between 1984 and 2013. Counts are reported as summed totals across all identified waypoints in the lake for each survey date. In addition, the package provides a *SpatialPointsDataFrame* of all identified harbor seal waypoints in the lake. These waypoints have been collated across all of the surveys into a naming scheme consistent with current NMML Alaska statewide harbor seal protocols.

Data Availability
----------------------

This R package and the data within it are publicly available and intended to be compliant with OMB memorandum [M-13-13 “Open Data Policy-Managing Information as an Asset.”](http://project-open-data.github.io/policy-memo/). The package is currently in development in support of the referenced Ver Hoef et al manuscript (and corresponding analysis package). During this time, the R package source code (of which this vignette is a component) is available at [https://github.com/NMML/PvIliamna](https://github.com/NMML/PvIliamna). Just prior to submitting the manuscript for review, a release will be created within the GitHub repository and archived at [figshare](http://figshare.com). At this time a digital object identifier (DOI) will also be minted.

Within the repository, the directory *data-open* provides open and accesible versions of the data in the form of a comma-separated plain text file and a geoJSON file ([iliamna_totalcounts.csv](https://github.com/NMML/PvIliamna/blob/master/data-open/iliamna_totalcounts.csv); [iliamna_waypoints.geojson](https://github.com/NMML/PvIliamna/blob/master/data-open/iliamna_waypoints.geojson)). We plan to archived these open formats at a NOAA data center and make them available for direct download.

Compliant [Common Core metadata](http://project-open-data.github.io/schema/) is available within the package via

```{r metadata-print, eval=FALSE}
library(rjsonlite)
fromJSON(system.file("metadata", "PvIliamna_CommonCore.json", package="PvIliamna"))
```



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
* ABR Inc. Environmental Research & Services
* Ole Mathisen, Thomas Kline and the University of Alaska Fairbanks
* Newhalen Tribal Council

Full Data Citations
-------------------

ABR Inc. Environmental Research & Services. 2011. Chapter 16. Wildlife and Habitat, Bristol Bay Drainages. Book. Pebble Project Environmental Baseline Document 2004 Through 2008. Anchorage, AK: The Pebble Partnership. http://www.pebbleresearch.com/download/.

Mathisen, Ole A., and Thomas C. Kline. 1992. “Harbor Seals in Iliamna Lake, Bristol Bay, Alaska.” Report JCFOS 9204. Juneau Center for Fisheries; Ocean Sciences, University of Alaska Fairbanks.

Small, Robert J. 2001. “Aerial Surveys of Harbor Seals in Southern Bristol Bay, Alaska, 1998-1999.” Book Section. In Harbor Seal Investigations in Alaska, Annual Report. NOAA Grant NA87FX0300, 71–83. Anchorage, AK: Alaska Department of Fish & Game.

Newhalen Tribal Council. Iliamna Harbor Seal Survey Counts, 2009 (raw data provided to NOAA/NMML). PO Box 207 Newhalen, AK. (907) 571-1410. newhalentribal@yahoo.com.
