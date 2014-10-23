#' Convert a valid YAML document to JSON
#' 
#' @name yaml2json
#' @param yaml_in file path to yaml input file
#' @param json_out file path to json output file
library(yaml)
library(jsonlite)
yaml2json <- function(yaml_in, json_out) {
  writeLines(toJSON(yaml.load_file(yaml_in),pretty=TRUE),json_out)
  }
