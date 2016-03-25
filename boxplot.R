library(outliers)
emit_99<-subset(Em_dat[,4], Em_dat$year=="1999")
emit_02<-subset(Em_dat[,4], Em_dat$year=="2002")
emit_05<-subset(Em_dat[,4], Em_dat$year=="2005")
emit_08<-subset(Em_dat[,4], Em_dat$year=="2008")
out_99<-which(outlier(emit_99, logical = TRUE)==TRUE,arr.ind=TRUE)
out_02<-which(outlier(emit_02, logical = TRUE)==TRUE,arr.ind=TRUE)
out_05<-which(outlier(emit_05, logical = TRUE)==TRUE,arr.ind=TRUE)
out_08<-which(outlier(emit_08, logical = TRUE)==TRUE,arr.ind=TRUE)

emit_99<-emit_99[-out_99]
emit_02<-emit_02[-out_02]
emit_05<-emit_05[-out_05]
emit_08<-emit_08[-out_08]