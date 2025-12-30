function s=find_com_port1(com)
%find available com port
% if there's more than one, take the last one
% since COM1 is usally part of the hardware (old PCs)
% for MATLAB 2023b
%Izhak Bucher Jan-2024
% for the Microprocessor based product design course

if nargin>0
    s = serialport(com,115200);
else
s=serialportlist; % find all serial ports on the PC

s=s{end};
%s='COM3'  for bluetooth
freeports = serialportlist("available"); % not used, but can make sure which is free

if isempty(findstr(s,freeports{end}))
    disp 'not free, assuming it is already open'
    return  % port is not free, assume it is open and return
end
s = serialport(s,115200)
end
%s.Terminator=0;
configureTerminator(s,13);
         
%s.InputBufferSize = 2^20;
try
 fopen(s); % open for comm.
catch % not open or already open
    delete(s)
    s=find_com_port1; % recursive,
    disp('already open, trying again')
    end
end