function [Us,Vs,Ut,Vt] = DDNMF(Xs,Xt,r,Ws,Wt,Wst,alpha, lambda)

[m,p]=size(Xs);
[n,q]=size(Xt);


X=[    Xs      ,            zeros(m,q)  ;
    zeros(n,p)  ,        sqrt(alpha)*Xt     ];

Omega=[  ones(m,p)  , zeros(m,q);
         zeros(n,p) , ones(n,q) ];

W=[   Ws     ,   0.5*Wst;
    0.5*Wst' ,     Wt   ];


opts=struct('maxItr',1000000,'errTor',1e-5);

[U,V] = WGNMF_MU(Omega,X,r,lambda,W,opts);
Us=U(1:m,:);
Ut=U(m+1:end,:)/sqrt(alpha);
Vs=V(1:p,:);
Vt=V(p+1:end,:);
