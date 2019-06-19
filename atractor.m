clc
close all
clear all

%%INTEGRACIÓN----------------------
%Condiciones iniciales y parámetros
CI=[1; 0; 2];
realtime=1;

p.Pr=10;
p.R=28;
p.b=8/3;

s=0.05;
L=10000;
time_int=linspace(0,s*L,L);

%Inicio de la integración
U=zeros(3,L);
k=1;
U(:,k)=CI;
k=2;  %Iniciamos con Euler
[F]=lorentz( CI,p);
U(:,k)=U(:,k-1)+s*F;
count=0;
c1 = linspace(0.5,1,L);
c2 = linspace(0.2,0.5,L);
vel=500;
time(1,L)=0;time(2,L)=s;
for k=3:L;
    %Runge Kutta 4 hasta el final
    [K1]=lorentz( U(:,k-1),p);
    [K2]=lorentz( U(:,k-1)+s*0.5*K1,p);
    [K3]=lorentz( U(:,k-1)+s*0.5*K2,p);
    [K4]=lorentz( U(:,k-1)+s*K3,p);
    U(:,k)=U(:,k-1)+s/6*(K1+2*K2+2*K3+K4);
    if realtime==1&&count>L/vel;
        figure(2)
        scatter3(U(1,k),U(2,k),U(3,k),'MarkerEdgeColor',[0.6 c2(k) c1(k)],...
            'MarkerFaceColor',[0.6 c2(k) c1(k)]),grid on;
        hold on
        count=0;
    end
    time(1,k)=s*(k-1);
    count=count+1;
end


figure(1)

subplot(1,2,1),
aux=[0.6*ones(L,1) c2' c1'];
scatter3(U(1,:)',U(2,:)',U(3,:)',[],aux,'fill'),grid on;

figure(3)
subplot(3,1,1),
plot(time,U(1,:),'k-'),grid on, axis tight;
subplot(3,1,2),
plot(time,U(2,:),'k--'),grid on, axis tight;
subplot(3,1,3),
plot(time,U(3,:),'k:'),grid on, axis tight;

%%POINTCARE
CI=[1.0; -.1];
close 2
%%Otras condiciones en parametros
p.t=0;
s=0.01;
L=10000;
c1 = linspace(0.5,1,L);
c2 = linspace(0.2,0.5,L);
%Inicio de la integración
U=zeros(2,L);
k=1;
U(:,k)=CI;
k=2;  %Iniciamos con Euler
p.t=2*s;
[F]=pointcare( CI,p);
U(:,k)=U(:,k-1)+s*F;
count=0;
for k=3:L;
    p.t=k*s;
    %Runge Kutta 4 hasta el final
    [K1]=pointcare( U(:,k-1),p);
    [K2]=pointcare( U(:,k-1)+s*0.5*K1,p);
    [K3]=pointcare( U(:,k-1)+s*0.5*K2,p);
    [K4]=pointcare( U(:,k-1)+s*K3,p);
    U(:,k)=U(:,k-1)+s/6*(K1+2*K2+2*K3+K4);
    if realtime==1&&count>L/vel;
        figure(2)
        scatter(U(1,k),U(2,k),'MarkerEdgeColor',[0.6 c1(k) c1(k)],...
            'MarkerFaceColor',[0.6 c1(k) c1(k)]),grid on;
        hold on
        count=0;
    end
    count=count+1;
end
figure(1)

subplot(1,2,2),

aux=[0.6*ones(L,1) c2' c1'];
%scatter(U(1,:)',U(2,:)',[]),grid on;
plot(U(1,:)',U(2,:)','k.'),grid on;