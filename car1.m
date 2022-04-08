function c = car1(X,Y,kr,x0,y0)
a=(0.5*kr*(0.25^-1 -2)^2);
f = zeros(size(X,1), size(Y,2));
p=0:0.25:1;
q=0:0.25:12;
xl=x0*ones(1,5)+p;
yl=y0*ones(1,49)+q;

xr=(x0+2.25)*ones(1,5)+p;
yr=y0*ones(1,49)+q;

r=1:0.25:2.25;
s=5.5:0.25:6.5;

xm=x0*ones(1,6)+r;
ym=(y0)*ones(1,5)+s;

t=0:0.25:5.5;
xj=x0*ones(1,6)+r;
yj=(y0)*ones(1,23)+t;

for i= 4*xl(1)+1:4*xl(5)+1
    for j = 4*yl(1)+1:4*yl(49)+1
    f(j,i)=a;
    end 
end

for i= 4*xr(1)+1:4*xr(5)+1
    for j = 4*yr(1)+1:4*yr(49)+1
    f(j,i)=a;
    end 
end

for i= 4*xm(1)+1:4*xm(6)+1
    for j = 4*ym(1)+1:4*ym(5)+1
    f(j,i)=a;
    end 
end

for i= 4*xj(1)+1:4*xj(6)+1
    for j = 4*yj(1)+1:4*yj(23)+1
    f(j,i)=a/5;
    end 
end

c=f;
end