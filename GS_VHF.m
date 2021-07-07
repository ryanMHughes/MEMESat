% Ground Station antenna radiation pattern (VHF Cross 
% Polarized Yagi-Uda configuration)

%Creating Yagi Objects
yagiAntenna1 = yagiUda;
yagiAntenna2 = yagiUda;

%Defining properties of both yagi objects
yagiAntenna1.Exciter = dipoleFolded;
yagiAntenna2.Exciter = dipoleFolded;

yagiAntenna1.Exciter.Width = 0.005;
yagiAntenna2.Exciter.Width = 0.005;

yagiAntenna1.Exciter.Spacing = 0.5;
yagiAntenna2.Exciter.Spacing = 0.5;

yagiAntenna1.Exciter.Length = 1;
yagiAntenna2.Exciter.Length = 1;

yagiAntenna1.NumDirectors = 9;
yagiAntenna2.NumDirectors = 9;
 
yagiAntenna1.DirectorLength = [0.93, 0.93, 0.93, 0.93, 0.93, 0.93...
    0.93, 0.93, 0.93];
yagiAntenna2.DirectorLength = [0.93, 0.93, 0.93, 0.93, 0.93, 0.93...
    0.93, 0.93, 0.93];

yagiAntenna1.DirectorSpacing = 0.47;
yagiAntenna2.DirectorSpacing = 0.47;

yagiAntenna1.ReflectorLength = 1.02;
yagiAntenna2.ReflectorLength = 1.02;

yagiAntenna1.ReflectorSpacing = 0.50; 
yagiAntenna2.ReflectorSpacing = 0.50;

%Defining antenna placement
yagiAntenna1.Tilt = 45;
yagiAntenna1.TiltAxis = 'Z';

yagiAntenna2.Tilt = -45;
yagiAntenna2.TiltAxis = 'Z';

%Combining both yagi into single antenna
crossPolYagiAntenna = conformalArray;
crossPolYagiAntenna.Element = [yagiAntenna1, yagiAntenna2];
crossPolYagiAntenna.ElementPosition(1,:) = [0 0 0];
crossPolYagiAntenna.ElementPosition(2,:) = [0 0 0.14]; %This is an estimate. Need to confirm by measuring distance between first director of each antenna for UHF yagi(offset in Z axis).
crossPolYagiAntenna.PhaseShift = [0 90];

%Showing the antenna model 
show(crossPolYagiAntenna);

%Generating and showing antenna radiation pattern
frequency = 145e6;
azimuth_range = 0:1:360;
elevation_range = -90:1:90;

pattern(crossPolYagiAntenna, frequency, azimuth_range, elevation_range);

%Outputting radiation pattern into variables
[gain,phi,theta] = pattern(crossPolYagiAntenna, frequency, azimuth_range, elevation_range);

%Calculating front to back ratio and beamwidth
d_max = pattern(crossPolYagiAntenna,frequency,0,90);
d_back = pattern(crossPolYagiAntenna,frequency,0,-90);
fb_ratio = d_max -d_back

eplane_beamwidth = beamwidth(crossPolYagiAntenna,frequency,0,1:1:360)
hplane_beamwidth = beamwidth(crossPolYagiAntenna,frequency,90,1:1:360)
