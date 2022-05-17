
traits <- read.csv("tables/trait_descriptions.csv")
tbl <- knitr::kable(traits)
con=file("tables/03_tbl.md")
writeLines(tbl,con)
close(con)

