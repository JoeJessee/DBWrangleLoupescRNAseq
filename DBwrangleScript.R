library(readr)
Park_Gene_Markers <- read_csv("Park_Gene_Markers.csv")
colnames(Park_Gene_Markers)[colnames(Park_Gene_Markers)=="Name"] <- "HGNC Symbol"
Park_Gene_Markers$`HGNC Symbol` <- toupper(Park_Gene_Markers$`HGNC Symbol`)
View(Park_Gene_Markers)


library(readr)
ensemblIDsPark_Markers <- read_csv("ensemblIDsPark_Markers.csv")
View(ensemblIDsPark_Markers)
colnames(ensemblIDsPark_Markers)[colnames(ensemblIDsPark_Markers)=="Gene stable ID"] <- "Ensembl"

Park_HGNC <- Park_Gene_Markers[,"HGNC Symbol"]
# View(Park_HGNC)

## Use biomaRt to get both hgnc and ensembl ID's
## For reference: attibute numbers for hgnc_symbol =62, ensembl_id = 1
Park_IDs <- getBM(attributes = c("ensembl_gene_id", "hgnc_symbol"),
      filters = "hgnc_symbol",
      values = Park_HGNC,
      mart = ensembl)
# re-name the columns in the Park_Gene_Markers df to make them match the biomaRt query
names(Park_Gene_Markers)[names(Park_Gene_Markers)=="barcode"] <- "List"
names(Park_Gene_Markers)[names(Park_Gene_Markers)=="HGNC Symbol"] <- "hgnc_symbol"

#merge the newly matching df's
merge(Park_IDs, Park_Gene_Markers)
#View(merge(Park_IDs, Park_Gene_Markers))
## SUCCESS
Park_list_for_Loupe <- merge(Park_IDs, Park_Gene_Markers)
View(Park_list_for_Loupe)

# reorder columns and format to look like the AMLBloodCell.csv vignette
Park_list_for_Loupe <- Park_list_for_Loupe[c(3,1,2)]
names(Park_list_for_Loupe)[names(Park_list_for_Loupe)=="hgnc_symbol"] <- "Name"
names(Park_list_for_Loupe)[names(Park_list_for_Loupe)=="ensembl_gene_id"] <- "Ensembl"

# Create CSV of final product
write.csv(Park_list_for_Loupe, "Park_list_for_Loupe.csv", row.names = FALSE)

