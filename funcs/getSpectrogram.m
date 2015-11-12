function [ s_dB, f, t ] = getSpectrogram( y, window, overlap, n, fs )
%GETSPECTROGRAM Returns spectrogram of y with frequency and time vectors
% Suggested plotting:
% surf(t, f, s_dB); shading interp; view(2)

[s,f,t] = spectrogram(y,  window, overlap, n, fs, 'yaxis');

s_dB = 20 * log10( abs( s ) );

% Find any -Inf and set to either -120 dB or lowest dB
sInfIDX = (s_dB == -Inf);

if min( s_dB( ~sInfIDX ) ) < -120
    s_dB( sInfIDX ) = min( s_dB( ~sInfIDX ) );
else
    s_dB( sInfIDX ) = -120;
end

% Normalize
%s_dB = s_dB - max(s_dB(:));

end

