


qlog10 <- function(p){
     # Calculates theoretical distribution of p-values
    theoretical <- rank(p)/length(p)
    return(-log10(theoretical))
}


get_manhatten_axis <-function(map){
    # Gets x-axis breaks and labels for Manhatten plot
    breaks <- c()
    labels <- c()
    for(c in unique(map$chrom)){
        labels <- c(labels, c)
        breaks <- c(breaks,  mean(c(min(map[map$chrom == c, "index"]),
                     max(map[map$chrom == c,"index"]))))
    }
     return(list(breaks=breaks, labels=labels))    	
}


log_effect <- function(data){
    mat <- matrix(c(1,1,1,0,1,2), ncol=2)
    fit.m0 <- glm(data[,1] ~ 1)
    fit <- glm(data[,1] ~ data[,2], family="binomial")
    val <- mat %*% as.matrix(coef(fit))
    prob <- exp(val)/(1+exp(val))
    R <- 1-(logLik(fit)[1]/logLik(fit.m0)[1])
    return(list(prob, R))
}


genesis_man <- function(assoc, label, col=c("#B31B1B", "#7D868C")){
    colnames(assoc)[2] <- "chrom"
    assoc$index <- 1:nrow(assoc)
    exp <- qlog10(assoc$Score.pval)
    assoc$log <- -log10(assoc$Score.pval)
    axis <- get_manhatten_axis(assoc)
    n.chrom <- length(unique(assoc$chrom))
    sig.thresh <- -log10(0.05/nrow(assoc))
    manhatten <- ggplot2::ggplot(assoc, aes(x=index, y=log, col=factor(chrom, levels=0:20))) +
    	                         geom_point() +
    	                         scale_colour_manual(values=rep(col, 
    	                                             ceiling(n.chrom/2))[1:n.chrom]) +
    	                         scale_x_continuous(labels=axis$labels, breaks=axis$breaks) +
    	                         xlab("") + ylab("") +
    	                         ggtitle(label) +
    	                         theme_bw(base_size=20) +
    	                         theme(panel.grid=element_blank(),
    	                         plot.title=element_text(hjust=0.5),
    	                         legend.position="none",
    	                         axis.text.y=element_text(face="bold"),
    	                         axis.text.x=element_blank())
    if(max(assoc$log) > sig.thresh){  # Add significance line if there are points above threshold
    	manhatten <- manhatten + geom_hline(yintercept=sig.thresh, color="blue")
    }
    qq.plot <- ggplot2::ggplot(data.frame(act=assoc$log, exp=exp), aes(x=exp, y=act)) +
	                           geom_point() +
	                           geom_abline(intercept=0, slope=1, color="red") +
	                           xlab("") + ylab("") +
				   ggtitle(label) +
	                           theme_bw(base_size=16) +
	                           theme(panel.grid=element_blank(),
				         plot.title=element_text(hjust=0.5))
    return(list(res=assoc, man=manhatten, qq=qq.plot))	                   
}

