function [ h ] = plotFFT( y_dB, f )
%PLOTFFT Quickly plot FFT over frequency

h = semilogx( f , y_dB);
grid on
legend( 'Left Channel' , 'Right Channel' , 'location' , 'southeast' )
xlabel( 'Frequency [Hz]' )
ylabel( 'Amplitude [dBFS]' )
title( 'Frequency Response' )

% dB Scale is rounded up to next 10 digit, lower bound is -80
ylim([-80 , ceil( max( y_dB(:) ) / 10 ) * 10 ])
xlim([ 20 , 20000 ])

end

