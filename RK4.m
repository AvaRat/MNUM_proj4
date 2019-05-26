function [trajektoria, iters] = RK4(krok,warunki_poczotkowe)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    h = krok;
    x1=warunki_poczotkowe(1); %pierwszy pkt
    x2=warunki_poczotkowe(2); %drugi pkt
    t=0:krok:15; %iloœæ kroków
    data = zeros(length(t), 2);

    for i=1:(length(t))
        k11=dx1(x1,x2);
        k12=dx2(x1,x2);

        k21=dx1(x1+0.5*h,x2+0.5*h*k11);
        k22=dx2(x1+0.5*h,x2+0.5*h*k12);

        k31=dx1(x1+0.5*h,x2+0.5*h*k21);
        k32=dx2(x1+0.5*h,x2+0.5*h*k22);

        k41=dx1(x1+h,x2+h*k31);
        k42=dx2(x1+h,x2+h*k31);

        x1=x1+(h/6)*(k11+k41+2*(k21+k31));
        x2=x2+(h/6)*(k12+k42+2*(k22+k32));
        data(i,:) = [x1;x2];
    end
    iters = length(t);
    trajektoria = data;
end

