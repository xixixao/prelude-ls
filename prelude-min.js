// prelude.ls 0.1.0
// Copyright (c) 2012 George Zahariev
// Released under the MIT License
// raw.github.com/gkz/prelude-ls/master/LICNSE
this.prelude=function(){function ac(a,b){return a.length?function(){var c=b?b.concat():[];return c.push.apply(c,arguments)<a.length?ac.call(this,a,c):a.apply(this,c)}:a}function bc(a,b){return function(){return a(b.apply(this,arguments))}}function cc(a,b){var c=0,d=b.length>>>0;while(c<d)if(a===b[c++])return!0;return!1}exports={};var a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,$,_,ab,bb,cb,db,eb,fb,gb,hb,ib,jb,kb,lb,mb,nb,ob,pb,qb,rb,sb,tb,ub,vb,wb,xb,yb,zb,Ab,Bb,Cb,Db,Eb,Fb,Gb,Hb,Ib,Jb,Kb,Lb,Mb,Nb,Ob,Pb,Qb,Rb,Sb,Tb,Ub,Vb,Wb,Xb,Yb,Zb,$b,_b=[].slice;return exports.contradict=a=function(a){return!a},exports.equals=b=ac(function(a,b){return a===b}),exports.notEquals=c=ac(function(a,b){return a!==b}),exports.lt=d=ac(function(a,b){return a>b}),exports.lte=e=ac(function(a,b){return a>=b}),exports.gt=f=ac(function(a,b){return a<b}),exports.gte=g=ac(function(a,b){return a<=b}),exports.andTest=h=ac(function(a,b){return a&&b}),exports.orTest=i=ac(function(a,b){return a||b}),exports.compose=j=function(){var a;return a=_b.call(arguments),function(){var b,c,d,e,f;b=arguments;for(d=0,f=(e=a).length;d<f;++d)c=e[d],b=[c.apply(this,b)];return b[0]}},exports.max=k=Math.max,exports.min=l=Math.min,exports.negate=m=function(a){return-a},exports.abs=n=Math.abs,exports.signum=o=function(a){switch(!1){case!(a<0):return-1;case!(a>0):return 1;default:return 0}},exports.quot=p=ac(function(a,b){return~~(a/b)}),exports.rem=q=ac(function(a,b){return a%b}),exports.div=r=ac(function(a,b){return Math.floor(a/b)}),exports.mod=s=ac(function(a,b){var c;return(a%(c=b)+c)%c}),exports.recip=t=function(a){return 1/a},exports.pi=u=Math.PI,exports.exp=v=Math.exp,exports.sqrt=w=Math.sqrt,exports.log=x=Math.log,exports.pow=y=ac(function(a,b){return Math.pow(a,b)}),exports.sin=z=Math.sin,exports.tan=A=Math.tan,exports.cos=B=Math.cos,exports.asin=C=Math.asin,exports.atan=D=Math.atan,exports.atan2=E=ac(function(a,b){return Math.atan2(a,b)}),exports.acos=F=Math.acos,exports.truncate=G=function(a){return~~a},exports.round=H=Math.round,exports.ceiling=I=Math.ceil,exports.floor=J=Math.floor,exports.isItNaN=K=function(a){return a!==a},exports.add=L=ac(function(a,b){return a+b}),exports.minus=M=ac(function(a,b){return a-b}),exports.subtract=N=ac(function(a,b){return b-a}),exports.multiply=P=exports.times=O=ac(function(a,b){return a*b}),exports.divide=Q=ac(function(a,b){return a/b}),exports.divideBy=R=ac(function(a,b){return b/a}),exports.even=S=function(a){return a%2===0},exports.odd=T=function(a){return a%2!==0},exports.gcd=U=ac(function(a,b){var c;a=Math.abs(a),b=Math.abs(b);while(b!==0)c=a%b,a=b,b=c;return a}),exports.lcm=V=ac(function(a,b){return Math.abs(Math.floor(a/U(a,b)*b))}),exports.id=W=function(a){return a},exports.flip=X=ac(function(a,b,c){return a(c,b)}),exports.error=Y=function(a){throw a},exports.each=Z=ac(function(a,b){var c,d,e;for(d=0,e=b.length;d<e;++d)c=b[d],a(c);return b}),exports.map=$=ac(function(a,b){var c,d,e,f;c=[];for(e=0,f=b.length;e<f;++e)d=b[e],c.push(a(d));return c}),exports.cons=_=ac(function(a,b){return[a].concat(b)}),exports.append=ab=ac(function(a,b){return a.concat(b)}),exports.filter=bb=ac(function(a,b){var c,d,e,f;c=[];for(e=0,f=b.length;e<f;++e)d=b[e],a(d)&&c.push(d);return c}),exports.reject=cb=ac(function(a,b){var c,d,e,f;c=[];for(e=0,f=b.length;e<f;++e)d=b[e],a(d)||c.push(d);return c}),exports.find=db=ac(function(a,b){var c,d,e;for(d=0,e=b.length;d<e;++d){c=b[d];if(a(c))return c}}),exports.pluck=eb=ac(function(a,b){var c,d,e,f;c=[];for(e=0,f=b.length;e<f;++e)d=b[e],d[a]!=null&&c.push(d[a]);return c}),exports.head=fb=function(a){if(!a.length)return;return a.slice(0,1)},exports.tail=gb=function(a){if(!a.length)return;return a.slice(1)},exports.last=hb=function(a){if(!a.length)return;return a.slice(a.length-1)},exports.initial=ib=function(a){if(!a.length)return;return a.slice(0,a.length-1)},exports.empty=jb=function(a){return!a.length},exports.length=kb=function(a){return a.length},exports.reverse=lb=function(a){return a.slice().reverse()},exports.fold=nb=exports.foldl=mb=ac(function(a,b,c){var d,e,f;for(e=0,f=c.length;e<f;++e)d=c[e],b=a(b,d);return b}),exports.fold1=pb=exports.foldl1=ob=ac(function(a,b){return nb(a,b[0],b.slice(1))}),exports.foldr=qb=ac(function(a,b,c){return nb(a,b,c.reverse())}),exports.foldr1=rb=ac(function(a,b){return b.reverse(),nb(a,b[0],b.slice(1))}),exports.andList=sb=function(a){return nb(function(a,b){return a&&b},!0,a)},exports.orList=tb=function(a){return nb(function(a,b){return a||b},!1,a)},exports.any=ub=ac(function(a,b){return nb(function(b,c){return b||a(c)},!1,b)}),exports.all=vb=ac(function(a,b){return nb(function(b,c){return b&&a(c)},!0,b)}),exports.sum=wb=function(a){var b,c,d,e;b=0;for(d=0,e=a.length;d<e;++d)c=a[d],b+=c;return b},exports.product=xb=function(a){var b,c,d,e;b=1;for(d=0,e=a.length;d<e;++d)c=a[d],b*=c;return b},exports.mean=zb=exports.average=yb=function(a){var b,c,d,e;b=0;for(d=0,e=a.length;d<e;++d)c=a[d],b+=c;return b/a.length},exports.concat=Ab=function(a){return nb(ab,[],a)},exports.concatMap=Bb=ac(function(a,b){return Ab($(a,b))}),exports.maximum=Cb=function(a){if(!a.length)return;return Math.max.apply(this,a)},exports.minimum=Db=function(a){if(!a.length)return;return Math.min.apply(this,a)},exports.scan=Fb=exports.scanl=Eb=ac(function(a,b,c){var d,e,f,g,h;d=[b],e=b;for(g=0,h=c.length;g<h;++g)f=c[g],d.push(e=a(e,f));return d}),exports.scan1=Hb=exports.scanl1=Gb=ac(function(a,b){return Fb(a,b[0],b.slice(1))}),exports.scanr=Ib=ac(function(a,b,c){return c.reverse(),Fb(a,b,c).reverse()}),exports.scanr1=Jb=ac(function(a,b){return b.reverse(),Fb(a,b[0],b.slice(1)).reverse()}),exports.replicate=Kb=ac(function(a,b){var c,d;c=[],d=0;for(;d<a;++d)c.push(b);return c}),exports.take=Lb=ac(function(a,b){switch(!1){case!(a<=0):return[];case!!b.length:return[];default:return b.slice(0,a)}}),exports.drop=Mb=ac(function(a,b){switch(!1){case!(a<=0):return b;case!!b.length:return[];default:return b.slice(a)}}),exports.splitAt=Nb=ac(function(a,b){return[Lb(a,b),Mb(a,b)]}),exports.takeWhile=Ob=ac(function(a,b){var c,d,e,f;if(!b.length)return[];c=0;for(e=0,f=b.length;e<f;++e){d=b[e];if(!a(d))break;++c}return Lb(c,b)}),exports.dropWhile=Pb=ac(function(a,b){var c,d,e,f;if(!b.length)return[];c=0;for(e=0,f=b.length;e<f;++e){d=b[e];if(!a(d))break;++c}return Mb(c,b)}),exports.span=Qb=ac(function(a,b){return[Ob(a,b),Pb(a,b)]}),exports.breakList=Rb=ac(function(b,c){return Qb(bc(a,b),c)}),exports.elem=Sb=ac(function(a,b){return cc(a,b)}),exports.notElem=Tb=ac(function(a,b){return!cc(a,b)}),exports.lookup=Ub=ac(function(a,b){return b!=null?b[a]:void 8}),exports.zip=Vb=function(){var a,b,c,d,e,f,g,h,i;a=_b.call(arguments),b=[];for(c=0,g=a.length;c<g;++c){d=a[c];for(e=0,h=d.length;e<h;++e)f=d[e],c===0&&b.push([]),(i=b[e])!=null&&i.push(f)}return b},exports.zipWith=Wb=function(a){var b,c,d,e,f,g;b=_b.call(arguments,1);if(!b[0].length||!b[1].length)return[];c=[];for(e=0,g=(f=Vb.apply(this,b)).length;e<g;++e)d=f[e],c.push(a.apply(this,d));return c},exports.lines=Xb=function(a){return a.length?a.split("\n"):[]},exports.unlines=Yb=function(a){return a.join("\n")},exports.words=Zb=function(a){return a.length?a.split(" "):[]},exports.unwords=$b=function(a){return a.join(" ")},exports.prelude=function(a){if(typeof a!="undefined"&&a!==null)for(var b in exports)a[b]=exports[b];return exports},exports}()