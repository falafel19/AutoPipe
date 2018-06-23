pathway_fgsea<-function(db="c1",number_of_k,clusters_data,topPaths=5){

############################# read gene to pathway lists

  #load("R/sysdata.rda")


  d<-if(db=="c1") c1
  else  d<-if(db=="c2") c2
  else  d<-if(db=="c3") c3
  else  d<-if(db=="c4") c4
  else  d<-if(db=="c5") c5
  else  d<-if(db=="c6") c6
  else  d<-if(db=="c7") c7
  else  d<-if(db=="h")  h
####################################### fgsea

  top_paths<-lapply(1:number_of_k, function(i){
    cluster_stats<-as.data.frame(clusters_data[[i]])
    stats<-(cluster_stats[,1])
    names(stats)<-rownames(cluster_stats)
    fgseaRes<-fgsea::fgsea(pathways = d,stats = stats,
                           minSize=15,
                           maxSize=500,
                           nperm=1000)

    topPathwaysUp <- fgseaRes[fgseaRes$ES > 0,]
    topPathways <-topPathwaysUp[utils::head(order(topPathwaysUp$pval), n=topPaths), c("pathway","ES","pval")]
    topPathways<-topPathways[order(topPathways$ES),]

  })

  return(top_paths)
}
