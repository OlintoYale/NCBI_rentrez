# NCBI_rentrez

A series of scripts to donwload/load fasta sequences from/to NCBI


Search the NCBI databases using rentrez (R)


#' Search a given NCBI database with a particular query.
#'
The NCBI uses a search term syntax where search terms can be associated with 
#' a specific search field with square brackets. So, for instance ``Homo[ORGN]''
#' denotes a search for Homo in the ``Organism'' field. The names and
#' definitions of these fields can be identified using
#' \code{\link{entrez_db_searchable}}.
#'
#' Searches can make use of several fields by combining them via the boolean
#' operators AND, OR and NOT. So, using the search term``((Homo[ORGN] AND APP[GENE]) NOT
#' Review[PTYP])'' in PubMed would identify articles matching the gene APP in
#' humans, and exclude review articles. More examples of the use of these search
#' terms, and the more specific MeSH terms for precise searching, 
#' is given in the package vignette. \code{rentrez} handles special characters
#' and URL encoding (e.g. replacing spaces with plus signs) on the client side,
#' so there is no need to include these in search term
#'
#' The\code{rentrez} tutorial provides some tips on how to make the most of 
#' searches to the NCBI. In particular, the sections on uses of the "Filter"
#' field and MeSH terms may in formulating precise searches. 
#' 
#'@export
#'@param db character, name of the database to search for.
#'@param term character, the search term. The syntax used in making these
#'searches is described in the Details of this help message, the package
#'vignette and reference given below.
#'@param use_history logical. If TRUE return a web_history object for use in 
#' later calls to the NCBI
#'@param retmode character, one of json (default) or xml. This will make no
#' difference in most cases.
#'@param \dots character, additional terms to add to the request, see NCBI
#'documentation linked to in references for a complete list
#'@param config vector configuration options passed to httr::GET  
#'@seealso \code{\link[httr]{config}} for available httr configurations 
#'@seealso \code{\link{entrez_db_searchable}} to get a set of search fields that
#' can be used in \code{term} for any database
#'@return ids integer Unique IDS returned by the search
#'@return count integer Total number of hits for the search
#'@return retmax integer Maximum number of hits returned by the search
#'@return web_history A web_history object for use in subsequent calls to NCBI
#'@return QueryTranslation character, search term as the NCBI interpreted it
#'@return file either and XMLInternalDocument xml file resulting from search, parsed with
#'\code{\link[XML]{xmlTreeParse}} or, if \code{retmode} was set to json a list
#' resulting from the returned JSON file being parsed with
#' \code{\link[jsonlite]{fromJSON}}.
#'@references \url{https://www.ncbi.nlm.nih.gov/books/NBK25499/#_chapter4_ESearch_} 
#'@examples
