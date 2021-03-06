# Fancycent -- some crazy operators to speed up interactive work with R
#
# Copyright 2012 Miron B. Kursa. Version 0.0.99
#
#Fancycent is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
#Fancycent is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#You should have received a copy of the GNU General Public License along with fancycent. If not, see http://www.gnu.org/licenses/.

#Concat
"%+%"<-function(a,b) c(a,b)

#List concat
"%&%"<-function(a,b) c(as.list(a),as.list(b))

#Join strings
"%.%"<-function(a,b) paste(a,b,sep='')

#Set class
"%sc%"<-function(a,b){class(a)<-b;a}
#Set names
"%sn%"<-function(a,b){names(a)<-b;a}
#Set levels
"%sl%"<-function(a,b){levels(a)<-b;a}
#Set dim
"%sd%"<-function(a,b){dim(a)<-b;a}

#Attr
"%a%"<-attr
"%a%<-"<-`attr<-`

#Sprintf
"%f%"<-function(a,b) do.call(sprintf,c(list(a),as.list(b)))

#Call
"%_%"<-function(a,b) do.call(a,as.list(b))
#Lapply
"%@%"<-function(a,b) lapply(a,b)
#Sapply
"%@@%"<-function(a,b) sapply(a,b)
#Map and ignore
"%@i%"<-function(a,b){for(e in a) b(e);invisible(NULL)}
#Curry
"%|%"<-function(a,b) function(...) do.call(a,c(list(...),as.list(b)))
"%|<%"<-function(a,b) function(...) do.call(a,c(as.list(b),list(...)))

#Exclude by names
"%x%"<-function(a,b) a[!(names(a)%in%b)]
"%x%<-"<-function(a,b,value){value->a[!(names(a)%in%b)];a}
#Restrict to names
"%r%"<-function(a,b) a[(names(a)%in%b)]
"%r%<-"<-function(a,b,value){value->a[(names(a)%in%b)];a}

#Head
"%h%"<-function(a,b) head(a,b)
#Tail
"%t%"<-function(a,b) tail(a,b)

#Sample
"%s%"<-function(a,b){if(length(a)==1) a<-c(a,a); if(is.null(b)) sample(a) else sample(a,b)}
"%s%<-"<-function(a,b,value){value->a[sample.int(length(a),b)];a}
"%S%"<-function(a,b){if(length(a)==1) a<-c(a,a); if(is.null(b)) sample(a,replace=TRUE) else sample(a,b,replace=TRUE)}

#Max
"%max%"<-function(a,b) sort(a)[b]
#Min
"%min%"<-function(a,b) sort(a,decreasing=TRUE)[b]

#Order by
"%by%"<-function(a,b) if(is.list(b)) a[do.call(order,b)] else a[order(b)]
#Reverse order by
"%rBy%"<-function(a,b) if(is.list(b)) a[do.call(order,c(b,list(decreasing=TRUE)))] else a[order(b,decreasing=TRUE)]

#Exclude by names via regexp
"%x~%"<-function(a,b) a[!grepl(paste(b,collapse="|"),names(a))]
"%x~%<-"<-function(a,b,value){value->a[!grepl(paste(b,collapse="|"),names(a))];a}
#Restrict to names via regexp
"%r~%"<-function(a,b) a[grepl(paste(b,collapse="|"),names(a))]
"%r~%<-"<-function(a,b,value){value->a[grepl(paste(b,collapse="|"),names(a))];a}

#Grep
"%~n%"<-function(a,b) grep(paste(b,collapse="|"),a)
"%~?%"<-function(a,b) grepl(paste(b,collapse="|"),a)
"%~%"<-function(a,b) grep(paste(b,collapse="|"),a,value=TRUE)
"%~%<-"<-function(a,b,value){value->a[grepl(paste(b,collapse="|"),a)];a}

#Leave those not in
"%!=%"<-function(a,b) a[!(a%in%b)]
"%!=%<-"<-function(a,b,value){value->a[!(a%in%b)];a}
#Leave those in
"%==%"<-function(a,b) a[(a%in%b)]
"%==%<-"<-function(a,b,value){value->a[(a%in%b)];a}

#Index with function results
"%[by]%"<-function(a,b) a[b(a)]
"%[,by]%"<-function(a,b) a[,b(a)]
"%[by,]%"<-function(a,b) a[b(a),]

#Better sampling
saneple<-function(x,size,replace=FALSE,prob=NULL){
 if(missing(size))
  size<-length(x);
 x[sample.int(length(x),size,replace,prob)]
}

"%samp%"<-function(x,size)
 sapply(size,function(s)
  x[sample.int(length(x),size=s,replace=FALSE)])


"%sampr%"<-function(x,size)
 sapply(size,function(s)
  x[sample.int(length(x),size=s,replace=TRUE)])

"%r%"<-function(x,times)
 rep(x,times)



