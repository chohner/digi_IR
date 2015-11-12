function [ h ] = plotIR( y, t )
%PLOTIR Quickly plot a IR y over time t

h = plot(t, y);
ylim([-1 1])

grid on
title('Recorded impulse')
xlabel('Time [s]')
ylabel('Amplitude')

end

