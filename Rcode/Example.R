library(qcc)
library(dplyr)
library(lme4)


# loading the datasets:
df_all_patient<-read.csv("syn_ca.csv")
#or:
df_all_patient<-read.csv("syn_mb.csv")
#stable_patients
pws_patient<-read.csv("syn_pws.csv")
admission_file<-read.csv("admission_file.csv")



variable_name="Flow"

L1 = 

df_all_patient$Datetime<- as.Date(df_all_patient$Datetime)
pws_patient$Datetime<- as.Date(pws_patient$Datetime)





