

cont.na.list <- list(Motor_power = c(NA, -8), Flow = c(NA, -8))

u = sort(unique(df9$Abbott_ID))

syn_data_ca<-data.frame()
for (k in 1:length(u)) {
  
  
  df_ori<- df9[df9$Abbott_ID==u[k], 
                           c("Abbott_ID", "Motor_power", "Flow", "norm_speed", "HCT")]
  
  synth.obj <- syn(df_ori,  seed = 42,
                   cont.na = cont.na.list)
  
  
  syn_data_ca<- rbind(syn_data_ca,synth.obj$syn )
}



u = sort(unique(pws_patient$Abbott_ID))

syn_data_pws<-data.frame()
for (k in 1:length(u)) {
  
  
  df_ori<- pws_patient[pws_patient$Abbott_ID==u[k], 
                           c("Abbott_ID", "Motor_power", "Flow", "norm_speed", "HCT")]
  
  synth.obj <- syn(df_ori,  seed = 42,
                   cont.na = cont.na.list)
  
  
  syn_data_pws<- rbind(syn_data_pws,synth.obj$syn )
}
write.csv(syn_data_pws, "syn_pws.csv")
write.csv(syn_data_ca, "syn_ca.csv")


# compare(synth.obj, non_pws_patient[, c("Abbott_ID", "Motor_power", "Flow")], 
#         nrow = 2, ncol = 2, cols = c("darkmagenta", "turquoise"))

start_date <- as.Date("2018/01/01") 

syn_data_ca<-syn_data_ca%>%
  group_by(Abbott_ID)%>%
  mutate(Datetime = seq(start_date, by = "day", length.out = n()))

syn_data_pws<-read.csv("/Users/Moaze002/OneDrive - Universiteit Utrecht/CODING/LME + LVAD/PRECISION-LVAD published code/PRECISION-LVAD public code/syn_pws.csv")
syn_data_pws<-syn_data_pws%>%
  group_by(Abbott_ID)%>%
  mutate(Datetime = seq(start_date, by = "day", length.out = n()))

syn_data_mb<-read.csv("/Users/Moaze002/OneDrive - Universiteit Utrecht/CODING/LME + LVAD/PRECISION-LVAD published code/PRECISION-LVAD public code/syn_mb.csv")
syn_data_mb<-syn_data_mb%>%
  group_by(Abbott_ID)%>%
  mutate(Datetime = seq(start_date, by = "day", length.out = n()))
write.csv(syn_data_mb,"syn_mb.csv")

syn_data_ca<-read.csv("/Users/Moaze002/OneDrive - Universiteit Utrecht/CODING/LME + LVAD/PRECISION-LVAD published code/PRECISION-LVAD public code/syn_ca.csv")





### Admission
admission_file<- data.frame(ID = unique(append(unique(syn_data_ca$Abbott_ID), unique(syn_data_mb$Abbott_ID))))

admission_file[,2]<-as.Date(min(syn_data_ca$Datetime))+180

write.csv(admission_file,"admission_file.csv")
