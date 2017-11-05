library(Rfacebook)
library(RCurl)

#Using my app token
fb_oauth <- fbOAuth(app_id="163758044218160", app_secret="6bb339865f037ca27b2072c2302c1550",extended_permissions = TRUE)
save(fb_oauth, file="fb_oauth")

# Fetching the page
page <- getPage(page="narendramodi", token=fb_oauth, n=1000)
post <- getPost(page$id[2], token=fb_oauth, n.comments=1000, likes=TRUE)
comments <- post$comments
data <- as.data.frame(comments)
bckup <- data

#Data cleaning for commments
dat2<-gsub("[^[:alnum:]///' ]", "", data$message)
dat2<-data.frame(dat2)
dat3<-gsub("([.-])|[[:punct:]]", " ", dat2$dat2)
dat3<-data.frame(dat3)
dat4<-iconv(dat3$dat3, "latin1", "ASCII", sub="")
dat4<-data.frame(dat4)
dat5<-gsub('[[:digit:]]+', '',dat4$dat4)
dat5<-data.frame(dat5)
dat6<-tolower(dat5$dat5)
dat6<-data.frame(dat6)
dat7<-gsub("'", " ", dat6$dat6)
dat7<-data.frame(dat7)
dat8<-gsub("/", " ", dat7$dat7)
dat8<-data.frame(dat8)

data$message <- dat8
write.csv(data, file="fbdata.csv" , row.names=FALSE)

#Scraping data for groups
id <- searchGroup(name = "trump", token = fb_oauth)
id
group <- getGroup(group_id = "1638417209555402", token = fb_oauth, feed = TRUE, n=10)
posts > post <- getPost(group$id[1], token=fb_oauth, n.comments=10, likes=TRUE)
comments <- post$comments
data <- as.data.frame(comments)
write.csv(data, file="fbdata.csv" , row.names=FALSE)
