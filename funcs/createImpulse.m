function [ impulse ] = createImpulse( L, jackConfig )
%CREATEIMPULSE Returns audioplayer with dirac impulse of L second

fs    = jackConfig.fs;
nBits = jackConfig.nBits;
IDo   = jackConfig.IDo;

yImp = zeros( L * fs , 2 );
yImp( 1, : ) = 1;

% Audioplayer holding the generated impulse is returned
impulse = audioplayer( yImp, fs, nBits, IDo );

end

