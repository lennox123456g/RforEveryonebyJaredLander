x <- 10:1
y <- -4:5
q <- c("Hockey", "Football", "Baseball", "Curling","Rugby",
       "Lacrosse", "Basketball", "Tennis", "Cricket", "Soccer")
theDF <- data.frame(First=x, Second=y, Sport=q)
theDF$Sport

theDFs <- data.frame(First=x, Second=y, Sport=q, stringsAsFactors = FALSE)
theDFs$Sport
