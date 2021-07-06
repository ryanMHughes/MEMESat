%ISISpace antenna radiation pattern (UHF,
%2 dipole configuration)


%Creating dipole objects
dipoleAntenna1 = dipole;
dipoleAntenna2 = dipole;

%Defining dipole properties
frequency = 437.45e6; %UHF 
lambda = 3e8/frequency;

length = 0.34; %Per the datasheet, 17 for each antenna roughly equal to 2 34 cm dipole antennas
width = 0.01; %Estimated based off images of antenna system, not provided

dipoleAntenna1.Length = length;
dipoleAntenna1.Width = width;

dipoleAntenna2.Length = length;
dipoleAntenna2.Width = width;

%Orienting dipole objects into turnstile configuration

dipoleAntenna1.Tilt = [-90, -45];
dipoleAntenna1.TiltAxis = ['Y','Z'];
dipoleAntenna2.Tilt = [-90, 45];
dipoleAntenna2.TiltAxis = ['Y','Z'];

%Combining dipole objects into single antenna (conformal array)

turnstileAntenna = conformalArray;
turnstileAntenna.ElementPosition(1,:) = [0 0 0];
turnstileAntenna.ElementPosition(2,:) = [0 0 0.01]; %Slightly offset to avoid mesh collision
turnstileAntenna.Element = {dipoleAntenna1, dipoleAntenna2};
turnstileAntenna.PhaseShift = [0 90];

%Generating turnstile antenna radiation pattern

show(turnstileAntenna);

%Generating radiation pattern
azimuth_range = 0:1:360;
elevation_range = -90:1:90;

%Displaying pattern at 437.45 MHz and outputting to variables
pattern(turnstileAntenna, frequency, azimuth_range, elevation_range);

[gain, phi, theta] = pattern(turnstileAntenna, frequency, azimuth_range, elevation_range);

%Calculating front to back ratio and beam width
d_max = pattern(yagiUda,frequency,0,90);
d_back = pattern(yagiUda,frequency,0,-90);
fb_ratio = d_max - d_back

eplane_beamwidth = beamwidth(yagiUda,frequency,0,1:1:360)
hplane_beamwidth = beamwidth(yagiUda,frequency,90,1:1:360)
