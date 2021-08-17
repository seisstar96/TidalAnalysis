clc;clear;close all

%%%%%Input: 
data = load('SCEC_1981_2018_m1.5_pre.txt'); 
%[year mon day hour min sec ID lat lon depth mag]
%%%%%% 
pb = load('probabilities.SCEC_HYM_m1.5.txt');
%[pb]
%%%%%% ETAS probability for each events 
%%[year mon day hour min sec lat lon depth mag  ID ]

%%%%% OutPut
n1='SCEC_m1.5_etas_Decluster_catalog.txt';
%%%%%

data = sortrows(data,[1:6]);
year = data(:,1);
month = data(:,2);
day = data(:,3);
hour = data(:,4);
minute = data(:,5);
sec = data(:,6);
lat = data(:,8);
t1=datenum(year,month,day,hour,minute,sec);

%%%%
len = length(data);
a = 0;
b = 1;
U = a + (b-a).*rand(len,1);
Bg_events =[];
Backgroundevs = [];
for i = 1:1:len
    if U(i)< pb(i)
        Bg_events = [Bg_events;[t1(i),lat(i)]];
        Backgroundevs = [Backgroundevs;[data(i,:),t1(i),pb(i)]];
    end 
end

fid1 = fopen(n1,'w');
Declustered_Catalog = Backgroundevs;
mag=Declustered_Catalog(:,11);
for i=1:1:length(mag)
   fprintf(fid1,'%d %02d %02d %02d %02d %05.2f %f %f %04.2f %04.2f %d\n',...
   round(Declustered_Catalog(i,1)),round(Declustered_Catalog(i,2)),round(Declustered_Catalog(i,3)),round(Declustered_Catalog(i,4)),...
   round(Declustered_Catalog(i,5)),Declustered_Catalog(i,6),Declustered_Catalog(i,8),Declustered_Catalog(i,9),Declustered_Catalog(i,10),...
   Declustered_Catalog(i,11),Declustered_Catalog(i,7));
end
fclose(fid1);
