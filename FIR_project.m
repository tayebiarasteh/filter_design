%Created on June 2016.

%@author: Soroosh Tayebi Arasteh <soroosh.arasteh@fau.de>
%https://github.com/tayebiarasteh
%%
clear all
clc
close all
%  We do not use the passband ripple value of Rp =1.1103 dB in the design, we will have to check the actual ripple from the design.

wp = 0.5*pi;
ws = 0.65*pi;
tr_width = ws - wp;
M = ceil(6.6*pi/tr_width) + 1       
wc = (ws + wp)/2;                 % Ideal LPF cutoff frequency

alpha = (M - 1)/2;
n = 0:1:(M - 1);
m = n - alpha;
fc = wc/pi;
hd = fc*sinc(fc*m);

w_ham = hamming(M)';
h = hd .* w_ham;

delta_w = 2*pi/1000;
Rp = -(min(db(1:1:wp/delta_w + 1)))               % Actual Passband Ripple Rp
As = -round(max(db(ws/delta_w + 1:1:501)))        % Min Stopband attenuation As

% plots
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


