function [ y_dB, f_fft ] = easyFFT( y, fs )
%EASYFFT Quick FFT of y at sampling rate fs. Return amplitude and frequency
%vector

y_FFT = fft(y);
L_in = length(y);

% Take dbFS
y_dB = 20 * log10( abs( y_FFT) );

% Only take first half of spectrum
y_dB = y_dB( 1 : ceil( length(y_dB) / 2) , : );

% Frequency vector
f_fft = fs * ( 0 : ( L_in / 2 - 1 ) ) / L_in;

% Normalize
%y_dB = y_dB - max(y_dB(:));

end

