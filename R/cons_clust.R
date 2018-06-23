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

  ##heatmap(results[[number_of_k]][["consensusMatrix"]],cexRow = 0.5)
  return(results)
}
