% this script use a NAR for predictions for predicting time_series next values 
% time_series_100 has 100 observations less than time_series
% time_series_100 was used for training the network
% the network have 20 time delays and 45 hidden neurons
clear
clc
load cpinet.mat; % load a saved neural network
load crudeoilnet.mat;
load goldnet.mat;
load inflationratenet.mat;
load usdaudask.mat;
load usdcadask.mat;
load usdchfask.mat;
load usdgbpask.mat;
load usdjpyask.mat;

nint=20; % number of time delays
p = 100; % p is used to change the point from where I start the predictions
pp = 60; % number of predictions that we will do 
        % OBServation: pp must be smaller than p
        % OBServation: last 100 observations was not used for training the
        % network
sfarsit1 = length(cpi); % the length of time series
start1 = sfarsit1-p-1; % the point from where I start the predictions
sfarsit2 = length(CRUDEOILPRICE); % the length of time series
start2 = sfarsit2-p-1; % the point from where I start the predictions
sfarsit3 = length(GOLDPRICE); % the length of time series
start3 = sfarsit3-p-1; % the point from where I start the predictions
sfarsit4 = length(inflationrate); % the length of time series
start4 = sfarsit4-p-1; % the point from where I start the predictions
sfarsit5 = length(USDAUDASK); % the length of time series
start5 = sfarsit5-p-1; % the point from where I start the predictions
sfarsit6 = length(USDCADASK); % the length of time series
start6 = sfarsit6-p-1; % the point from where I start the predictions
sfarsit7 = length(USDCHFASK); % the length of time series
start7 = sfarsit7-p-1; % the point from where I start the predictions
sfarsit8 = length(USDGBPASK); % the length of time series
start8 = sfarsit8-p-1; % the point from where I start the predictions
sfarsit9 = length(USDJPYASK); % the length of time series
start9 = sfarsit9-p-1; % the point from where I start the predictions


%% predictions for pp steps ahead
% we build the first input vector
for i=1:nint
cpiintrare(i) = {cpi(start1-nint+i)};
crudeoilintrare(i)={CRUDEOILPRICE(start2-nint+i)};
goldintrare(i)={GOLDPRICE(start3-nint+i)};
inflationintrare(i)={inflationrate(start4-nint+i)};
usdaudintrare(i)={USDAUDASK(start5-nint+i)};
usdcadintrare(i)={USDCADASK(start6-nint+i)};
usdchfintrare(i)={USDCHFASK(start7-nint+i)};
usdgbpintrare(i)={USDGBPASK(start8-nint+i)};
usdjpyintrare(i)={USDJPYASK(start9-nint+i)};
end
% the expected outputs will be time_series(start+1:start+p) p - steps
% time_series(3610:3710) 100

for i = 1:9
for j = 1:pp
    if(i==1)
        
        %rez(j) = usdaudasknet(intrare(nint-1+j),intrare(j:nint-1+j),layerStates); % calculeaza raspunsul retelei
        cpirez(j) = sim(cpinet,cpiintrare(nint-1+j),cpiintrare(j:nint-1+j));
        cpiintrare(nint+j)= cpirez(j); % add the output to input signal 
    end
    if(i==2)
        
            crudeoilrez(j) = sim(crudeoilnet,crudeoilintrare(nint-1+j),crudeoilintrare(j:nint-1+j));
            crudeoilintrare(nint+j)= crudeoilrez(j); % add the output to input signal 
    end
    if(i==3)
        
            goldrez(j) = sim(goldnet,goldintrare(nint-1+j),goldintrare(j:nint-1+j));
            goldintrare(nint+j)= goldrez(j); % add the output to input signal 
    end
    if(i==5)
        
           usdaudrez(j) = sim(usdaudasknet,usdaudintrare(nint-1+j),usdaudintrare(j:nint-1+j));
           usdaudintrare(nint+j)= usdaudrez(j); % add the output to input signal 
    end
    if(i==6)
        
        usdcadrez(j) = sim(usdcadasknet,usdcadintrare(nint-1+j),usdcadintrare(j:nint-1+j));
        usdcadintrare(nint+j)= usdcadrez(j); % add the output to input signal 
    end
    if(i==7)
        
         usdchfrez(j) = sim(usdchfnet,usdchfintrare(nint-1+j),usdchfintrare(j:nint-1+j));
         usdchfintrare(nint+j)= usdchfrez(j); % add the output to input signal 
    end
    if(i==8)
          usdgbprez(j) = sim(usdgbpnet,usdgbpintrare(nint-1+j),usdgbpintrare(j:nint-1+j));
          usdgbpintrare(nint+j)= usdgbprez(j); % add the output to input signal 
            
    end
    if(i==9)
          usdjpyrez(j) = sim(usdjpynet,usdjpyintrare(nint-1+j),usdjpyintrare(j:nint-1+j));
          usdjpyintrare(nint+j)= usdjpyrez(j); % add the output to input signal 
            
    end
    if(i==4)
          inflationrez(j) = sim(inflationnet,inflationintrare(nint-1+j),inflationintrare(j:nint-1+j));
         inflationintrare(nint+j)= inflationrez(j); % add the output to input signal 
    end
end
end