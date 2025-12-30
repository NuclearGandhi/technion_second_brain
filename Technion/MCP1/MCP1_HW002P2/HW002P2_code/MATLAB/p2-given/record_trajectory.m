%% record_trajectory.m
% test the wiggler in open loop 
% class demo
%
% 27-dec-2025
% Izhak Bucher 
clear  Y U X s
s=find_com_port1('COM9');
 
%%
 fwrite(s,'t');  % start trajectory
pause(90)
  fwrite(s,'x');  % transfer
 
data = read(s, 257, "int16");
 plot(data)
 shg