N=10000;
noise = randn(N,1);
a = [2.76 -3.81 2.65 -0.92];
a = [1 -a];
x = filter(1,a,noise);
x = x(500:end);noise = noise(500:end); N_length = length(x);
figure(1);
plot(noise);hold on;plot(x);xlabel('Time Index');ylabel('Amplitude');title('x[n] = 2.76x[n-1]-3.81x[n-2]+2.65x[n-3]-0.92x[n-4] + w[n]');
legend('N(0,1) noise' , 'AR(4) Process')
grid on; grid minor;
set(gca,'FontSize',18)

figure(2);
[H,F] = freqz(1,a,[],1);
orders = [2 4 11];
for i = 1:length(orders)
    [Pxx,F_yulear] = pyulear(x,orders(i),1024,1); hold on;
    plot(F_yulear,10*log10(Pxx),'LineWidth',2);
end
plot(F,20*log10(abs(H)),'LineWidth',2); xlabel('Normalized Frequency (Hz)'); ylabel('PSD (dB/Hz)');title('Actual and Estimated PSD of AR(4) process, N = ' + string(N));
grid on ; grid minor; legend('AR(2)','AR(4)','AR(10)','Theoretical');
set(gca,'FontSize',18)

%%
figure(3);
xacf = xcorr(x,'unbiased'); % Autocorrelation of AR(4) process
EmpPSD = abs(fftshift(fft(xacf)));
freq = linspace(-0.5,0.5,2*N_length);
plot(freq, 10*log10(EmpPSD),'LineWidth',2); xlabel('Normalized Frequency (Hz)');ylabel('PSD (dB/Hz)');title('Empircal PSD Based on Data');
grid on; grid minor; set(gca, 'FontSize',18);legend('AR(4) Empirical PSD');


