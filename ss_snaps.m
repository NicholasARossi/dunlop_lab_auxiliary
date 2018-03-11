% supper segger snaps
clear all, close all

%Enter the directory path for all of the extracted clist data from Super Segger 
DIR='/Users/nicholasrossi/Documents/work_docs/lab_work/2017/imane_snaps_6_40/collected/';

files = dir(strcat(DIR,'*.mat'));
n=0;
color_data=[];
for file = files'
    load(strcat(DIR,file.name))
    disp(file.name)
    %6,8,10 are the three color indexes in data3D, we extract them from
    %each clist file for all time points

    vals=data3D(:,[6,8,10]);
    vals=vals(:,~isnan(vals(1,:)));
    color_data = cat(1,color_data, vals);

end
% Creating the scatter plot
figure
x=color_data(:,1);
y=color_data(:,2);
scatter(x,y,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'MarkerFaceAlpha',.05,'MarkerEdgeAlpha',.05)
xlabel('YFP (A.U.)')
ylabel('RFP (A.U.)')
hold on;
% Best fit line and correlation coefficient
coeffs = polyfit(x, y, 1);


fittedX = linspace(min(x), max(x), 200);
fittedY = polyval(coeffs, fittedX);


plot(fittedX, fittedY, 'r-', 'LineWidth', 3);
[R,P] = corrcoef(x,y);
text0=strcat('CorCoeff =',string(R(1,2)));
t=text(max(x)*.75,max(y)*.75,char(text0));
t.FontSize = 12;
title('YFP vs RFP scatter')
saveas(gcf,'2color_scatter.png')

close all, clearvars -except color_data x y
% histograms for both colors
figure
subplot(2,1,1);
histogram(x)
title('YFP')
ylabel('Cell Count')

subplot(2,1,2);
histogram(y)
title('RFP')
xlabel('Fluorescence (A.U.)')
ylabel('Cell Count')

saveas(gcf,'2color_hist.png')

close all

