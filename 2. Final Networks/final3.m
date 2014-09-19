% this script use a NARX for predicting a time_series next values using 
% others time series 
% x is input for network x=[ts_1; ts_2; ...,ts_n]  ts = time series
% y is input and target for network y = [ts_n+1]
% the network have xxx time delays and xxx hidden neurons
clear
clc
load finalnet3.mat; % load a saved neural network
 nint=20; % number of time delays % is already loaded 
p = 100; % p is used to change the point from where I start the predictions
pp = 60; % number of predictions that we will do 
        % OBServation: pp must be smaller than p
        % OBServation: last 100 observations was not used for training the
        % network
sfarsit = length(targets3); % the length of time series
start = sfarsit-p-1; % the point from where I start the predictions
%% predictions for pp steps ahead
% we build the first input vector
for i=1:nint
    % first input for NARX network
    % inp(:,i) (input) must have the folowing form
    %   [10x1 double] <-- come from x - exogenous variables
    %   [     1.4217] <-- come from y - predicted time series
inp(:,i)= [{input(:,start-nint+i)}; targets3(start-nint+i)];

% here must be built all first inputs for the other NAR netrorks
% if they dont have the same number of time delays you will create a
% separate loop (for ik=1:td_k ... end)
% inp_k(i)= {x_k(start-nint+i)};
 end
% the expected outputs will be time_series(start+1:start+p) p - steps
% time_series(3610:3710) 100

% here must be built all first inputs

for j = 1:pp
rez(j) = final3net(inp(:,nint-1+j),inp(:,j:nint-1+j),layerStates); 
% calculate the response of network
% rez(j) = sim(net,inp(:,nint-1+j),inp(:,j:nint-1+j));% this form works as
% well
% vector={[x1,x2,. . . ,x10]} % you must construct vect using the others
% NAR networks vector must be a cell [10x1 douoble]
% all the prediction for the others time series must be calculated here

vector={[fnip(nint-1+j,1);fnip(nint+j,2);fnip(nint+j,3);fnip(nint+j,4);fnip(nint+j,5);fnip(nint+j,6);fnip(nint+j,7);fnip(nint+j,8);fnip(nint+j,9);fnip(nint+j,10)]}; % replace 1,2... 10 with your values
inp(:,nint+j)= [vector; rez(j)]; % add the output to input signal 
end

target1=transpose(targets3);


%% grafic comparativ predictii  vs  observatii
%plot([cell2mat(rez(1:p))' time_series(start+1:sfarsit)]) % grafic comparativ rezultate vs observatii
% Create figure
figure1 = figure('Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1);
box(axes1,'on');
hold(axes1,'all');
% Create multiple lines using matrix input to plot
plot1 = plot([cell2mat(rez(1:pp))' target1(start+1:start+pp)],'Parent',axes1);
set(plot1(1),'Color',[1 0 0],'DisplayName','Predictions');
set(plot1(2),'DisplayName','Observed Values','Color',[0 0 0]);
% Create xlabel
xlabel('step of predictions');
% Create ylabel
ylabel('Value of time series');
% Create legend
legend1 = legend(axes1,'show');
set(legend1,'Position',[0.17 0.75 0.22 0.12]);%% graphisc must be adapted to whatever you want to plot


%% graphic Mean Squared Errors
for i=1:pp
    ep(i)=mse(target1(start+1:start+i)-cell2mat(rez(1:i))');
    % calculate mean squared error al each steps
end
% plot(ep)% grafic erori medii patratice
% Create figure
figure1 = figure('Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1);
box(axes1,'on');
hold(axes1,'all');
% Create plot
plot(ep);
% Create xlabel
xlabel('step of prediction');
% Create ylabel
ylabel('Eroarea Medie Patratica');