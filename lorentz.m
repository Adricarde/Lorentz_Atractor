function [ dU ] = lorentz( U,p )
%LORENTZ Summary of this function goes here
%   Detailed explanation goes here
            dU(1,1)=p.Pr*(U(2)-U(1));
            dU(2,1)=-U(1)*U(3)+U(1)*p.R-U(2);
            dU(3,1)=U(1)*U(2)-p.b*U(3);
end

