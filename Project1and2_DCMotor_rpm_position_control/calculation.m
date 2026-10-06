s=tf('s') %[output:7b22acfb]

%[text] $M\_p =e^{-\\pi \\;\\frac{\\zeta }{\\sqrt{1-\\zeta^2 }}}${"editStyle":"visual"}
Mp =5.26/100;
zeta = -log(Mp) / sqrt(pi^2 + (log(Mp))^2) %[output:81c460b0]

%[output:4c51eb11]


%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright"}
%---
%[output:7b22acfb]
%   data: {"dataType":"textualVariable","outputData":{"name":"s","value":"  s\n \nContinuous-time transfer function.\n<a href=\"matlab:disp(char([10 32 32 32 32 32 32 32 78 117 109 101 114 97 116 111 114 58 32 123 91 49 32 48 93 125 10 32 32 32 32 32 68 101 110 111 109 105 110 97 116 111 114 58 32 123 91 48 32 49 93 125 10 32 32 32 32 32 32 32 32 86 97 114 105 97 98 108 101 58 32 39 115 39 10 32 32 32 32 32 32 32 32 32 73 79 68 101 108 97 121 58 32 48 10 32 32 32 32 32 32 73 110 112 117 116 68 101 108 97 121 58 32 48 10 32 32 32 32 32 79 117 116 112 117 116 68 101 108 97 121 58 32 48 10 32 32 32 32 32 32 32 73 110 112 117 116 78 97 109 101 58 32 123 39 39 125 10 32 32 32 32 32 32 32 73 110 112 117 116 85 110 105 116 58 32 123 39 39 125 10 32 32 32 32 32 32 73 110 112 117 116 71 114 111 117 112 58 32 91 49 215 49 32 115 116 114 117 99 116 93 10 32 32 32 32 32 32 79 117 116 112 117 116 78 97 109 101 58 32 123 39 39 125 10 32 32 32 32 32 32 79 117 116 112 117 116 85 110 105 116 58 32 123 39 39 125 10 32 32 32 32 32 79 117 116 112 117 116 71 114 111 117 112 58 32 91 49 215 49 32 115 116 114 117 99 116 93 10 32 32 32 32 32 32 32 32 32 32 32 78 111 116 101 115 58 32 91 48 215 49 32 115 116 114 105 110 103 93 10 32 32 32 32 32 32 32 32 85 115 101 114 68 97 116 97 58 32 91 93 10 32 32 32 32 32 32 32 32 32 32 32 32 78 97 109 101 58 32 39 39 10 32 32 32 32 32 32 32 32 32 32 32 32 32 32 84 115 58 32 48 10 32 32 32 32 32 32 32 32 84 105 109 101 85 110 105 116 58 32 39 115 101 99 111 110 100 115 39 10 32 32 32 32 83 97 109 112 108 105 110 103 71 114 105 100 58 32 91 49 215 49 32 115 116 114 117 99 116 93 10]))\">Model Properties<\/a>"}}
%---
%[output:81c460b0]
%   data: {"dataType":"textualVariable","outputData":{"name":"zeta","value":"0.6839"}}
%---
%[output:4c51eb11]
%   data: {"dataType":"textualVariable","outputData":{"name":"G1","value":"  From input \"u1\" to output \"y1\":\n         8.906e04\n  -----------------------\n  s^2 + 1884 s + 8.166e04\n \nName: G1\nContinuous-time identified transfer function.\n\nParameterization:\n   Number of poles: 2   Number of zeros: 0\n   Number of free coefficients: 3\n   Use \"tfdata\", \"getpvec\", \"getcov\" for parameters and their uncertainties.\n\nStatus:                                            \nEstimated using TFEST on time domain data \"mydata\".\nFit to estimation data: 97.96% (stability enforced)\nFPE: 0.04815, MSE: 0.04779                         \n \n<a href=\"matlab:if exist('G1','var'), if isa(G1,'idtf'), disp(' '); disp(get(G1)), else disp(' '); disp('Unable to display properties for variable G1 because it is no longer a idtf object.');, end, else matlab.graphics.internal.getForDisplay('G1'), end\">Model Properties<\/a>"}}
%---
