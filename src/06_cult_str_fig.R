library(tidyverse)
library(gridExtra)


# Read in files
cpepo <- read.table("data/03_geno/data/admix/cpepo/cpepo_admix_cult.10.Q", sep=" ", header=F)
cpepoLab <- read_delim("data/03_geno/data/admix/cpepo/cpepo_admix_cult.fam" , delim=" ", col_names=F)[,1]
cpepo$name <- cpepoLab[[1]]
cpepoMeta <- read.csv("data/01_meta/data/cpepo_classifications.csv")
cpepo <- merge(cpepo, cpepoMeta, by="name")
cpepoLg <- gather(cpepo, pop, value, -name, -class)

cmos <- read.table("data/03_geno/data/admix/cmoschata/cmoschata_admix_cult.6.Q", sep=" ", header=F)
cmosLab <- read_delim("data/03_geno/data/admix/cmoschata/cmoschata_admix_cult.fam" , delim=" ", col_names=F)[,1]
cmos$name <- cmosLab[[1]]
cmosMeta <- read.csv("data/01_meta/data/cmoschata_classifications.csv")
cmos <- merge(cmos, cmosMeta, by="name")
cmosLg <- gather(cmos, pop, value, -name, -class)

cmax <- read.table("data/03_geno/data/admix/cmaxima/cmaxima_admix_cult.6.Q", sep=" ", header=F)
cmaxLab <- read_delim("data/03_geno/data/admix/cmaxima/cmaxima_admix_cult.fam" , delim=" ", col_names=F)[,1]
cmax$name <- cmaxLab[[1]]
cmaxMeta <- read.csv("data/01_meta/data/cmaxima_classifications.csv")
cmax <- merge(cmax, cmaxMeta, by="name")
cmaxLg <- gather(cmax, pop, value, -name, -class)

# Create plot
cpepoLg$class <- factor(cpepoLg$class, 
		      levels=c("Acorn", "Scallop", "Crook",
			      "Pumpkin", "Zucchini", "Marrow",
			      "Gem", "Spaghetti"))
cpepo.plt <- ggplot(cpepoLg) +
	       geom_bar(aes(x=name, y=value, fill=pop),
			    stat="identity",
			    width=1) +
               scale_fill_brewer(palette="Set3") +
	       xlab("") + ylab("C. pepo") +
	       facet_wrap(~class, scales="free", nrow=1) +
	       theme_bw(base_size=18) +
	       theme(panel.background=element_blank(),
		     panel.grid=element_blank(),
		     axis.text=element_blank(),
		     axis.ticks=element_blank(),
	             legend.position="none") 

cmosLg$class <- factor(cmosLg$class,
		       levels=c("Neck", "Cheese", "Japonica",
				"Calabaza"))
cmos.plt <- ggplot(cmosLg) +
	       geom_bar(aes(x=name, y=value, fill=pop),
			    stat="identity",
			    width=1) +
               xlab("") + ylab("C. moschata") +
               scale_fill_brewer(palette="Set3") +
	       facet_wrap(~class, scales="free", nrow=1) +
	       theme_bw(base_size=18) +
	       theme(panel.background=element_blank(),
		     panel.grid=element_blank(),
		     axis.text=element_blank(),
		     axis.ticks=element_blank(),
	             legend.position="none") 

cmaxLg$class <- factor(cmaxLg$class,
		       levels=c("Buttercup", "Kobocha", "Kuri",
				"Hubbard", "Australian", "Show"))
cmax.plt <- ggplot(cmaxLg) +
	       geom_bar(aes(x=name, y=value, fill=pop),
			    stat="identity",
			    width=1) +
               xlab("") + ylab("C. maxima") +
               scale_fill_brewer(palette="Set3") +
	       facet_wrap(~class, scales="free", nrow=1) +
	       theme_bw(base_size=18) +
	       theme(panel.background=element_blank(),
		     panel.grid=element_blank(),
		     axis.text=element_blank(),
		     axis.ticks=element_blank(),
	             legend.position="none") 

comb.plt <- grid.arrange(cpepo.plt, cmos.plt, cmax.plt)

ggsave("figures/03_fig.png", comb.plt, width=10)
