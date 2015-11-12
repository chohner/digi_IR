function [ h ] = plotSpectogram( s_dB, t, f )
%PLOTSPECTOGRAM Quick plot of spectrogram data s_dB over time and frequency
    
% Plot interpolated without mesh
h = surf(t, f, s_dB);
shading interp
view(2)

title('Spectogram')
xlabel('Time [s]')
ylabel('Frequency [Hz]')

% dB Scale is rounded up to next 10 digit, lower bound is -80
caxis([-80 , ceil( max(s_dB(:)) / 10 ) * 10 ])
xlim([t(1) t(end)])
axis tight

ax = gca;
set( ax, 'YScale','log', 'YMinorTick','on', 'YDir','normal', 'xMinorTick', 'on');
ax.YTick = round( ( logspace(1,4,14) * 2 ) ./ 10 ) .* 10;

% Custom colormap viridis
colormap viridis
colorbar

end

