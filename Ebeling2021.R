library(docxtractr)
library(tidyverse);library(reshape2);library(stringr)
library(glmmTMB);library(DHARMa)

#authors have helpfully split the necessary data to 3 different places:
#get the data from dryad
url = "https://datadryad.org/stash/downloads/file_stream/1071891"
data = read.csv(url, sep = ";")

#get MAT and MAP from supplement
url = "https://besjournals.onlinelibrary.wiley.com/action/downloadSupplement?doi=10.1111%2F1365-2745.13801&file=jec13801-sup-0001-Supinfo.docx"
docx = read_docx(url)
data2 = docx_extract_tbl(docx,
                         tbl_number = 1,
                         header = TRUE)
data2$MAT = as.numeric(data2$MAT)
data2$MAP = as.numeric(data2$MAP)


#get location-code to location index from txt 
# url = "https://dryad-assetstore-merritt-west.s3.us-west-2.amazonaws.com/ark%3A/13030/m5w15m21%7C1%7Cproducer/Readme_LeafDamage_NutNet.txt?response-content-type=text%2Fplain&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEHEaCXVzLXdlc3QtMiJHMEUCIDFDO6X2GbaXPTMk%2BnT9TZpuGVEy5PT%2FZgZ%2FDAXrBnmBAiEAvX6WLrDudiyBGjcpJFkhovNyE%2FGl7TOjFj755jRCdWkq%2BgMIGhAAGgw0NTE4MjY5MTQxNTciDEWjpSHcN%2FtxAPZTKSrXAxGSSbfD5rLavVkvEVMyzgB7oHklFz6TbYCwuk693tbTMYJtbb3g4Unz9Dx5Sq8PT9CnqHU3F06gBvJ5QZAwfDLr3lfp9iXIziqtaHfuM5CnSfetmEGvWb%2BLNf9vCeKuF2HiY58f9jFclUQaGy499wSw7On77Scy0AlnJXYBTlku6H%2FwNdhAwJUCc%2FYMNTw5JfKTFuz%2Bt4EqE98vnKVxdcOK9QKAdV6NknF%2BJgo8YQK6tDcqc9nrQCLqX7k62bABa50PnX%2F6qxAdEjajIAmoZegTjnOtpgbH9VXsrzq1jhNEdNwadL8DY3TMDoL0o5D47JfznRyzEzXXC00RQkoWCAiFUgz3b2MhERR2XYrklYRQuSF1yn8FHvQsUy6T7P8p%2Bt38sKkxy6kXsCtH1rxpqDAtQZcwI6ByVGmHc7XPWErH3rywxMgpQ%2Fe1w94Vr%2BRKl7JqmIZ8UFgFAh0UNttI65PTPO%2BwjrcSjph%2Bb5fOnHZSrr1V8ztSkMoOqYvtjj75uHUtw%2BJSS7OXmTiZrUpazckPX4FeKuDRnYE%2FNL2IVELgIa3H4ZEVuF2mlJzC2ZG7B%2B%2FgUnJSD4Zli2nzavBHttS9MmchX35m1ragZ763N4cqlok0FcmsHzCoroCMBjqlAcxpU48nKcqVAFWmO0p9sr8QAVp%2F284JAT1RhH1s2g6mhhCyPJEys%2BvMQZCHFI3JCjRXeuhyhVnQQPB0gjcseSMwPJbuoDnyp2HAsXqp2dzWV506%2FgNPyFsoiJ%2Bjz%2FBZECCq0pVUO4G3AmlzzJSqLBGxqXUoLVsYdGHwuSZ0v03rlWYBtMdfp%2FwkxsLNMynbat%2BNOSe9GIlQANxCRRpp%2B2Bh7Lh25A%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20211101T172800Z&X-Amz-SignedHeaders=host&X-Amz-Expires=14400&X-Amz-Credential=ASIAWSMX3SNWTFCZX5RH%2F20211101%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Signature=008519f6c9e36265350b5fa4a20786eb648bc291b2e5a745caf8ea6ca4541582"
# data3 = read.table(url, sep = "=",
#                    skip = 117, nrows = 27)
data3=as.data.frame(matrix(c("badlau.de"  ,"Bad",
                             "bari.ar"    ,"For",
                             "bnch.us"    ,"Bun",
                             "bogong.au"  ,"Bog",
                             "burrawan.au","Bur",
                             "cbgb.us"    ,"Chi",
                             "cdcr.us"    ,"Ced",
                             "chilcas.ar" ,"Las",
                             "comp.pt"    ,"Com",
                             "frue.ch"    ,"Fru",
                             "jena.de"    ,"JeN",
                             "kibber.in"  ,"Kib",
                             "kilp.fi"    ,"Kil",
                             "koffler.ca" ,"Kof",
                             "konz.us"    ,"Kon",
                             "marc.ar"    ,"Mar",
                             "mcla.us"    ,"Mcl",
                             "mtca.au"    ,"Mt.",
                             "potrok.ar"  ,"Pot",
                             "saline.us"  ,"Sal",
                             "sgs.us"     ,"Sho",
                             "shps.us"    ,"She",
                             "spin.us"    ,"Spi",
                             "temple.us"  ,"Tem",
                             "ukul.za"    ,"Uku",
                             "valm.ch"    ,"Val",
                             "yarra.au"   ,"Yar"),
                             nrow=27,ncol=2,byrow=TRUE)) 
colnames(data3) = c("code","ind")


#data3$V2 = data3$V2 %>% str_replace(" ", "")
#data3$V1 = data3$V1 %>% str_replace("\t", "")

data2$ind = str_sub(data2$Site.Name,1,3)
#data3$ind = str_sub(data3$V2,1,3)

for (i in 1:27) { 
data$site = data$site %>% str_replace(data3[i,1], data3[i,2])
}

#scaling climate variables
data2$MAT = scale(data2$MAT)
data2$MAP = scale(data2$MAP)


#after some string juggling, MAT & MAP are included to the main data
data$MAT = data2$MAT[match(data$site, data2$ind)]
data$MAP = data2$MAP[match(data$site, data2$ind)]

data$site = as.factor(data$site)
data$plot = as.factor(data$plot)
data$taxon = as.factor(data$taxon)
data$experimental_treatment = as.factor(data$experimental_treatment)
data = within(data, site.plot.taxon <- factor(site:plot:taxon))
data$functional_group = factor(data$functional_group, levels = c("GRASS","LEGUME","FORB","WOODY"))

str(data)

#aaaaaaaaargh
com.data = data %>% group_by(site,
                             MAT,
                             MAP,
                             year_sampling,
                             treatment_year,
                             plot,
                             experimental_treatment,
                             taxon,
                             functional_group,
                             taxon_cover.plot) %>% summarise(tot.inv.damage = sum(invert_damage.perc),
                                                             tot.pat.damage = sum(pathogen_damage.perc))

table(data$site, data$year_sampling)

#these are all sloppy, reread methods!!!
m1 = glmmTMB(log(invert_damage.perc+1) ~ 
               experimental_treatment*MAT*MAP
             + (1|site),
             data = data)
summary(m1)

m2 = glmmTMB(log(invert_damage.perc+1) ~ 
               experimental_treatment*functional_group
             + (1|site)
             + (1|taxon)
             + (1|site.plot.taxon),
             data = data)
summary(m2)


m2 = glmmTMB(log(invert_damage.perc+1) ~ 
               experimental_treatment*functional_group
             + (1|site/plot/taxon),
             data = data)
summary(m2)
