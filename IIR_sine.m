%Created on June 2016.

%@author: Soroosh Tayebi Arasteh <soroosh.arasteh@fau.de>
%https://github.com/tayebiarasteh
%%
clear all
clc
close all

%% Digital Filter Specifications
wp = 0.5*pi;            % digital Passband freq in Hz 
ws = 0.65*pi;            % digital Stopband freq in Hz 
Rp = 1.1103;                 % Passband ripple in dB 
As = 23.098;                % Stopband attenuation in dB

%% Analog Prototype Specifications: Inverse mapping for frequencies
T = 1;                         % Set T=1
Wp = (2/T)*tan(wp/2);          % Prototype Passband freq
Ws = (2/T)*tan(ws/2);          % Prototype Stopband freq

%% Analog Butterworth Prototype Filter Calculation
N = ceil((log10((10^(Rp/10)-1)/(10^(As/10)-1)))/(2*log10(Wp/Ws)));
fprintf('\n*** Butterworth Filter Order = %2.0f \n',N)
Wc = Wp/((10^(Rp/10)-1)^(1/(2*N)));

[z,p,k] = buttap(N);
p = p*Wc;
k = k*Wc^N;
B = real(poly(z));
bs = k*B;
as = real(poly(p));

%% Bilinear transformation
[b,a] = bilinear(bs,as,1/T);
b=b.*1.1;                    % ghablan baraye normal sazi bar 1.1 taghsim karde budim

%%
[H,w] = freqz(b,a);
grp = grpdelay(b,a,w);
subplot(231);plot(w/pi,abs(H));grid on;ylabel('Magnitude')
subplot(232);plot(w/pi,20*log10(abs(H) + eps));grid on;ylabel('Magnitude (dB)')
subplot(233);impz(b,a);grid on;
subplot(234);plot(w/pi,grp);grid on;ylabel('Group Delay')

%%

n=-50:50;
w0=5;            % For example
x=cos(w0*n);
k = 0:511; W = (pi/512)*k;
X = x*(exp(-1j*pi/512)) .^ (n'*k);     %DTFT
Y=X.*abs(H)';  
subplot(235);plot(W/pi,abs(Y));grid on;ylabel(' output')



