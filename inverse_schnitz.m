% This script takes all clist files within a given folder and outputs
% joined cell traces of mother and daughter cells, as well as computing the
% cross correlation and autocorrelation for each

% in each .m file there are three variables colors : joined fluorescent
% data for each cell lineage; xcor : cross-correlation traces; acor :
% auto-correlation data

clear all, close all

% input the complete directory path for clist.m files that need to be
% converted
DIR='/Users/nicholasrossi/Documents/work_docs/lab_work/2017/7_5_17_revisions/collected/';

files = dir(strcat(DIR,'*.mat'));
n=0;
for file = files'
close all
clearvars -except file files n xcov_array
load(strcat(DIR,file.name))

disp(file.name)

mother_id=data(:,63);
for k = 1:length(mother_id);
    
    if mother_id(k)~=0
        %linking mother daugher data for 
        data3D(k,[6,8,10],~isnan(data3D(mother_id(k),6,:)))=data3D(mother_id(k),[6,8,10],~isnan(data3D(mother_id(k),6,:)));
    end
    
end


%remove cells that aren't the full length, this 
dims=size(data3D);
for j=1:dims(1)
    trig_length=length(data3D(j,6,~isnan(data3D(j,6,:))));
    if trig_length~=dims(3)
        data3D(j,:,:)=NaN(1,dims(2),dims(3));
    end
        
end

%test to make sure it worked:
time_vect=linspace(0,(dims(3)-1)*3,dims(3));
CFP=[];
YFP=[];
RFP=[];
for z=1:dims(1)
    array_temp=squeeze(data3D(z,6,:));
    if sum(~isnan(array_temp))~=0
    CFP=cat(1,CFP,rot90(array_temp));
    YFP=cat(1,YFP,rot90(squeeze(data3D(z,8,:))));
    RFP=cat(1,RFP,rot90(squeeze(data3D(z,10,:))));
    end
end

    

disp(dims(3))
lengtho=dims(3);
res1=xcov_branched(CFP(:,1:lengtho), YFP(:,1:lengtho))/sqrt(max(xcov_branched(CFP(:,1:lengtho),CFP(:,1:lengtho)))*max(xcov_branched(YFP(:,1:lengtho),YFP(:,1:lengtho))));
if n==0
    xcov_array=zeros(5,length(res1));
end

xcov_array(n+1,:)=res1;
res2=xcov_branched(YFP, RFP)/sqrt(max(xcov_branched(YFP,YFP))*max(xcov_branched(RFP,RFP)));
res3=xcov_branched(CFP, RFP)/sqrt(max(xcov_branched(CFP,CFP))*max(xcov_branched(RFP,RFP)));

colors=cat(3,CFP,YFP);
colors=cat(3,colors,RFP);
xcors=cat(1,res1,res2);
xcors=cat(1,xcors,res3);



res1=xcov_branched(CFP, CFP)/sqrt(max(xcov_branched(CFP,CFP))*max(xcov_branched(CFP,CFP)));

res2=xcov_branched(YFP, YFP)/sqrt(max(xcov_branched(YFP,YFP))*max(xcov_branched(YFP,YFP)));

res3=xcov_branched(RFP, RFP)/sqrt(max(xcov_branched(RFP,RFP))*max(xcov_branched(RFP,RFP)));



acors=cat(1,res1,res2);
acors=cat(1,acors,res3);
save(strcat('/Users/nicholasrossi/Documents/work_docs/lab_work/2017/7_5_17_revisions/collected_out/',num2str(n),'.mat'),'colors','xcors','acors')

n=n+1;
end

