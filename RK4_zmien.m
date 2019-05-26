function [trajectory, iters] = RK4_zmien(krok, warunki_poczotkowe)
    stepd=krok/2;                   %krok o d³ugoœci 2 razy mniejszej
    i=int32(15/stepd);              %ustalamy liczbê kroków, startowy przedzia³ wynosi [0 15]
    Error1=zeros(int32(i/2)+1,1);   %wektory na b³êdy aproksymacji
    Error2=zeros(int32(i/2)+1,1);
    X1=zeros(int32(i/2)+1,1);       %wektor na rozwi¹zania pierwszej zmiennej
    X2=zeros(int32(i/2)+1,1);       %jw. na drug¹ zmienn¹
    Y=zeros(int32(i/2)+1,1);        %wektor ze zmienn¹ czasu
   % trajectory = zeros(1);
    x1=warunki_poczotkowe(1);                         %x1,x2,x1d,x1d - punkty które bêdziemy obliczaæ dla pe³nego
    x2=warunki_poczotkowe(2);                         %i po³owicznego kroku
    x1d=x1;
    x2d=x2;
    X1(1,1)=x1;
    X2(1,1)=x2;
    Y (1,1)=0;
    Error1(1,1)=x1;
    Error2(1,1)=x2;
    halfstep=krok/2;                %"pó³kroki" potrzebne w algorytmie
    halfstepd=krok/2;
    for n=1:i
        if(mod(n,2) == 0)
        k11=dx1(x1,x2);
        k12=dx2(x1,x2);
        k21=dx1((x1+halfstep*k11),(x2+halfstep*k12));
        k22=dx2((x1+halfstep*k11),(x2+halfstep*k12));
        k31=dx1((x1+halfstep*k21),(x2+halfstep*k22));
        k32=dx2((x1+halfstep*k21),(x2+halfstep*k22));
        k41=dx1((x1+krok*k31),(x2+krok*k32));
        k42=dx2((x1+krok*k31),(x2+krok*k32));
        x1=x1+(1/6)*krok*(k11+2*k21+2*k31+k41);
        x2=x2+(1/6)*krok*(k12+2*k22+2*k32+k42);
        X1((n/2)+1,1)=x1;
        X2((n/2)+1,1)=x2;
        end
        k11d=dx1(x1d,x2d);
        k12d=dx2(x1d,x2d);
        k21d=dx1((x1d+halfstepd*k11d),(x2d+halfstepd*k12d));
        k22d=dx2((x1d+halfstepd*k11d),(x2d+halfstepd*k12d));
        k31d=dx1((x1d+halfstepd*k21d),(x2d+halfstepd*k22d));
        k32d=dx2((x1d+halfstepd*k21d),(x2d+halfstepd*k22d));
        k41d=dx1((x1d+stepd*k31d),(x2d+stepd*k32d));
        k42d=dx2((x1d+stepd*k31d),(x2d+stepd*k32d));
        x1d=x1d+(1/6)*stepd*(k11d+2*k21d+2*k31d+k41d);
        x2d=x2d+(1/6)*stepd*(k12d+2*k22d+2*k32d+k42d);
        if(mod(n,2) == 0)
            Error1((n/2)+1,1)=(16/15)*abs(x1d-X1((n/2)+1,1)); %15 to 2^k-1 , gdzie k to stopieñ (czyli 4)
            Error2((n/2)+1,1)=(16/15)*abs(x2d-X2((n/2)+1,1));
            Y ((n/2)+1,1)= double((n/2)+1)*krok;
        end
    end
    trajectory = [X1;X2];
    iters = i;
end