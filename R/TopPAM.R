#' Compute Top genes
#'
#' This function computes the n=TOP genes and the the best number of clusters
#'
#' @export TopPAM
#' @usage TopPAM(me, max_clusters=15,TOP=1000)
#' @param me a matrix with genes in rows and samples in columns
#' @param max_clusters max. number of clusters to check
#' @param TOP the number of genes to take
#'
#' @return a list of 1. A matrix with the top genes
#' 2. A list of means of the Silhouette width for each number of clusters. 3. The optimal number of clusters
#'
#' @examples
#' ##load the org.Hs.eg Library
#' library(org.Hs.eg.db)
#' #' ## load data
#' data(rna)
#' me_x=rna
#' res<-nchAnalysis::TopPAM(me_x,max_clusters = 8, TOP=1000)
#' me_TOP=res[[1]]
#' number_of_k=res[[3]]
#'
TopPAM=function(me, max_clusters=15,TOP=1000){
  #Top 1000
  dim(me)
  sd=as.data.frame(apply(me,1, function(x){sd(x)}))
  sd=as.data.frame(sd[order(sd[,1], decreasing = T), ,drop = FALSE])
  me_TOP=me[rownames(sd)[1:TOP], ]
  dim(me_TOP)

  #Do Cluster PAM
  #How many clusters
  sil_mean=as.numeric(do.call(cbind, lapply(2:max_clusters, function(i){
    pamx <- cluster::pam(t(me_TOP), k=i)
    si <- cluster::silhouette(pamx)
    mean_s=mean(as.numeric(si[,3]))
    return(mean_s)
  })))
  graphics::plot(sil_mean, type = "l", xaxt = "n", bty="n")
  graphics::axis(1, 1:14, seq(2,15,by=1))
  graphics::points(sil_mean, col="red", pch=20)
  graphics::abline(v=which.max(sil_mean), lty=3)
  return(list(me_TOP,sil_mean,which.max(sil_mean)+1))
}
