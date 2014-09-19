% this script use a NAR for predictions for predicting time_series next values 
% time_series_100 has 100 observations less than time_series
% time_series_100 was used for training the network
% the network have 20 time delays and 25 hidden neurons
clear
clc
load usdjpyask.mat; % load a saved neural network

nint=20; % number of time delays
p = 100; % p is used to change the point from where I start the predictions
pp = 60; % number of predictions that we will do 
        % OBServation: pp must be smaller than p
        % OBServation: last 100 observations was not used for training the
        % network
sfarsit = length(USDJPYASK); % the length of time series
start = sfarsit-p-1; % the point from where I start the predictions
%% predictions for pp steps ahead
% we build the first input vector
for i=1:nint
usdjpyaskintrare(i) = {USDJPYASK(start-nint+i)};
end
% the expected outputs will be time_series(start+1:start+p) p - steps
% time_series(3610:3710) 100

for j = 1:pp
%rez(j) = usdgbpasknet(intrare(nint-1+j),intrare(j:nint-1+j),layerStates); % calculeaza raspunsul retelei
usdjpyaskrez(j) = sim(usdjpynet,usdjpyaskintrare(nint-1+j),usdjpyaskintrare(j:nint-1+j));
usdjpyaskintrare(nint+j)= usdjpyaskrez(j); % add the output to input signal 
end
%% grafic comparativ predictii  vs  observatii
%plot([cell2mat(rez(1:p))' time_series(start+1:sfarsit)]) % grafic comparativ rezultate vs observatii
% Create figure
figure1 = figure('Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1);
box(axes1,'on');
hold(axes1,'all');
% Create multiple lines using matrix input to plot
plot1 = plot([cell2mat(usdjpyaskrez(1:pp))' USDJPYASK(start+1:start+pp)],'Parent',axes1);
set(plot1(1),'Color',[1 0 0],'DisplayName','Predictions');
set(plot1(2),'DisplayName','Observed Values','Color',[0 0 0]);
% Create xlabel
xlabel('step of predictions');
% Create ylabel
ylabel('Value of time series');
% Create legend
legend1 = legend(axes1,'show');
set(legend1,'Position',[0.17 0.75 0.22 0.12]);

%% grafic erori = ovservatii - predictii
% plot( time_series(start+1:start+pp)-cell2mat(rez(1:pp))') % graf pt oriz pred
% plot( time_series(start+1:sfarsit)-cell2mat(rez(1:p))') % grafic erori ovservatii-rezultate
% Create figure
figure1 = figure('Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1,'YGrid','on',...
    'Position',[0.131479289940828 0.112824858757062 0.775 0.815]);
% Uncomment the following line to preserve the Y-limits of the axes
 ylim(axes1,[-0.1 0.1]);
box(axes1,'on');
hold(axes1,'all');
% Create plot
plot(USDJPYASK(start+1:start+pp)-cell2mat(usdjpyaskrez(1:pp))');
% Create xlabel
xlabel('step of prediction');
% Create ylabel
ylabel('error');
%% graphic Mean Squared Errors
for i=1:pp
    ep(i)=mse(USDJPYASK(start+1:start+i)-cell2mat(usdjpyaskrez(1:i))');
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