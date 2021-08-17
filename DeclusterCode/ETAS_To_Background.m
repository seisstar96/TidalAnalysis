%%%%
clc;clear;close all
pb = load('probabilities.SCEC_HYM_m1.5.txt');
data = load('SCEC_1981_2018_m1.5_pre.txt');
data1=load('1981_2021_decluster_n4.5.txt');
year1 = data1(:,1);
month1 = data1(:,2);
day1 = data1(:,3);
hour1 = data1(:,4);
minute1 = data1(:,5);
sec1 = round(data1(:,6));
t2=datenum(year1,month1,day1,hour1,minute1,sec1);
t22=datenum(2019,1,1,0,0,0);
t2=t2(t2<=t22);
lat1=data1(t2<=t22,8);


%data=data(data(:,8)>=32 & data(:,8)<=37,:);
data=data(data(:,11)>=1.5,:);

year = data(:,1);
month = data(:,2);
day = data(:,3);
hour = data(:,4);
minute = data(:,5);
sec = round(data(:,6));
lat =data(:,8);
t1=datenum(year,month,day,hour,minute,sec);
subplot 311
plot((t1-t1(1))/365+1981,lat,'.');
xlim([1981,2019]);
xlim([1992,1994]);

%%%%
len = length(data);
a = 0;
b = 1;
U = a + (b-a).*rand(len,1);


Bg_events =[];

for i = 1:1:len
    if U(i)< pb(i)
        Bg_events = [Bg_events;[t1(i),lat(i)]];
    end 
end
subplot 312
plot((Bg_events(:,1)-Bg_events(1,1))/365+1981,Bg_events(:,2),'.');
xlim([1981,2019]);
xlim([1992,1994]);


subplot 313
plot((t2-t2(1))/365+1981,lat1,'.');
xlim([1981,2019]);
ylim([30 38])
xlim([1992,1994]);


figure(2)
subplot 121
hist(U);
subplot 122
hist(pb);
ylabel('Event Number')


figure(3)
h = cdfplot((t1-t1(1))/365+1981); hold on
h1 = cdfplot((Bg_events(:,1)-Bg_events(1,1))/365+1981); hold on
h2 = cdfplot((t2-t2(1))/365+1981); hold on
xlim([1981 2019])
set(h,'color','r','linewidth',3)
set(h1,'color','blue','linewidth',3)
set(h2,'color','black','linewidth',3)
legend('SCEC','ETAS','NNA')
set(gca,'FontSize',20);
