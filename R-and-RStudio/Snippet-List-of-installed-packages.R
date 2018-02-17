# From https://www.r-bloggers.com/list-of-user-installed-r-packages-and-their-versions/

ip <- as.data.frame(installed.packages()[,c(1,3:4)])
rownames(ip) <- NULL
ip <- ip[is.na(ip$Priority),1:2,drop=FALSE]
print(ip, row.names=FALSE)
