library(readr)
Park_Gene_Markers <- read_csv("Park_Gene_Markers.csv")
colnames(Park_Gene_Markers)[colnames(Park_Gene_Markers)=="Name"] <- "HGNC Symbol"
Park_Gene_Markers$`HGNC Symbol` <- toupper(Park_Gene_Markers$`HGNC Symbol`)
View(Park_Gene_Markers)


library(readr)
ensemblIDsPark_Markers <- read_csv("ensemblIDsPark_Markers.csv")
View(ensemblIDsPark_Markers)
colnames(ensemblIDsPark_Markers)[colnames(ensemblIDsPark_Markers)=="Gene stable ID"] <- "Ensembl"


View(merge(ensemblIDsPark_Markers, Park_Gene_Markers))
## I am adding some stuff
