function domainColor(varargin)
    % sets up variables and functions for the rest of the code
    L=varargin{1};

    if nargin==2
        Rx=varargin{2};
        Ry=varargin{2};
    elseif nargin>2
        Rx=varargin{2};
        Ry=varargin{3};
    end

    if nargin==4
        rStep=varargin{4};
    else
        rStep=1;
    end

    f = @(z) zeta(z);
    x=linspace(-Rx,Rx,L);
    y=linspace(-Ry,Ry,L);
    [X,Y] = meshgrid(x,y);
    Z=f(X + 1i.*Y);
    x=[-Rx Rx];
    y=[-Ry Ry];

    % just to get rid of the annoying warnings
    gamma(0);
    zeta(2);
    
    % decides how to color the final plot
    colorVariation=2;
    
    % argument and magnitude for every point in Z
    argZ=(angle(Z)+pi)/(2.*pi);
    if colorVariation==0
        magZ=mod(log(abs(Z)),rStep)./rStep;
    elseif colorVariation==1
        magZ=mod(0.5.*log(1+real(Z).^2+imag(Z).^2),rStep)./rStep;
    elseif colorVariation==2
        M=max(0.5.*log(1+real(Z).^2+imag(Z).^2));
        magZ=0.5.*log(1+real(Z).^2+imag(Z).^2)./M;
    end
    
    % turns the arg and mag values into a set of colormaps
    argZmap=ind2rgb(uint8(255.*argZ),hsv);
    magZmap=ind2rgb(uint8(255.*magZ),gray);
    
    % plots the final result
    imagesc(x,y,magZmap,"AlphaData",0.8)
    hold on
    imagesc(x,y,argZmap,"AlphaData",0.55)
    hold off
    set(gca,'YDir','normal')
    xlabel('Re Z')
    ylabel('Im Z')
    
    colorbar('Ticks',[0 0.25 0.5 0.75 1], ...
        'TickLabels',{'-π' '-π/2' '0' 'π/2' 'π'})
    colormap(hsv)
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
