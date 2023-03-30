function complexSurf(N,R)
    a=linspace(-R,R,N);
    b=linspace(-R,R,N);
    [X,Y]=meshgrid(a,b);
    Z = @(z) gamma(z);
    W=Z(X+1i.*Y);
    C1=imag(W);
    C2=real(W);
    L1=atan(C1);
    L2=atan(C2);

    colorVariation = 1;
    clf
    
    % First plot graphing and labels
    nexttile
    if colorVariation == 0
        surf(X,Y,C2,C1,"EdgeColor","none");
    elseif colorVariation == 1
        surf(X,Y,C2,L1,"EdgeColor","none");
    end
    
    if colorVariation == 0
        str1 = 'Im W';
    elseif colorVariation == 1
        str1 = 'Atan( Im W )';
    end

    zlim([-2 6])
    xlabel('Re Z')
    ylabel('Im Z')
    zlabel('Re W')
    c1=colorbar;
    c1.Label.String=str1;
    colormap(hsv)

    % Second plot graphing and labels
    nexttile
    if colorVariation == 0
        surf(X,Y,C1,C2,"EdgeColor","none");
    elseif colorVariation == 1
        surf(X,Y,C1,L2,"EdgeColor","none");
    end
    
    if colorVariation == 0
        str2 = 'Re W';
    elseif colorVariation == 1
        str2 = 'Atan( Re W )';
    end
    zlim([-2 6])
    xlabel('Re Z')
    ylabel('Im Z')
    zlabel('Im W')
    c2=colorbar;
    c2.Label.String=str2;
    colormap(hsv)

    hold off

    zeta(2);
    gamma(1);
end

% gamma function approximation for complex values
function g=gamma(z)
    c=[24309.2517827 -67451.3794262 71084.7561084 -35575.0088977 ...
        8642.23730492 -931.808427232 35.2240350789 -0.265389291384 ...
        0.0000674177040788 0];
    sum=0;
    for i=1:9
        sum = sum + c(i)./(z+i);
    end
    g=(z+10).^(z+0.5).*exp(-z-10).*(sqrt(2.*pi)+sum);
end

% fast zeta function approximation for complex values
function z=zeta(s)
    sum=0;
    for n=0:20
        for k=0:n
            sum=sum+(-1).^(k).*nchoosek(n,k)./(2.^(n+1).*(k+1).^(s));
        end
    end
    z=sum./(1-2.^(1-s));
end