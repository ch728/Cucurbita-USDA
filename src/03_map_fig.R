library(tidyverse)
library(scatterpie)
library(ggmap)
library(maps)

# Read in files and get map
mapWorld <- map_data("world")
mapWorld <- filter(mapWorld, region != "Antarctica")
pepoMeta <- read_delim("data/01_meta/data/cpepo_manifest.tsv", delim="\t")
mosMeta <- read_delim("data/01_meta/data/cmoschata_manifest.tsv", delim="\t")
maxMeta <- read_delim("data/01_meta/data/cmaxima_manifest.tsv", delim="\t")

# Combine and filter
pepoMeta$species <- rep("C. pepo", nrow(pepoMeta))
mosMeta$species <- rep("C. moschata", nrow(mosMeta))
maxMeta$species <- rep("C. maxima", nrow(maxMeta))
all <- rbind(pepoMeta, mosMeta, maxMeta)
all$country <- gsub("United States", "USA", all$country)
all$country <- gsub("Korea", "South Korea", all$country)
all$country <- gsub("Russian Federation", "Russia", all$country)
all$country[grepl("Greece", all$country)] <- "Greece"
all$country <- gsub("United Kingdom", "UK", all$country)
all$country <- gsub("Macedonia", "Greece", all$country)
all$country <- gsub("Eswatini", "Swaziland", all$country)
all <- filter(all, country %in% mapWorld$region)

# Set up pie chart data
pie_data <- spread(as.data.frame(table(all[,c("country", "species")])), species, Freq)
pie_data$radius <- rowSums(pie_data[,2:4])
pie_data$radius <- sqrt(log2(pie_data$radius +1) *2)
for(r in 1:nrow(pie_data)){
	pie_data[r,c(2:4)] <- pie_data[r,c(2:4)]/sum(pie_data[r,c(2:4)])
}
coord <- data.frame()
for(c in pie_data$country){
	tmp <- filter(mapWorld, region == c)
	coord <- rbind(coord, data.frame(long=mean(tmp[,"long"]), lat=mean(tmp[,"lat"])))
}

pie_data <- cbind(pie_data, coord)
pie_data[pie_data$country == "USA", 6:7] <- c(-100, 38)
pie_data[pie_data$country == "Canada", 6:7] <- c(-103, 53)

# Make map plot
map <- ggplot() +
            geom_map(data=mapWorld, map=mapWorld,
                     aes(map_id=region, x=long, y=lat),
                     fill="white", colour="black") +
            geom_scatterpie(aes(x=long, y=lat, group=country, r=radius), pie_data,
                            cols=c("C. pepo", "C. moschata", "C. maxima"),
                            color=NA, alpha=0.8) + 
            theme_bw() +
            theme(legend.position="bottom",
                  legend.text=element_text(size=18, face="italic"),
                  legend.spacing.x=unit(0.5, "cm"),
                  legend.box.margin=margin(b=20),
	          panel.grid=element_blank(),
	          axis.text=element_blank(),
	          axis.ticks=element_blank(),
	          axis.title=element_blank(),
	          axis.line=element_blank())
ggsave("final_figures/01_fig.jpeg", map, "jpeg", width=12, height=6)

