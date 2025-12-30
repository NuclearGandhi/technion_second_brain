%% test_cart_rec.m
% test the wiggler in open loop 
% class demo
%
% 13-dec-2025
% Izhak Bucher 
clear  Y U X s
s=find_com_port1('COM9');
 
%%
 
 sendcmd(s,'t', STEP );
 
sendcmd(s,'mode', DO_RECORD );
pause(20)
  sendcmd(s,'mode', DO_SEND );
pause(3)
  
data = read(s, 1000*5, "int16");
X=reshape(data,[5 1000 ])';
U = X(:,5)-X(1,5);
Y = X(:,1:4) ;
ym = (max(Y(100:end-100,:))+min(Y(100:end-100,:)))/2;
for q=1:4
     
    Y(:,q) = Y(:,q)-ym(q);
end
    %[bytes U]=get_vector_bin_int16(s,1,2000); % get vector from UART
	
    clf
plot([Y U])
shg
 
%%
 Ts=1/50;
for q=1:4
  Z = iddata(diff(Y(100:end-100,q)),U(101:end-100,1),1/50);
    Z1 = iddata( (Y(100:end-100,q)),U(100:end-100,1),1/50);

%Z = iddata( (Y(:,q)),U(:,q),1/50); 
    
    mdlv = oe(Z,[2 2 1]);
       mdl = oe(Z1,[2 2 1]);
    figure, compare(mdl,Z1)
    figure, compare(mdlv,Z)
    

    shg
    pause(1)
    MDL{q} = mdl;
    MDLv{q} = mdlv;
    
 end
 
%%
 
