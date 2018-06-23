### produce data for  pathway analysis
c1<-qusage::read.gmt("R/msigdb/c1.all.v6.1.entrez.gmt")

c2<-qusage::read.gmt("R/msigdb/c2.all.v6.1.entrez.gmt")

c3<-qusage::read.gmt("R/msigdb/c3.all.v6.1.entrez.gmt")

c4<-qusage::read.gmt("R/msigdb/c4.all.v6.1.entrez.gmt")

c5<-qusage::read.gmt("R/msigdb/c5.all.v6.1.entrez.gmt")

c6<-qusage::read.gmt("R/msigdb/c6.all.v6.1.entrez.gmt")

c7<-qusage::read.gmt("R/msigdb/c7.all.v6.1.entrez.gmt")

h<-qusage::read.gmt("R/msigdb/h.all.v6.1.entrez.gmt")


devtools::use_data(c1,c2,c3,
                   c4,c5,c6,
                   c7,h, internal = TRUE,overwrite = T)

remove(c1,c2,c3,
       c4,c5,c6,
       c7,h)
