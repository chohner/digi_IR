# Digital IR measurements from Matlab
Use Jack to measure impulse responses from digital system directly from Matlab.

## Installation
1. Download & install Jack: http://jackaudio.org
2. Put the provided function in a path where Matlab can find them

## Setup
1. Set up jackConfig (See `digiIR.m` for full example)
2. Run `startJack(configJack)`
3. Connect your application / system to Jack
4. Run `setupJack(configJack)`

## Usage
If the setup is complete, you may probe your system by simply running

```matlab
[ y, t ] = recordImpulse( 1, recorder, jackConfig);
```

### jackConfig
jackConfig is a struct that contains all necessary configuration variables:
```matlab
jackConfig.jackpath = '/path/to/jack/'; % Default: /usr/local/bin/
jackConfig.App = 'APP'; % Default: Live
jackConfig.fs = 8000 - 192000; % Default: 44100
jackConfig.nBits = 4 - 32; % Default: 16
jackConfig.nChannels = 1 - 128; % Default: 2
jackConfig.framesize = 16 - 1024; % Default: 256
jackConfig.verbose = true/false; % Default: true
jackConfig.IDi = int; % Only after setupJack()
jackConfig.IDo = int; % Only after setupJack()
```
Probably stick to defaults for now.

### Plotting
Several functions for convenient plotting are provided:
* `plotIR( y, t )` plots the IR y in the time domain.
* `plotSpectrogram( y, window, overlap, n, fs )` plots a spectrogram (frequency spectrum over time). The colormap is matplotlib's new default viridis.
* `plotFFT( y, fs )` plots the overall frequency spectrum.

They employ `getSpectrogram( y, window, overlap, n, fs )` and  `easyFFT( y, fs )` respectively.

### OSX only (for now)
Only tested on Mac OSX 10.10.5 with Jack 1.9.10 and Ableton Live.
For non-OSX, maybe try adjusting the `-d coreaudio` backend driver in the `startJack.m` function.

#### Christoph Hohnerlein
mail@chrisclock.com, chohner@ccrma.stanford.edu

Nov 12, 2015

