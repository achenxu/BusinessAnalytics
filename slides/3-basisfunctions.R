library(latex2exp)
source("nicefigs.R")

# Polynomials

X <- matrix(1, ncol=6, nrow=100)
X[,2] <- x <- seq(-1,1,l=100)
X[,3] <- x^2
X[,4] <- x^3
X[,5] <- x^4
X[,6] <- x^5
X <- sweep(X, 2, FUN="/", STATS=apply(X,2,max))

savepdf("../figures/polybasis")
matplot(x, X, lty=1, type="l", main="Polynomial basis functions",
        ylab=latex2exp("b_i(x)"))
legend("bottomright",col=1:6,lty=1,
       legend=c(latex2exp("b_1(x)=1"),
                latex2exp("b_2(x)=x"),
                latex2exp("b_3(x)=x^2"),
                latex2exp("b_4(x)=x^3"),
                latex2exp("b_5(x)=x^4"),
                latex2exp("b_6(x)=x^5")))
endpdf()


# Truncated power terms for cubic splines

X <- matrix(1, ncol=6, nrow=100)
X[,2] <- x <- seq(-1,1,l=100)
X[,3] <- x^2
X[,4] <- x^3
X[,5] <- pmax((x+0.5)^3,0)
X[,6] <- pmax((x-0.5)^3,0)
X <- sweep(X, 2, FUN="/", STATS=apply(X,2,max))

savepdf("../figures/truncpolybasis")
matplot(x, X, lty=1, type="l", main="Truncated power cubic spline basis functions",
        ylab=latex2exp("b_i(x)"))
legend("bottomright",col=1:6,lty=1,
       legend=c(latex2exp("b_1(x)=1"),
                latex2exp("b_2(x)=x"),
                latex2exp("b_3(x)=x^2"),
                latex2exp("b_4(x)=x^3"),
                latex2exp("b_5(x)=(x+0.5)^3_+"),
                latex2exp("b_6(x)=(x-0.5)^3_+")))
endpdf()



# Natural splines

library(splines)
X <- matrix(1, ncol=6, nrow=100)
x <- seq(-1,1,l=100)
X[,2:6] <- ns(x, df=5)
X <- sweep(X, 2, FUN="/", STATS=apply(X,2,max))

savepdf("../figures/nsbasis")
matplot(x, X, lty=1, type="l", main="Natural cubic spline basis functions",
        ylab=latex2exp("b_i(x)"))
legend("bottomright",col=1:6,lty=1,
       legend=c(latex2exp("b_1(x)"),
                latex2exp("b_2(x)"),
                latex2exp("b_3(x)"),
                latex2exp("b_4(x)"),
                latex2exp("b_5(x)"),
                latex2exp("b_6(x)")))
endpdf()


# B splines

library(splines)
X <- matrix(1, ncol=6, nrow=100)
x <- seq(-1,1,l=100)
X[,2:6] <- bs(x, df=5)
X <- sweep(X, 2, FUN="/", STATS=apply(X,2,max))

savepdf("../figures/bsbasis")
matplot(x, X, lty=1, type="l", main="Cubic B-spline basis functions",
        ylab=latex2exp("b_i(x)"))
legend("bottomright",col=1:6,lty=1,
       legend=c(latex2exp("b_1(x)"),
                latex2exp("b_2(x)"),
                latex2exp("b_3(x)"),
                latex2exp("b_4(x)"),
                latex2exp("b_5(x)"),
                latex2exp("b_6(x)")))
endpdf()


