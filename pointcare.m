function [ dU ] = pointcare( U,p )
%LORENTZ Summary of this function goes here
%   Detailed explanation goes here
A=.1;
B=100;
C=.01;
f=1/8;
            dU(1,1)=U(2);
            dU(2,1)=B*cos(2*pi*f*p.t)-U(1)^3-C*U(1)-A*(U(1)^2-1)*U(2);

end

