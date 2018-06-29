#' Unsupervised Clustering
#'
#' A function for unsupervised Clustering of the data
#'
#' @usage UnSuperClassifier(data,clinical_data=NULL)
#' @export UnSuperClassifier
#'
#' @param data the data for the clustering. Data should be in the following format: samples in columns and
#' the genes in the rows (colnames and rownames accordingly). The rownames should be Entrez ID in order to
#' plot a gene set enrichment analysis.
#' @param clinical_data the clinical data provided by the user to plot under the heatmap. it will be
#'  plotted only if show_clin is TRUE. Default value is NULL. see details for format.
#'  @details sample data should be a data.frame with the sample names
#'  as rownames and the clinical triats as columns.
#'   each trait must be a numeric variable.
UnSuperClassifier<-function(data,clinical_data=NULL,thr=2,TOP_Cluster=150){
  res<-nchAnalysis::TopPAM(data,max_clusters = 8, TOP=1000)
  me_TOP=res[[1]]
  dim(me_TOP)
  #-> Wähle Nr of Cluster
  number_of_k=res[[3]]
  File_genes=Groups_Sup(me_TOP, me=data, number_of_k,TRw=-1)

  groups_men=File_genes[[2]]
  if(is.null(clinical_data)){
    o_g<-Supervised_Cluster_Heatmap(groups_men = groups_men, gene_matrix=File_genes[[1]],TOP_Cluster=TOP_Cluster,
                                    method="PAMR",show_sil=TRUE,threshold = thr
                                    ,print_genes=T,TOP = 1000,GSE=T,plot_mean_sil=T,sil_mean=res[[2]])
  }
  else{
    o_g<-Supervised_Cluster_Heatmap(groups_men = groups_men, gene_matrix=File_genes[[1]],threshold=thr,TOP_Cluster=TOP_Cluster,
                                    method="PAMR",show_clin =TRUE,show_sil=TRUE,samples_data = clinical_data
                                    ,print_genes=T,TOP = 1000,GSE=T,plot_mean_sil=T,sil_mean=res[[2]])

  }
}
