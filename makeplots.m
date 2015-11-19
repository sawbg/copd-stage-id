%% Initializing Environment
close all; clc;

%% Initializing Variables
%type = 'pt';
%number = 0;

%% Time-Volume (Point Medians)
dplot(volmed);
%title('Time vs. Volume (Point Medians)');
title('Time vs. Volume');
psave('volmed');

%% Time-Volume (Point Means)
% dplot(volavg);
% title('Time vs. Volume (Point Means)');
% psave('volavg');

%% Volume-Flow (Point Medians)
dplot(flowmed);
%title('Volume vs. Flow (Point Medians)');
title('Volume vs. Flow');
psave('flowmed');

%% Volume-Flow (Point Means)
% dplot(flowavg);
% title('Volume vs. Flow (Point Means)');
% psave('flowavg');

%% Time-Flow (Point Medians)
dplot(dvolmed);
%title('Time-Flow (Point Medians)');
title('Time vs. Flow');
psave('dvolmed');

%% Time-Flow (Point Means)
% dplot(dvolmed);
% title('Time-Flow (Point Means)');
% psave('dvolavg');

%% Fitted-Point Median Stage Comparison

%% Clean-Up
close all;