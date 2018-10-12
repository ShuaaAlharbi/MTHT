%% Clear
clc; clear; close all; 
%% Patch
addpath('../MTHT3D/images/');
addpath('../MTHT3D/lib/');
addpath('../MTHT3D/results/');
%% Folders
foldername_plots1 = 'results/Vesselness/png/';
foldername_plots2 = 'results/Vesselness/mat/';
foldername_plots3 = 'results/Neuritenees/png/';
foldername_plots4 = 'results/Neuritenees/mat/';
ext = '.tif';
ext1 = '.png';
ext2 = '.mat';
foldername = './images/';
filename = '0.1tnov';
%% Load image
im = load3D([foldername filename ext]); 
%% Normalize & Complement
im = Normalize(im);
%im = imcomplement(im);
%im = rgb2gray(im);
%% Parameters setting
no = 12; %number of orientations 
s = 2:2:20; %scale
beta = 70; alpha = 0.5;  c = 15; %parameters for the Vesselness
alfa = -1/3; %parameters for the Neuritenees
%% Multiscale Top Hat Tensor
[Vmax,Nmax] = MTHT3D(im,s,no,beta,alpha,c,alfa);
%% Display
figure, imagesc(max(Vmax,[],3)), title('MTHT Vesselness'); colormap gray; axis equal; axis off;
figure, imagesc(max(Nmax,[],3)), title('MTHT Neuritenees'); colormap gray; axis equal; axis off;
%% Save and Write
%Save as 'png' image
mVmax = max(Vmax,[],3);
mNmax = max(Nmax,[],3);
imwrite(mVmax,(fullfile(foldername_plots1,[filename ext1])),'XResolution',300);
imwrite(mNmax,(fullfile(foldername_plots3,[filename ext1])),'XResolution',300);
%Save as 'mat' file
save((fullfile(foldername_plots2,[filename ext2])),'Vmax');
save((fullfile(foldername_plots4,[filename ext2])),'Nmax');