%% Clear
clc; clear; close all; 
%% Patch
addpath('../MTHT2D/images/');
addpath('../MTHT2D/lib/');
addpath('../MTHT2D/results/');
%% Folders
foldername_plots1 = 'results/Vesselness/png/';
foldername_plots2 = 'results/Vesselness/mat/';
foldername_plots3 = 'results/Neuritenees/png/';
foldername_plots4 = 'results/Neuritenees/mat/';
ext1 = '.png';
ext2 = '.mat';
foldername = './images/';
filename = 'fungus';
%% Load image
im = imread([foldername filename ext1]); 
%% Normalize & Complement
im = Normalize(im);
%im = rgb2gray(im);
%im = imcomplement(im);
%% Parameters setting
no = 12; %number of orientations 
o = 0:180/no:180-180/no;
s = 2:2:20; %scale
beta = 100; c = 15; %parameters for the Vesselness
alfa = -1/3; %parameters for the Neuritenees
%% Multiscale Top Hat Tensor
[Vmax,Nmax] = MTHT2D(im,o,s,no,beta,c,alfa);
%% Display
figure, imagesc(Vmax), title('MTHT Vesselness'); colormap gray; axis equal; axis off;
figure, imagesc(Nmax), title('MTHT Neuritenees'); colormap gray; axis equal; axis off;
%% Save and Write
%Save as 'png' image
imwrite(Vmax,(fullfile(foldername_plots1,[filename ext1])),'XResolution',300);
imwrite(Nmax,(fullfile(foldername_plots3,[filename ext1])),'XResolution',300);
%Save as 'mat' file
save((fullfile(foldername_plots2,[filename ext2])),'Vmax');
save((fullfile(foldername_plots4,[filename ext2])),'Nmax');