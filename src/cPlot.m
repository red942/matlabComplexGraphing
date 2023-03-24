function cPlot(q)
    if q==1
        L=input("L: ");
        Rx=input("Rx: ");
        Ry=input("Ry: ");
        domainColor(L,Rx,Ry)
    elseif q==2
        R=input("R: ");
        complexSurf(R)
    end
end

function domainColor(L,Rx,Ry)
    % sets up variables and functions for the rest of the code
    f = @(z) (zeta1(z)-zeta(z))./zeta(z);
    x=linspace(-Rx,Rx,L);
    y=linspace(-Ry,Ry,L);
    [X,Y] = meshgrid(x,y);
    Z=f(X + 1i.*Y);
    x=[-Rx Rx];
    y=[-Ry Ry];

    % just to get rid of the annoying warnings
    gamma(0);
    zeta1(2);
    digamma(0);
    
    % decides how to color the final plot
    colorVariation=0;
    
    % argument and magnitude for every point in Z
    argZ=(angle(Z)+pi)/(2.*pi);
    if colorVariation==0
        magZ=mod(0.5.*log(real(Z).^2+imag(Z).^2),1)./1;
    elseif colorVariation==1
        magZ=mod(0.5.*log(1+real(Z).^2+imag(Z).^2),log(0.1))./log(0.1);
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
    xlabel('Re')
    ylabel('Im')
end

function complexSurf(R)
    a=linspace(-R,R,300);
    b=linspace(-R,R,300);
    [X,Y]=meshgrid(a,b);
    Z = @(z) gamma(z);
    W=Z(X+1i.*Y);
    C1=imag(W);
    C2=real(W);
    
    % First plot graphing and labels
    nexttile
    surf(X,Y,C2,C1,"EdgeColor","none");
    zlim([-2 6])
    xlabel('Re Z')
    ylabel('Im Z')
    zlabel('Re W')
    c1=colorbar;
    c1.Label.String='Im W';
    colormap(hsv)

    % Second plot graphing and labels
    nexttile
    surf(X,Y,C1,C2,"EdgeColor","none");
    zlim([-2 6])
    xlabel('Re Z')
    ylabel('Im Z')
    zlabel('Im W')
    c2=colorbar;
    c2.Label.String='Re W';
    colormap(hsv)

    hold off
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

% digamma approxination for complex values
function z=digamma(z)
sz=size(z);
z=z(:);
for k=1:length(z)
    if (imag(z(k))==0 && -z(k)-floor(abs(z(k)))==0)
        z(k)=NaN; 
    else
        if abs(z(k))<=1
            z(k)=digammasmall(z(k));
        elseif real(z(k))>=10 && abs(z(k))>=10
            z(k)=digammalarge(z(k));
        else 
            if (real(z(k))<10 && abs(imag(z(k)))<1)
                if real(z(k))>0
                    n=1:floor(real(z(k)));
                    z(k)=digammasmall(z(k)-floor(real(z(k)))) ...
                        + sum(1./(z(k)-n));
                else
                    n=0:-ceil(real(z(k)))-1;
                    z(k)=digammasmall(z(k)-ceil(real(z(k)))) ...
                        - sum(1./(z(k)+n));
                end
            else
                if real(z(k))>=0
                    n=0:10;
                    z(k)=digammalarge(z(k)+11)-sum(1./(z(k)+n));
                else
                    n=1:11;
                    z(k)=digammalarge(z(k)-11)+sum(1./(z(k)-n));
                end
            end
        end
    end
end
z=reshape(z,sz);
end

function d=digammasmall(z)
zt=[0.6449340668482264364724    ; 0.202056903159594285399738;
    0.8232323371113819151600e-1 ; 0.36927755143369926331365e-1;
    0.1734306198444913971451e-1 ; 0.8349277381922826839798e-2;
    0.4077356197944339378684e-2 ; 0.2008392826082214417853e-2;
    0.9945751278180853371459e-3 ; 0.4941886041194645587023e-3;
    0.2460865533080482986380e-3 ; 0.1227133475784891467518e-3;
    0.6124813505870482925855e-4 ; 0.3058823630702049355173e-4;
    0.1528225940865187173257e-4 ; 0.7637197637899762273600e-5;
    0.3817293264999839856462e-5 ; 0.1908212716553938925657e-5;
    0.9539620338727961131520e-6 ; 0.4769329867878064631167e-6;
    0.2384505027277329900036e-6 ; 0.1192199259653110730678e-6;
    0.5960818905125947961244e-7 ; 0.2980350351465228018606e-7;
    0.1490155482836504123466e-7 ; 0.7450711789835429491981e-8;
    0.3725334024788457054819e-8 ; 0.1862659723513049006404e-8;
    0.9313274324196681828718e-9 ; 0.4656629065033784072989e-9;
    0.2328311833676505492001e-9 ; 0.1164155017270051977593e-9;
    0.5820772087902700889244e-10; 0.2910385044497099686929e-10;
    0.1455192189104198423593e-10; 0.7275959835057481014521e-11;
    0.3637979547378651190237e-11; 0.1818989650307065947585e-11;
    0.9094947840263889282533e-12; 0.4547473783042154026799e-12;
    0.2273736845824652515227e-12; 0.1136868407680227849349e-12;
    0.5684341987627585609277e-13; 0.2842170976889301855455e-13;
    0.1421085482803160676983e-13; 0.7105427395210852712877e-14;
    0.3552713691337113673298e-14; 0.1776356843579120327473e-14;
    0.8881784210930815903096e-15; 0.4440892103143813364198e-15;
    0.2220446050798041983999e-15; 0.1110223025141066133721e-15;
    0.5551115124845481243723e-16; 0.2775557562136124172582e-16;
    0.1387778780972523276284e-16; 0.6938893904544153697446e-17;
    0.3469446952165922624744e-17; 0.1734723476047576572049e-17;
    0.8673617380119933728342e-18; 0.433680869002065048750e-18;
    0.2168404344997219785014e-18; 0.108420217249424140646e-18;
    0.5421010862456645410919e-19; 0.2710505431223468831955e-19;
    0.1355252715610116458149e-19; 0.6776263578045189097995e-20;
    0.3388131789020796818086e-20; 0.1694065894509799165406e-20];
  K=0:length(zt)-1;
  K=reshape(K,size(zt));
  d=-1./z - 0.5772156649015328606065121+sum((-1).^K.*zt.*z.^(K+1))+z/(1+z);
end

function z=digammalarge(z)
z=abs(z)*exp(1i*angle(z)); 
  if real(z)>=0
      z=digammal(z);
  else 
      N=-floor(real(z))+22;
      n=0:N-1;
      z=digammalarge(z+N)-sum(1./(z+n));
  end
    function z=digammal(z)
      B=[ 0.166666666666666666666667    ; -0.3333333333333333333333333e-1;
          0.238095238095238095238095e-1 ; -0.3333333333333333333333333e-1;
          0.7575757575757575757575768e-1; -.2531135531135531135531136    ;
          1.166666666666666666666667    ; -7.092156862745098039215686    ;
          54.97117794486215538847118    ; -529.1242424242424242424242    ;
          6192.123188405797101449275    ; -86580.25311355311355311355    ;
          1425517.166666666666666667    ; -27298231.06781609195402299    ;
          601580873.9006423683843039    ; -15116315767.09215686274510    ;
          429614643061.1666666666667    ; -13711655205088.33277215909    ;
          488332318973593.1666666667    ; -19296579341940068.14863267    ;
          841693047573682615.0005537    ; -40338071854059455413.07681    ;
          2115074863808199160560.145    ; -120866265222965259346027.3]   ;
      K=1:length(B)+1;
      B=reshape(B,size(K));
      z=log(z)-1/(2*z) - sum(B./(2*K.*z.^(2*K)));
    end 
end 
