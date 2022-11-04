%program for watermarking in spatial domain
close all
clear
clc

%reading the input image for watermarking
img=imread('baby.jpg');
img=rgb2gray(img);
img=imresize(img,[300,300]);
img=double(img);

imshow(uint8(img)),title('Original Image')
[p,q]=size(img);
p1=p;
q1=q;

%initialization of weight of watermarking
c=0.001;

%generating the key as watermark
n=rgb2gray(imread('key.jpg'));
key=imresize(double(n),[p,q]);

figure, imshow(uint8(key)),title('key')

%compute 2D wavelet transform
[ca,ch,cv,cd]=dwt2(img,'db1');

%perform watermarking
y= [ca,ch;cv,cd];
Y= y+c*key;
p= p/2;
q= q/2;

for i=1:p
    for j=1:q
        nca(i,j)=Y(i,j);
        nch(i,j)=Y(i+p,j);
        ncv(i,j)=Y(i,j+q);
        ncd(i,j)=Y(i+p,j+q);
    end
end

%Display of watermark image
wimg=idwt2(nca,nch,ncv,ncd,'db1');
figure,imshow(uint8(wimg)),title('Watermarked Image');

%Extraction of key from watermarked image
%compute 2D wavelet transform
[rca,rch,rcv,rcd]=dwt2(wimg,'db1');
n1=[rca,rch;rcv,rcd];
N1=n1-y;

% Display of watermark key
figure, imshow(double(N1*4)),title('Extracted key from Watermarked image');