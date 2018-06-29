#' @export cons_clust
#' @example print("Test)
########Consensus Clustering
cons_clust<-function(data,max_clust,TOPgenes){
  geneset<-data
  dim(geneset)
  mads=apply(geneset,1,stats::mad)
  geneset=geneset[rev(order(mads))[1:TOPgenes],]
  geneset= sweep(geneset,1, apply(geneset,1,stats::median,na.rm=T))
  title=tempdir()
  results = ConsensusClusterPlus::ConsensusClusterPlus(as.matrix(geneset),maxK=max_clust,reps=50,pItem=0.8,pFeature=1,
                                 title=title,clusterAlg="hc",distance="pearson",
                                 plot="png")

  aa=seq(1,max_clust, by=1)
  length(aa)=suppressWarnings(prod(dim(matrix(aa,ncol = 3))))
  aa[is.na(aa)]=0
  lm=matrix(aa, ncol=3, byrow = T)
  layout(lm, c(1),c(1))

  for(i in 2:max_clust){
      xx=as.matrix(results[[i]][["consensusMatrix"]])
      nc=ncol(xx)
      nr=nrow(xx)
      xx <- sweep(xx, 1L, rowMeans(xx, na.rm = T), check.margin = FALSE)
      sx <- apply(xx, 1L, stats::sd, na.rm = T)
      xx <- sweep(xx, 1L, sx, "/", check.margin = FALSE)
      xx<-t(xx)
      graphics::par(mar = c(1, 3, 0, 0))
      graphics::image(1L:nc, 1L:nr, xx, xlim = 0.5 + c(0, nc), ylim = 0.5 +
                         c(0, nr), axes = FALSE, xlab = "", ylab = "", col=RColorBrewer::brewer.pal(n = 11, "Spectral"),useRaster=T)
      graphics::title(main=paste("Cluster",i))

    }


  return(results)
}
