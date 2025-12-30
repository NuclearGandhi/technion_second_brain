function sendcmd(s,S,x,d)
 
fwrite(s,sprintf('%s %d \r',S,round(x)));
 
if nargin>3
    pause(d)
else
pause(.5)
end
end