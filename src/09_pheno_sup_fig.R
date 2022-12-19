library(tidyverse)
library(gridExtra)

# Read in files 
cpepo <- read.csv("data/02_pheno/data/cpepo_coded.csv", stringsAsFactors=F)
cmos <- read.csv("data/02_pheno/data/cmoschata_coded.csv", stringsAsFactors=F)
cmax <- read.csv("data/02_pheno/data/cmaxima_coded.csv", stringsAsFactors=F)

# Make figure per species
pepoKeep <- c("seed_wt", "max_vig", "min_vig",
	      "max_width", "width_min", "len_max",
	      "len_min", "flesh_max", "flesh_min",
	      "sb_nymph", "sb_adult",
	      "cuc_inj")
cpepo <- cpepo[,pepoKeep]
cpepoSub <- gather(cpepo)

mosKeep <- c("fruit_len", "fruit_diam") 
cmosSub <- gather(cmos[,mosKeep])

maxKeep <- c("len", "set", "diam", "watermelon_mosaic",
             "cuc_mosaic", "maturity", "unif", "pm",
              "vig", "rib", "fruit_spot")
cmaxSub <- gather(cmax[,maxKeep])

# Make figues
cpepo.plt <- ggplot(cpepoSub, aes(x=value)) +
	          geom_histogram() +
		  facet_wrap(~key, nrow=2, scales="free") +
		  ylab("Count") +
		  xlab("C. pepo") +
		  ggtitle("a.") +
		  theme_bw(base_size=18) +
		  theme(panel.background=element_blank(),
		        panel.grid=element_blank(),
		        plot.title=element_text(face="bold"),
		        axis.title.x=element_text(face="italic"))	
	

cmos.plt <- ggplot(cmosSub, aes(x=value)) +
                  geom_histogram() +
                  facet_wrap(~key, nrow=1, scales="free") +
                  ylab("Count") +
                  xlab("C. moschata") +
                  ggtitle("b.") +
                  theme_bw(base_size=18) +
                  theme(panel.background=element_blank(),
                        panel.grid=element_blank(),
		        plot.title=element_text(face="bold"),
		        axis.title.x=element_text(face="italic"))	

cmax.plt <- ggplot(cmaxSub, aes(x=value)) +
                  geom_histogram() +
                  facet_wrap(~key, nrow=3, scales="free") +
                  ylab("Count") +
                  xlab("C. maxima") +
                  ggtitle("c.") +
                  theme_bw(base_size=18) +
                  theme(panel.background=element_blank(),
                        panel.grid=element_blank(),
		        plot.title=element_text(face="bold"),
		        axis.title.x=element_text(face="italic"))	

fin.plt <- grid.arrange(cpepo.plt, cmos.plt, cmax.plt,
	     layout_matrix=rbind(c(1,1),
				 c(1,1),
				 c(1,1),
				 c(2,2),
				 c(2,2),
				 c(3,3),
				 c(3,3),
				 c(3,3),
				 c(3,3)))
ggsave("supplemental/04_supfig.png", fin.plt, "png", width=10, height=12)
