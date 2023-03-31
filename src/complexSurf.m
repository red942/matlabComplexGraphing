function complexSurf(varargin)

    % Possible configurations of inputs:
    %
    % complexSurf(Res, Scale)
    % Res changes how many subsections of the plane are used to plot the
    % graph. Higher number means a finer plot. Scale changes the real and
    % imaginary axes scale as a square. A Scale of 5 would generate a plane
    % from -5 to 5 on the real axis and -5i to 5i on the imaginary axis
    %
    % complexSurf(Res, ScaleX, ScaleY)
    % Res changes how many subsections of the plane are used to plot the
    % graph. ScaleX changes the scale of the real axis to -ScaleX to
    % ScaleX. ScaleY changes the scale of the imaginary axis to -ScaleY*i to
    % ScaleY*i
    %
    % complexSurf(Res, Scale, [ZMin ZMax])
    % Res changes how many subsections of the plane are used to plot the
    % graph. Scale changes the real and imaginary axes scale as a square.
    % The vector sets the bounds of the Z axis for both plots
    %
    % complexSurf(Res, ScaleX, ScalY, [ZMin ZMax])
    % All of the above

    % Sets variables based on input. See above comment for details
    N=varargin{1};

    if nargin==2
        Rx=varargin{2};
        Ry=varargin{2};
    elseif nargin==3 && length(varargin{3})==2
        ZLim=varargin{3};
        Rx=varargin{2};
        Ry=varargin{2};
    elseif nargin==3 && length(varargin{3})==1
        Rx=varargin{2};
        Ry=varargin{3};
    elseif nargin==4
        Rx=varargin{2};
        Ry=varargin{3};
        ZLim=varargin{4};
    end
    
    % Establishes essential variables from input argument
    a=linspace(-Rx,Rx,N);
    b=linspace(-Ry,Ry,N);
    [X,Y]=meshgrid(a,b);
    Z = @(z) zeta(z);
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

    if nargin==3 && length(varargin{3})==2 || nargin==4
        zlim(ZLim);
    end

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
   
    if nargin==3 && length(varargin{3})==2 || nargin==4
        zlim(ZLim);
    end

    xlabel('Re Z')
    ylabel('Im Z')
    zlabel('Im W')
    c2=colorbar;
    c2.Label.String=str2;
    colormap(hsv)

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
