function c = car(X,Y,kr,x0,y0,xT,dh)
    a=(0.5*kr*(dh^-1 -2)^2);
    f = zeros(size(X,1), size(Y,2));
    p=0:dh:1;
    q=0:dh:12;
    xl=x0*ones(1,length(p))+p;
    yl=y0*ones(1,length(q))+q;
    xr=(x0+2.25)*ones(1,length(p))+p;
    yr=y0*ones(1,length(q))+q;
    r=1:dh:2.25;
    s=5.5:dh:6.5;
    xm=x0*ones(1,length(r))+r;
    ym=(y0)*ones(1,length(s))+s;
    t=0:dh:5.5;
    xj=x0*ones(1,length(r))+r;
    yj=(y0)*ones(1,length(t))+t;
    
    for i= (1/dh)*xl(1)+1:(1/dh)*xl(length(p))+1
        for j = (1/dh)*yl(1)+1:(1/dh)*yl(length(q))+1
            f(j,i)=a;
        end
    end
    
    for i= (1/dh)*xr(1)+1:(1/dh)*xr(length(p))+1
        for j = (1/dh)*yr(1)+1:(1/dh)*yr(length(q))+1
            f(j,i)=a;
        end
    end
    
    for i= (1/dh)*xm(1)+1:(1/dh)*xm(length(r))+1
        for j = (1/dh)*ym(1)+1:(1/dh)*ym(length(s))+1
            f(j,i)=a;
        end
    end

    for i= (1/dh)*xj(1)+1:(1/dh)*xj(length(r))+1
        for j = (1/dh)*yj(1)+1:(1/dh)*yj(length(t))+1
            f(j,i)=a/5;
        end
    end
    c=f.*sqrt(((X-xT(1)).^2+(Y-xT(2)).^2));
end