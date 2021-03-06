############################
##### Stock and Watson 8変数 with output#####
############################
## (1) source("SW-8.R") #コードを置いてある場所
## (2)【計算実行】：X <- PR() #時間がかかる
## (3)【データ確認】X$par で推定パラメータ(変換前)
## (4)【図示】SW(X$par)
##
############################

   data <- read.csv("SW-8.csv",header=T)
   ts <- ts(data[,-1],start=c(2000,1),frequency=12)

   M1 <- cbind( ts[,1],ts[,2],ts[,3],ts[,4],ts[,5],ts[,6],ts[,7],ts[,8] )

yy <- M1

#########################################################################
######　基本関数　######
   trans4 <- function(c0){
      cc <- c0
        c1 <- c0[1]/(1+abs(c0[1]))
        c2 <- c0[2]/(1+abs(c0[2]))
      cc[1] <- c1+c2
      cc[2] <- -1*c1*c2
        c3 <- c0[3]/(1+abs(c0[3]))
        c4 <- c0[4]/(1+abs(c0[4]))
      cc[3] <- c3+c4
      cc[4] <- -1*c3*c4
        c5 <- c0[5]/(1+abs(c0[5]))
        c6 <- c0[6]/(1+abs(c0[6]))
      cc[5] <- c5+c6
      cc[6] <- -1*c5*c6
        c7 <- c0[7]/(1+abs(c0[7]))
        c8 <- c0[8]/(1+abs(c0[8]))
      cc[7] <- c7+c8
      cc[8] <- -1*c7*c8
        c9 <- c0[9]/(1+abs(c0[9]))
        c10 <- c0[10]/(1+abs(c0[10]))
      cc[9] <- c9+c10
      cc[10] <- -1*c9*c10
        c11 <- c0[11]/(1+abs(c0[11]))
        c12 <- c0[12]/(1+abs(c0[12]))
      cc[11] <- c11+c12
      cc[12] <- -1*c11*c12
        c13 <- c0[13]/(1+abs(c0[13]))
        c14 <- c0[14]/(1+abs(c0[14]))
      cc[13] <- c13+c14
      cc[14] <- -1*c13*c14
        c15 <- c0[15]/(1+abs(c0[15]))
        c16 <- c0[16]/(1+abs(c0[16]))
      cc[15] <- c15+c16
      cc[16] <- -1*c15*c16
        c17 <- c0[17]/(1+abs(c0[17]))
        c18 <- c0[18]/(1+abs(c0[18]))
      cc[17] <- c17+c18
      cc[18] <- -1*c17*c18
      cc[19:26] <- c0[19:26]^2
      return(cc)
   }

   trans1 <- function(c0){
      cc <- c0
      cc[19:26] <- c0[19:26]^2
      return(cc)
   }

#########################################################################
######　最尤法の計算　パラメーターの数　34個　######

　　　PR <- function(par=c(0.6,0.2,-0.3,-0.02,-0.07,0.03,-0.3,-0.02,0.38,0.27,0.8,0.4,0.8,0.3,0.1,0.4,0.1,0.3,0.6,0.2,-0.3,-0.02,-0.07,0.03,-0.3,-0.02,0.38,0.27,0.8,0.4,0.8,0.3,0.1,-0.4)){
　　　   optim(par, sw.l, method ="SANN" )
　　　}

　　　PR1 <- function(par=c(0.6,0.2,-0.3,-0.02,-0.07,0.03,-0.3,-0.02,0.38,0.27,0.8,0.4,0.8,0.3,0.1,0.4,0.1,0.3,0.6,0.2,-0.3,-0.02,-0.07,0.03,-0.3,-0.02,0.38,0.27,0.8,0.4,0.8,0.3,0.1,-0.4)){
　　　   optim(par, sw.l)
　　　}

#########################################################################
　　　######　対数尤度の計算 (8系列)　######

   sw.l <- function(prmtr1){
     loglik <- 0      ##　対数尤度の初期値
     prmtr <- trans1(prmtr1)
       phi1 <- prmtr[1]  ;  phi2 <- prmtr[2]

       psi11 <- prmtr[3]  ;  psi12 <- prmtr[4]
       psi21 <- prmtr[5]  ;  psi22 <- prmtr[6]
       psi31 <- prmtr[7]  ;  psi32 <- prmtr[8]
       psi41 <- prmtr[9]  ;  psi42 <- prmtr[10]
       psi51 <- prmtr[11]  ;  psi52 <- prmtr[12]
       psi61 <- prmtr[13]  ;  psi62 <- prmtr[14]
       psi71 <- prmtr[15]  ;  psi72 <- prmtr[16]
       psi81 <- prmtr[17]  ;  psi82 <- prmtr[18]

       sig1  <- prmtr[19] ; sig2  <- prmtr[20]
       sig3  <- prmtr[21] ; sig4  <- prmtr[22]
       sig5  <- prmtr[23] ; sig6  <- prmtr[24]
       sig7  <- prmtr[25] ; sig8  <- prmtr[26]

       gamma1 <- prmtr[27] ; gamma2 <- prmtr[28]
       gamma3 <- prmtr[29] ; gamma4 <- prmtr[30]
       gamma5 <- prmtr[31] ; gamma6 <- prmtr[32]
       gamma7 <- prmtr[33] ; gamma8 <- prmtr[34]

     F.cont <- c(phi1,phi2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                       1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
               0,0,psi11,psi12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                       0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
               0,0,0,0,psi21,psi22,0,0,0,0,0,0,0,0,0,0,0,0,
                       0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,
               0,0,0,0,0,0,psi31,psi32,0,0,0,0,0,0,0,0,0,0,
                       0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,
               0,0,0,0,0,0,0,0,psi41,psi42,0,0,0,0,0,0,0,0,
                       0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,
               0,0,0,0,0,0,0,0,0,0,psi51,psi52,0,0,0,0,0,0,
                       0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,
               0,0,0,0,0,0,0,0,0,0,0,0,psi61,psi62,0,0,0,0,
                       0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,
               0,0,0,0,0,0,0,0,0,0,0,0,0,0,psi71,psi72,0,0,
                       0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,
               0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,psi81,psi82,
                       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0)

        F <- matrix(F.cont,nrow=18,ncol=18,byrow=TRUE)

     H.cont <- c(gamma1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                 gamma2,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,
                 gamma3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,
                 gamma4,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,
                 gamma5,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,
                 gamma6,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,
                 gamma7,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,
                 gamma8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0)

        H <- matrix(H.cont,nrow=8,ncol=18,byrow=TRUE)
     Q.cont <-  c(   1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                  0,0,sig1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                  0,0,0,0,sig2,0,0,0,0,0,0,0,0,0,0,0,0,0,
                     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                  0,0,0,0,0,0,sig3,0,0,0,0,0,0,0,0,0,0,0,
                     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                  0,0,0,0,0,0,0,0,sig4,0,0,0,0,0,0,0,0,0,
                     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                  0,0,0,0,0,0,0,0,0,0,sig5,0,0,0,0,0,0,0,
                     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                  0,0,0,0,0,0,0,0,0,0,0,0,sig6,0,0,0,0,0,
                     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                  0,0,0,0,0,0,0,0,0,0,0,0,0,0,sig7,0,0,0,
                     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,sig8,0,
                     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)

        Q <- matrix(Q.cont,nrow=18,ncol=18,byrow=TRUE)

　　　## Step1
     beta.ll <- matrix(rep(0,18),nrow=18,ncol=1)
       I.m <- diag(rep(1,18))
       vecP.ll <-  solve(I.m - F %*% F) %*% Q
     P.ll <- matrix(vecP.ll,nrow=18,ncol=18)

　　　###### 繰り返し　######
     for(iter in 1:(dim(yy)[1])){

　　　## Step2
       beta.tl <- F %*% beta.ll
       P.tl <- F %*% P.ll %*% t(F) + Q

　　　## Step3
       v.t <- yy[iter,] - H %*% beta.tl
       f.t <- H %*% P.tl %*% t(H)

　　　## Step4
       loglik <- loglik +  log(   (1/( (2*pi)^(dim(yy)[2]/2) * det(f.t)^(1/2) ) ) * exp( - t(v.t)%*%t(f.t)%*%v.t/2 )      )

　　　## Step5
       beta.tt <- beta.tl + P.tl %*% t(H) %*% solve(f.t) %*% v.t
       P.tt <- P.tl - P.tl %*% t(H) %*% solve(f.t) %*% H %*% P.tl

　　　## 値の更新
       beta.ll <- beta.tt
       P.ll <- P.tt
     }

　　　### optim() は最小尤度を探すため、符号反転して出力
     mns.loglik <- -1 * loglik
     return(mns.loglik)
   }

#########################################################################
######　景気指標の計算 (8系列)　######

   SW <- function(prmtr1){
     prmtr <- trans4(prmtr1)
       phi1 <- prmtr[1]  ;  phi2 <- prmtr[2]

       psi11 <- prmtr[3]  ;  psi12 <- prmtr[4]
       psi21 <- prmtr[5]  ;  psi22 <- prmtr[6]
       psi31 <- prmtr[7]  ;  psi32 <- prmtr[8]
       psi41 <- prmtr[9]  ;  psi42 <- prmtr[10]
       psi51 <- prmtr[11]  ;  psi52 <- prmtr[12]
       psi61 <- prmtr[13]  ;  psi62 <- prmtr[14]
       psi71 <- prmtr[15]  ;  psi72 <- prmtr[16]
       psi81 <- prmtr[17]  ;  psi82 <- prmtr[18]

       sig1  <- prmtr[19] ; sig2  <- prmtr[20]
       sig3  <- prmtr[21] ; sig4  <- prmtr[22]
       sig5  <- prmtr[23] ; sig6  <- prmtr[24]
       sig7  <- prmtr[25] ; sig8  <- prmtr[26]

       gamma1 <- prmtr[27] ; gamma2 <- prmtr[28]
       gamma3 <- prmtr[29] ; gamma4 <- prmtr[30]
       gamma5 <- prmtr[31] ; gamma6 <- prmtr[32]
       gamma7 <- prmtr[33] ; gamma8 <- prmtr[34]

     F.cont <- c(phi1,phi2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                       1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
               0,0,psi11,psi12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                       0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
               0,0,0,0,psi21,psi22,0,0,0,0,0,0,0,0,0,0,0,0,
                       0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,
               0,0,0,0,0,0,psi31,psi32,0,0,0,0,0,0,0,0,0,0,
                       0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,
               0,0,0,0,0,0,0,0,psi41,psi42,0,0,0,0,0,0,0,0,
                       0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,
               0,0,0,0,0,0,0,0,0,0,psi51,psi52,0,0,0,0,0,0,
                       0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,
               0,0,0,0,0,0,0,0,0,0,0,0,psi61,psi62,0,0,0,0,
                       0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,
               0,0,0,0,0,0,0,0,0,0,0,0,0,0,psi71,psi72,0,0,
                       0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,
               0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,psi81,psi82,
                       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0)

        F <- matrix(F.cont,nrow=18,ncol=18,byrow=TRUE)

     H.cont <- c(gamma1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                 gamma2,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,
                 gamma3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,
                 gamma4,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,
                 gamma5,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,
                 gamma6,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,
                 gamma7,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,
                 gamma8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0)

        H <- matrix(H.cont,nrow=8,ncol=18,byrow=TRUE)

     Q.cont <-  c(   1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                  0,0,sig1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                  0,0,0,0,sig2,0,0,0,0,0,0,0,0,0,0,0,0,0,
                     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                  0,0,0,0,0,0,sig3,0,0,0,0,0,0,0,0,0,0,0,
                     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                  0,0,0,0,0,0,0,0,sig4,0,0,0,0,0,0,0,0,0,
                     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                  0,0,0,0,0,0,0,0,0,0,sig5,0,0,0,0,0,0,0,
                     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                  0,0,0,0,0,0,0,0,0,0,0,0,sig6,0,0,0,0,0,
                     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                  0,0,0,0,0,0,0,0,0,0,0,0,0,0,sig7,0,0,0,
                     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,sig8,0,
                     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)

        Q <- matrix(Q.cont,nrow=18,ncol=18,byrow=TRUE)
　　　## Step1
     beta.ll <- matrix(rep(0,18),nrow=18,ncol=1)
       I.m <- diag(rep(1,18))
       vecP.ll <- solve(I.m - F %*% F) %*% Q
     P.ll <- matrix(vecP.ll,nrow=18,ncol=18)
     ft.ct <- matrix( nrow=nrow(yy),ncol=9 )
　　　###### 繰り返し　######
     for(iter in 1:(dim(yy)[1])){
　　　## Step2
       beta.tl <- F %*% beta.ll
       P.tl <- F %*% P.ll %*% t(F) + Q
　　　## Step3
       v.t <- yy[iter,] - H %*% beta.tl
       f.t <- H %*% P.tl %*% t(H)
　　　## Step4
       beta.tt <- beta.tl + P.tl %*% t(H) %*% solve(f.t) %*% v.t
       P.tt <- P.tl - P.tl %*% t(H) %*% solve(f.t) %*% H %*% P.tl
       ft.ct[iter,] <- c( v.t[(1:8),1],beta.tt[1,1] )
　　　## 更新
       beta.ll <- beta.tt
       P.ll <- P.tt
     }
　　　#######################
     I.18 <- diag(rep(1:18))
     K <- P.tl %*% t(H) %*% solve(f.t)
     W0 <- (I.18 - K %*% H) %*% F
     f.err <- ft.ct[,(1:8)]
     dlt.ctt <- ft.ct[,9]
## 景気指数の推定
     new.ind <- 0
     for(ii in 2:(dim(yy)[1]+1) ){
       alpha <- W0 %*% K %*% yy[ii-1,]
       new.ind[ii] <- new.ind[ii-1] + dlt.ctt[ii-1] + alpha[1,1]
     }
     new.ind.ts <- ts(new.ind[-1],start=c(2000,1),frequency=12)
   write.csv(new.ind.ts,"O-SW-8.csv")

   ts.plot(new.ind.ts)
   }
