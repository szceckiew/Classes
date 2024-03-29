clear all;
close all;
y_raw=[23.97
23.88
23.54
24.03
23.86
23.74
23.59
23.96
24.13
22.99
23.23
23.07
23.88
23.69
23.35
23.48
23.10
22.72
22.18
22.25
23.16
22.70
22.35
21.22
20.93
21.61
21.49
21.58
21.09
20.86
20.94
20.96
21.43
21.59
21.93
21.71
21.61
21.04
21.39
20.77
20.85
19.45
19.16
19.63
19.16
19.26
19.55
19.61
19.33
19.30
19.42
18.61
18.41
18.77
18.66
18.28
18.87
19.06
19.12
19.64
20.13
20.60
20.68
21.02
20.77
19.03
18.91
18.84
18.39
18.44
18.88
19.67
19.47
19.29
19.54
19.61
18.97
19.65
19.35
19.85
18.84
18.58
18.45
17.98
18.22
18.06
17.83
17.91
18.40
18.79
18.91
19.20
19.12
19.09
18.96
19.06
19.51
19.82
20.13
20.25
20.82
20.28
20.60
20.52
20.71
19.90
20.21
19.99
19.87
20.33
20.36
19.95
19.15
18.68
18.40
18.61
18.82
18.68
18.77
18.71
18.71
18.45
19.13
18.90
19.10
19.32
19.26
19.18
19.24
19.99
19.89
20.27
20.75
20.82
21.16
21.15
21.01
21.39
21.62
21.60
21.68
21.87
21.72
21.10
21.13
21.89
21.65
22.05
22.24
22.04
21.93
22.38
21.79
21.55
21.93
22.12
22.02
21.99
22.13
21.76
21.75
21.91
21.34
21.63
21.60
21.11
20.82
21.54
21.27
21.82
22.36
22.47
23.01
22.60
22.64
22.76
23.18
23.33
23.60
23.69
24.14
24.63
25.17
25.11
25.86
25.32
25.67
25.67
25.40
25.10
24.78
24.64
24.41
24.28
24.52
24.62
24.80
24.90
24.74
24.94
25.53
25.58
25.18
24.76
25.23
24.96
25.40
25.15
24.94
25.08
25.85
25.90
25.64
26.46
25.70
25.74
25.10
25.25
25.37
24.42
24.25
24.20
24.55
24.14
24.01
23.94
23.84
23.59
23.38
23.88
23.57
23.18
23.30
23.20
23.04
22.50
22.42
22.62
22.63
22.48
22.47
22.75
23.59
23.90
23.95
24.29
24.39
24.09
23.47
23.02
22.96
23.06
23.13
22.76
22.50
22.37
22.19
22.78
23.06
22.92];

x_raw=1:1:length(y_raw);
y_raw=y_raw';

dlugosc_zloto_raw=length(y_raw);

%przedział
x1=200;
x2=260;

dlekstra=5;

x=x_raw(x1:1:x2);
y=y_raw(x1:1:x2);

x=x-x1+1;

xtemp=x;
ytemp=y;

dlugosc=length(y);
%X8



for m=dlugosc+1:1:dlugosc+dlekstra
    y(m)=(y(m-2)+(m-x(m-2))/(x(m-1)-x(m-2)) * (y(m-1)-y(m-2)));
    x(m)=m;
end

plot(x, y, Color="red");
hold on;
plot(xtemp, ytemp, Color="green");
