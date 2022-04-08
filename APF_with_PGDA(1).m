clear all
close all
clc
% Step Size
dh=0.25;
% Defining Meshgrid for Potential Field
X=0:dh:10;
Y=0:dh:100;
[X,Y]=meshgrid(X,Y);
% Proportionality constants for attractive field and Road lateral end
ka=1;
kr=1;
% Goal Point
xT=[4;95]; 
% Start Point
x0=[6.5,2]; 
% Attractive Potential Field
Va=.5.*ka.*sqrt(((X-xT(1)).^2+(Y-xT(2)).^2));
% Repulsive Potential Field due to lateral end of Road
xr1=1;
xr2=9;
Vroad1 = (0.5*kr*(dh^-1 -2)^2).*(abs(X-xr1)<=0.5).*sqrt(((X-xT(1)).^2+(Y-xT(2)).^2));
Vroad2 = (0.5*kr*(dh^-1 -2)^2).*(abs(X-xr2)<=0.5).*sqrt(((X-xT(1)).^2+(Y-xT(2)).^2));

% Repulsive Potential Field due to other cars
car1=car(X,Y,kr,5,18,xT,dh);
car2=car(X,Y,kr,1.5,55,xT,dh);
car3=car(X,Y,kr,5,80,xT,dh);

% Total Potential Field
V = Va+Vroad1+Vroad2+car1+car2+car3;
[fX,fY]=gradient(-V,dh,dh);

ss=1;
k=1;
xp=[];
yp=[];
xp(1)=x0(1);
yp(1)=x0(2);
ix=[];
iy=[];
jx=[];
jy=[];
fxx=0;
fyy=0;
h=2; % parameter in local minima detection
max_iter = 1000;

% Loop to detect Local Minimum and adding Repulsive potential at Local Minimum 
while ss && k<max_iter
    
    Pw=sqrt(((X-xp(k)).^2)+((Y-yp(k)).^2));
    xw(k)=min(min(Pw));
    
    [iix,iiy]=find(Pw==xw(k));
    ix(k)=iix(1);
    iy(k)=iiy(1);
    
    fx1=fX(ix(k),iy(k));
    fy1=fY(ix(k),iy(k));
    
    f = [fx1, fy1];
    n = norm(f);
    
    fxx(k)=fx1/n;
    fyy(k)=fy1/n;
    
    % ff(k,:)=[fX(ix(k),iy(k)),fY(ix(k),iy(k))];
    
    xp(k+1)=xp(k)+dh*(fxx(k));
    yp(k+1)=yp(k)+dh*(fyy(k));
    
%     sqrt((xp(k+1)-xT(1)).^2+(yp(k+1)-xT(2)).^2)
%     n
    
    if (sqrt((xp(k+1)-xT(1)).^2+(yp(k+1)-xT(2)).^2)<=0.4)
        ss=0;
    end
    
    if (k>=h)&&(sqrt((xp(k+1)-xp(k+1-h)).^2+(yp(k+1)-yp(k+1-h)).^2)<=0.005)
%     if n<0.1
        V=change_field_2D(V,X,Y,xp(k+1-h),yp(k+1-h));
        disp("Local Minima Detected at ")
        [xp(k+1-h),yp(k+1-h)]
        [fX,fY]=gradient(-V,dh,dh);
        k=0;
    end
    
    k=k+1;
end

%% Plots
% Plot for path
figure(1)
quiver(X,Y,fX,fY,'k')
title('Potential Field of Area')
xlabel('X-Axis')
ylabel('Y-Axis')
% axis equal
hold on
plot(x0(1),x0(2),'ro',xT(1),xT(2),'ro')
plot([xp],[yp],'r')

% Plot for Potential surface
figure(2)
% axis equal
surf(X,Y,V)
title('Potential Surface')

% Plot showing change in Potential field
figure(3)
% axis equal
surf(X,Y,V-(Va+Vroad1+Vroad2+car1+car2+car3))
title('Potential Surface Change')