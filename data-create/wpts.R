require(RPostgreSQL)
require(rgeos)
require(rgdal)

# get our credentials from our .Rprofile
pepgeo_usr <- getOption('pepgeo_usr')
pepgeo_pwd <- getOption('pepgeo_pwd')
pepgeo_ip <- getOption('pepgeo_ip')

# connect to the PostgreSQL db, pepgeo
conn = dbConnect(
  dbDriver("PostgreSQL"), dbname="pepgeo", host=pepgeo_ip, port="5432", 
  user=pepgeo_usr, password=pepgeo_pwd
)

# create our query to get all waypoints within Iliamna
strSQL <- paste("select objectid,name as wptid,ST_AsText(shape) as wkt_geometry",
                "from richmonde.pvwypts_2014",
                "where stockname = 'Iliamna'")

# pull out the SRID so we can set the proper projection
srid <- dbGetQuery(conn,"SELECT Find_SRID('richmonde','pvwypts_2014','shape')")[1,]
EPSG = make_EPSG()
proj = EPSG[which(EPSG$code == srid), "prj4"]

# get waypoints and store in a df
# we set the rownames to objectid to assist in the rbind later
wpts.df = dbGetQuery(conn,strSQL)
rownames(wpts.df) <- wpts.df$objectid

# create a simple pre-defined list to hold our sp objects
sp.list <- vector(mode="list",length=nrow(wpts.df))

# fill the sp.list with objects created via readWKT in the rgeos package
for (n in 1:length(sp.list)) {
  sp.list[[n]] <- SpatialPoints(readWKT(wpts.df$wkt_geometry[n],
                                        id=wpts.df$objectid[n])) 
}

# rbind all the spatial objects into one
iliamna_waypoints <- do.call("rbind",sp.list)

# create a spdf by merging with the source df
# we'll clean up locs.hf.df, first, to remove uneeded columns
wpts.df <- subset(wpts.df,select = -c(objectid,wkt_geometry))
iliamna_waypoints <- SpatialPointsDataFrame(iliamna_waypoints,wpts.df)
proj4string(iliamna_waypoints) <- CRS(proj)

save(iliamna_waypoints,file = "data/iliamna_waypoints.rdata")
writeOGR(iliamna_waypoints,dsn = "data-open/.geojson",layer="OGRGeoJSON",driver="GeoJSON")
file.rename("data-open/.geojson","data-open/iliamna_waypoints.geojson")
