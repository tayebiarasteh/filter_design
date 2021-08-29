%Created on June 2016.

%@author: Soroosh Tayebi Arasteh <soroosh.arasteh@fau.de>
%https://github.com/tayebiarasteh
%%
clear all
clc
close all
%  We do not use the passband ripple value of Rp =1.1103 dB in the

wp = 0.5*pi;
ws = 0.65*pi;
As = 23.098;
tr_width = ws - wp;
M = ceil((As-7.95)/(2.285*tr_width)+1) + 1
beta = 0.5842*(As-21).^.4+.07886*(As-21)
wc = (ws+wp)/2;

alpha = (M - 1)/2;
n = 0:1:M - 1;
m = n - alpha;
fc = wc/pi;
hd = fc*sinc(fc*m);

w_kai = kaiser(M,beta)';
h = hd .* w_kai;
h=h.*1.1;                    % ghablan baraye normal sazi bar 1.1 taghsim karde budim


delta_w = 2*pi/1000;
Rp = -(min(db(1:1:wp/delta_w + 1)))               % Actual Passband Ripple Rp
As = -round(max(db(ws/delta_w + 1:1:501)))        % Min Stopband attenuation As

%% plots
subplot(2,3,3); stem(n,h); grid on; title('Actual Impulse Response')
axis([0 M-1 -0.1 0.3]);
xlabel('n'); ylabel('h(n)')
[H,w] = freqz(h,1);
a=1; b=h;
grp = grpdelay(b,a,w);
subplot(231);plot(w/pi,abs(H));grid on;ylabel('Magnitude')
subplot(232);plot(w/pi,20*log10(abs(H) + eps));grid on;ylabel('Magnitude (dB)')
subplot(234);plot(w/pi,grp);grid on;ylabel('Group Delay')
subplot(236);impz(b,a);grid on;

%%

n=-50:50;
w0=5;            % For example
x=cos(w0*n);
k = 0:511; W = (pi/512)*k;
X = x*(exp(-1j*pi/512)) .^ (n'*k);       %DTFT
Y=X.*abs(H)';  
subplot(235);plot(W/pi,abs(Y));grid on;ylabel(' output')
