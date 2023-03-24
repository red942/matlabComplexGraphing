function complexSurf(R,N)
    a=linspace(-R,R,N);
    b=linspace(-R,R,N);
    [X,Y]=meshgrid(a,b);
    Z = @(z) sin(z);
    W=Z(X+1i.*Y);
    C1=imag(W);
    C2=real(W);
    L1=atan(C1);
    L2=atan(C2);
    
    % First plot graphing and labels
    nexttile
    surf(X,Y,C2,L1,"EdgeColor","none");
    zlim([-2 6])
    xlabel('Re Z')
    ylabel('Im Z')
    zlabel('Re W')
    c1=colorbar;
    c1.Label.String='Im W';
    colormap(hsv)

    % Second plot graphing and labels
    nexttile
    surf(X,Y,C1,L2,"EdgeColor","none");
    zlim([-2 6])
    xlabel('Re Z')
    ylabel('Im Z')
    zlabel('Im W')
    c2=colorbar;
    c2.Label.String='Re W';
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
