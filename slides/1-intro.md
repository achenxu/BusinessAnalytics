---
title: 'ETC3250 Business Analytics: Introduction'
author: "Souhaib Ben Taieb, Di Cook, Rob Hyndman"
date: "March 16, 2015"
output:
  ioslides_presentation:
    css: styles.css
    logo: ../figures/minMASEsep.png
    mathjax: local
    self_contained: no
    widescreen: yes
    font-family: 'Helvetica'
  beamer_presentation: default
  slidy_presentation: default
---

<!--( Clean up adding figures
\centering
![Mining temporal data](../figures/minMASEsep.png)
\raggedright
\clearpage
)--> 


#Lecturers

<table>
<tr>
<td> ![souhaib](../figures/souhaib.jpg) </td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td> ![di](../figures/di.jpg) </td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td> ![rob](../figures/rob.jpg) </td>
</tr>
<tr> 
<td>Souhaib Ben Taieb</td><td>&nbsp;</td>
<td>Di Cook</td><td>&nbsp;</td>
<td>Rob Hyndman</td>
</tr>
</table>


##What is business analytics?

Using data to gain insights and understanding of business problems and performance.

 1. Exploratory data analysis
 2. Data visualization 
 3. Statistical and machine learning methods
 
  - Broader than business intelligence which focuses on describing and predicting performance.
  - Broader than econometrics as we are interested in more than economics and  finance.
  - Narrower than data science as we are focusing on **business issues**.



## Components of business analytics

  - Pulling together and cleaning data
  - Exploring and visualizing data
  - Fitting, comparing and assessing models
  - Tools for fitting models: optimization, training and testing
  - Tools for understanding randomness: simulation, resampling, permutation, cross-validation
  - Tools for handling large data sets: dimension reduction, regularization.

##Learning goals

 1. select and develop appropriate models for clustering, prediction or classification
 2. estimate and simulate from a variety of statistical models measure the uncertainty of a prediction or classification using resampling methods
 3. apply business analytic tools to produce innovative solutions in finance, marketing, economics and related areas
 4. manage very large data sets in a modern software environment explain and interpret the analyses undertaken clearly and effectively.

**Teaching and learning approach**

Two 1-hour lectures and a one 2 hour lab class each week for 12 weeks.


##R
 

![R](../figures/Rlogo.png)

<p>

<span style={text-align:right;}>
![RStudio](../figures/RStudio-Ball.png)
</span>

##Key reference

**James, Witten, Hastie and Tibshirani** (2012) *Introduction to the Elements of Statistical Learning*. Springer.

[URL](URL)

 - Free pdf online
 - Data sets in associated R package
 - R code for examples


##Outline

===================================================================
| **Week** | **Topic**                 | **Chapter** | **Lecturers** |
===================================================================
| 1        | Introduction & R bootcamp | 1           | Rob,Souhaib   |
| 2        | Statistical learning      | 2           | Rob,Souhaib   |
| 3        | Regression for prediction | 3           | Rob           |
| 4        | Resampling                | 5           | Rob           |
| 5        | Dimension reduction       | 6,10        | Rob, Souhaib  |
| 6        | Visualization             |             | Di            |
| 7        | Visualization             |             | Di            |
| 8        | Classification            | 4,8         | Souhaib, Di   |
| 9        | Classification            | 4,9         | Souhaib, Di   |
| 10       | Advanced classification   | 8           | Di ,Souhaib   |
| 11       | Advanced regression       | 6           | Di, Souhaib   |
| 12       | Clustering                | 10          | Souhaib, Di   |
===================================================================

##Assessment

  - Ten short weekly assignments, worth 2\% each. 
  - One project due at the end of the semester, worth 20\%.
  - Exam (2 hours): 60\%.



----------------------
|   Task     | Due Date     | Value |
--------------------------------------
  Assignments 1--10 | Wed 11:55pm each week | 2\% each |
  Project           | Fri ????              | 20\%      |     
  Final exam        | Official exam period  | 60\%      |
---------------------------------------


  - Need at least 45\% for exam.
  - Need at least 50\% for total.



##Moodle site


  - Includes all lecture notes, handouts, assignments
  - Forum for asking questions, etc.
  - No email please --- use the forum.
  - Assignment submissions




## What is business analytics?

Business analytics involves using exploring data to obtain new insights and understanding of business performance. It involves exploratory data analysis, visualization and statistical methods.

It may be interpreted more broadly than business intelligence (data mining) which focuses more on metrics for describing and predicting performance.

## Components of business analytics

- Pulling together and cleaning data
- Exploring and visualizing data
- Fitting, comparing and assessing models
- General tools for understanding randomness: resampling, permutation, cross-validation
- General tools for fitting models: optimization, training and testing

## Pulling data together 1a

Historical exchange rates extracted from [http://www.oanda.com/currency/historical-rates/](http://www.oanda.com/currency/historical-rates/).


```r
xc <- read.csv("../data/exchangerate.csv", stringsAsFactors=FALSE)
dim(xc)
```

```
## [1] 191   5
```

```r
head(xc)
```

```
##     Date    AUD    EUR    CAN    CNY
## 1 Feb-15 1.2828 0.8807 1.2520 6.1438
## 2 Jan-15 1.2359 0.8575 1.2037 6.1307
## 3 Dec-14 1.2127 0.8116 1.1536 6.1294
## 4 Nov-14 1.1538 0.8014 1.1314 6.1393
## 5 Oct-14 1.1412 0.7891 1.1217 6.1381
## 6 Sep-14 1.1026 0.7745 1.0996 6.1498
```

## Pulling data together 1b


```r
xc$Date <- as.Date(paste("1",xc$Date,sep="-"), "%d-%b-%y")
summary(xc)
```

```
##       Date                 AUD              EUR              CAN        
##  Min.   :1999-04-01   Min.   :0.9283   Min.   :0.6336   Min.   :0.9561  
##  1st Qu.:2003-03-16   1st Qu.:1.0854   1st Qu.:0.7400   1st Qu.:1.0358  
##  Median :2007-03-01   Median :1.2955   Median :0.7834   Median :1.1536  
##  Mean   :2007-03-02   Mean   :1.3346   Mean   :0.8359   Mean   :1.2186  
##  3rd Qu.:2011-02-15   3rd Qu.:1.5280   3rd Qu.:0.9240   3rd Qu.:1.4482  
##  Max.   :2015-02-01   Max.   :1.9896   Max.   :1.1710   Max.   :1.6004  
##       CNY       
##  Min.   :6.098  
##  1st Qu.:6.562  
##  Median :7.729  
##  Mean   :7.410  
##  3rd Qu.:8.267  
##  Max.   :8.280
```

## Pulling data together 2a

Historical GDP extracted from [http://www.abs.gov.au/AUSSTATS](http://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/5206.0Dec%202014?OpenDocument).


```r
gdp <- read.csv("../data/gdp.csv", stringsAsFactors=FALSE)
dim(gdp)
```

```
## [1] 222   2
```

```r
head(gdp)
```

```
##       Date GDP.per.capita
## 1 Sep-1963             NA
## 2 Dec-1963             NA
## 3 Mar-1964             NA
## 4 Jun-1964             NA
## 5 Sep-1964             NA
## 6 Dec-1964             NA
```

## Pulling data together 2b


```r
gdp$Date <- as.Date(paste("1", gdp$Date,sep="-"), "%d-%b-%Y")
summary(gdp)
```

```
##       Date            GDP.per.capita 
##  Min.   :1963-09-01   Min.   : 1033  
##  1st Qu.:1977-06-24   1st Qu.: 3412  
##  Median :1991-04-16   Median : 6680  
##  Mean   :1991-04-16   Mean   : 7677  
##  3rd Qu.:2005-02-06   3rd Qu.:11184  
##  Max.   :2018-12-01   Max.   :17035  
##                       NA's   :56
```

## Merge data 1


```r
library(dplyr)
gdp <- filter(gdp, Date >= min(xc$Date))
summary(gdp)
```

```
##       Date            GDP.per.capita 
##  Min.   :1999-06-01   Min.   : 7036  
##  1st Qu.:2004-04-16   1st Qu.: 8884  
##  Median :2009-03-01   Median :11572  
##  Mean   :2009-03-01   Mean   :11953  
##  3rd Qu.:2014-01-15   3rd Qu.:14820  
##  Max.   :2018-12-01   Max.   :17035
```

## Merge data 2


```r
xc.gdp <- left_join(xc, gdp)
dim(xc.gdp)
```

```
## [1] 191   6
```

```r
head(xc.gdp)
```

```
##         Date    AUD    EUR    CAN    CNY GDP.per.capita
## 1 2015-02-01 1.2828 0.8807 1.2520 6.1438             NA
## 2 2015-01-01 1.2359 0.8575 1.2037 6.1307             NA
## 3 2014-12-01 1.2127 0.8116 1.1536 6.1294          15744
## 4 2014-11-01 1.1538 0.8014 1.1314 6.1393             NA
## 5 2014-10-01 1.1412 0.7891 1.1217 6.1381             NA
## 6 2014-09-01 1.1026 0.7745 1.0996 6.1498          15553
```

## Plotting data 1


```r
library(ggplot2)
qplot(Date, AUD, data=xc.gdp, geom="line")
```

![plot of chunk plotAUD](figure/plotAUD-1.png) 

## Plotting data 1


```r
qplot(AUD, GDP.per.capita, data=xc.gdp) + theme(aspect.ratio=1)
```

![plot of chunk plotGDP](figure/plotGDP-1.png) 

## Equations

Equations can be written using latex notation, e.g. 

Variables in data are usually denoted with $X$, and response variables as $Y$. Predicted response variables are $\hat{Y}$. 
