function V_new=change_field_2D(V_old,X,Y,xp_k,yp)
    
    Pw=sqrt(((X-xp_k).^2)+((Y-yp).^2));
    xw=min(min(Pw));
    
    [iix,iiy]=find(Pw==xw);
    ix=iix(1);
    iy=iiy(1);
    V_new=V_old;
    
    k_lm = 0.2;
    d_lm = 0.5;
    
    % Repulsive Potential to be added at local Minimum
    V_lm=0.5.*k_lm.*((1./sqrt((X-xp_k).^2+(Y-yp).^2))-(1/(d_lm))).^2.*(sqrt((X-xp_k).^2+(Y-yp).^2)<=0.5);
    
    V_new=V_old+V_lm;
    
    
end