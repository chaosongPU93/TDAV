%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% THIS is the script to analyse the inversion results from hypoinverse, set
% a cutoff distance, e.g. 8 km. from the center of lfe fam to their own 
% detections. Perserve the ones within this distance only.
%
% Although the distance cutoff is applied to count and time data, but the 
% saved results should be the same anyway, in other words, because the count
% data does not have the time information and have duplicates from diff fam,
% so only the processed data is worthwhile to save, for the next step,
% merge_fam_afthypo.m 
% 
%   2020/12/07, try to exclude some fams as requested, for testing purpose,
%               bc the filtering effect from some fams is slightly different
%               from others, we need to make sure the result is not biased 
%               those 'abnormal' filtering effects
%
%
% Modified by Chao Song, chaosong@princeton.edu
% First created date:   2020/12/07
% Last modified date:   2020/12/07
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization
format short e   % Set the format to 5-digit floating point
clear
close all

set(0,'DefaultFigureVisible','on');
% set(0,'DefaultFigureVisible','off');   % switch to show the plots or not

scrsz=get(0,'ScreenSize');

workpath = getenv('MHOME');
rstpath = strcat(workpath, '/Seisbasics/hypoinverse/lzbrst');

winlenhf = 4;

winlenlf = 16;
lofflf = 4;
ccminlf = 0.35;
        
        
%% for detections in time

%%% for the locations of lfe families, by inversion from hypoinverse
%%% this is inverted from (0,0) of all fams, same order, location of control points
%%% inverted from /home/data2/chaosong/Seisbasics/hypoinverse/lzbrst/chat00p.reffam
loccont = [-123.492667 48.451500 38.1400; 
           -123.772167 48.493000 35.5900; 
           -123.863167 48.528167 35.2100;
           -123.603333 48.440167 36.7100;
           -123.800167 48.408833 34.5200;
           -123.893333 48.536500 35.0700;
%            -123.864500 48.498667 34.8800;
           -123.753333 48.525667 36.2000;
           -123.703667 48.502667 36.4100;
           -123.814333 48.538667 35.7900;
           -123.838500 48.544833 35.6600;
           -123.908000 48.494167 34.5100;       % 006
           -123.879667 48.446167 34.2600;       % 001
%            -123.967000 48.458667 33.7800;       % 158, 20200916,testing purpose
           ];

relacont = loccont;
% [dx, dy] = absloc2relaloc(loccont(:,1),loccont(:,2),loccont(2,1),loccont(2,2));
[dx, dy] = absloc2relaloc(loccont(:,1),loccont(:,2),-123.772167, 48.493000);
relacont(:,1) = dx;
relacont(:,2) = dy;       

% convert absolute loc to relative loc to its own lfe fam
nfampool = ['002';
            '043';
            '141';
            '047';
            '010';
            '144';
%             '099';
            '068';
            '125';
            '147';
            '017';
            '006';
            '001';
%             '158';      % 158, 20200916,testing purpose
            ];     % 2020/09/07, i am adding a new family 006 to the pool, final version

nfam = size(nfampool,1);
disp(nfam);

famex = '099'

SUFFIXhf = strcat('up.hf.time.',num2str(winlenhf),'_',num2str(winlenlf),'.',num2str(lofflf),...
                  '.',num2str(ccminlf));
% fname = strcat(rstpath, '/evtloc.requestfam.',SUFFIXhf);
fname = strcat(rstpath, '/evtloc.ex',famex,'.',SUFFIXhf);
hfmaptime = load(fname);
% 12 cols, format is:
%   lon lat dep off12 off13 off12sec off13sec date strongest_arr_time center_of_win cc fam

SUFFIXlf = strcat('lf.time.',num2str(winlenhf),'_',num2str(winlenlf),'.',num2str(lofflf),...
                  '.',num2str(ccminlf));
% fname = strcat(rstpath, '/evtloc.requestfam.',SUFFIXlf);
fname = strcat(rstpath, '/evtloc.ex',famex,'.',SUFFIXlf);
lfmaptime = load(fname);


%% read the alligned seismograms of all detections and get the amplitude info
%%% NOTE: it is impossible to track the order of detections since they have been sorted somewhere
%%% thus the only way to link them is the fam number, day and time
timoffrot= [2003 060;
            2003 061;
            2003 062; % dates of the year, two columns: year Julian_day
            2003 063;
            2003 064;
            2004 194;
            2004 195;
            2004 196;
            2004 197;
            2004 198;
            2004 199;
            2004 200;
            2004 201;
            2004 202;
            2004 203;
            2005 254;
            2005 255;
            2005 256;
            2005 257;
            2005 258;
            2005 259;
            2005 260;
            2005 261];

nday = size(timoffrot, 1);

tracepath = '/home/data2/chaosong/matlab/allan/data-no-resp/LZBtrio';
amphf = zeros(size(hfmaptime,1),2);   % hf, amplitude of detections for all days of all fams
for i=1: size(nfampool,1)
    fam = nfampool(i,:);
    for nd=1:length(timoffrot(:,1))      % num of rows, also num of days
        year=timoffrot(nd,1);
        YEAR=int2str(year);
        jday=timoffrot(nd,2);
        if jday <= 9
            JDAY=['00',int2str(jday)];
        elseif jday<= 99
            JDAY=['0',int2str(jday)];
        else
            JDAY=int2str(jday);
        end
        IDENTIF=[YEAR,'.',JDAY,'.',fam,'.lo1.5.cc0.4.22.ms14_1.25-6.5_4s40sps4nsta'];
        fname = strcat(tracepath, '/MAPS/traceall_up',IDENTIF);
        if isfile(fname)
            dettrace = load(fname);
            ndet = round(size(dettrace,1)/(4*40));
            for j = 1: ndet
                ampmax = mean(max(dettrace((j-1)*4*40+1:j*4*40, 2:4)));
                ampmin = mean(min(dettrace((j-1)*4*40+1:j*4*40, 2:4)));
                midtime = dettrace((j-1)*4*40 +1 +4*40/2, 1);
                midtime = sprintf('%.1f',midtime);
                midtime = str2double(midtime);
                objind = find(hfmaptime(:,end)==str2double(fam) & ...
                              hfmaptime(:,8)==str2double(strcat(YEAR,JDAY)) & ...
                              abs(hfmaptime(:,10)-midtime)< 0.01);
                if isempty(objind) || size(objind,1) > 1
                    disp(midtime)
                    disp(strcat(YEAR,JDAY))
                    disp(objind)
                    break
                end
                amphf(objind,1) = ampmax; 
                amphf(objind,2) = ampmin;
            end
        else
            continue
        end
    end
end
disp('Amplitude linked to hf detections done');


amplf = zeros(size(lfmaptime,1),2);   % lf, amplitude of detections for all days of all fams
for i=1: size(nfampool,1)
    fam = nfampool(i,:);
    for nd=1:length(timoffrot(:,1))      % num of rows, also num of days
% nd=2;
        year=timoffrot(nd,1);
        YEAR=int2str(year);
        jday=timoffrot(nd,2);
        if jday <= 9
            JDAY=['00',int2str(jday)];
        elseif jday<= 99
            JDAY=['0',int2str(jday)];
        else
            JDAY=int2str(jday);
        end
        IDENTIF=[YEAR,'.',JDAY,'.',fam,'.lo4.cc0.35.22.ms34_0.5-1.25_16s20sps4nsta'];
        fname = strcat(tracepath, '/MAPS/traceall_',IDENTIF);
        if isfile(fname)
            dettrace = load(fname);
            ndet = round(size(dettrace,1)/(16*20));
            for j = 1: ndet
                ampmax = mean(max(dettrace((j-1)*16*20+1:j*16*20, 2:4)));
                ampmin = mean(min(dettrace((j-1)*16*20+1:j*16*20, 2:4)));
                midtime = dettrace((j-1)*16*20 +1 +16*20/2, 1);
                midtime = sprintf('%.1f',midtime);
                midtime = str2double(midtime);
%                 midtime = 0.5*(dettrace((j-1)*16*20+1,1) + dettrace(j*16*20,1));
                objind = find(lfmaptime(:,end)==str2double(fam) & ...
                              lfmaptime(:,8)==str2double(strcat(YEAR,JDAY)) & ...
                              abs(lfmaptime(:,10)-midtime)< 0.5);
                if isempty(objind) || size(objind,1) > 1
                    disp(midtime)
                    disp(strcat(YEAR,JDAY))
                    disp(objind)
                    disp(j)
                    break
                end
                amplf(objind,1) = ampmax;
                amplf(objind,2) = ampmin;
            end
        else
            continue
        end
    end
end
disp('Amplitude linked to lf detections done');


%% read the original detection results to get the cross-correlation info from additional stas
%%% NOTE: it is impossible to track the order of detections since they have been sorted somewhere
%%% thus the only way to link them is the fam number, day and time
ccaddhf = zeros(size(hfmaptime,1),4);   % hf, amplitude of detections for all days of all fams
for i=1: size(nfampool,1)
    fam = nfampool(i,:);
    for nd=1:length(timoffrot(:,1))      % num of rows, also num of days
        year=timoffrot(nd,1);
        YEAR=int2str(year);
        jday=timoffrot(nd,2);
        if jday <= 9
            JDAY=['00',int2str(jday)];
        elseif jday<= 99
            JDAY=['0',int2str(jday)];
        else
            JDAY=int2str(jday);
        end
        IDENTIF=[YEAR,'.',JDAY,'.',fam,'.lo1.5.cc0.4.22.ms14_1.25-6.5_4s40sps4nsta'];
        fname = strcat(tracepath, '/MAPS/mapallrst_up',IDENTIF);
        if isfile(fname)
            allrst = load(fname);
            ndet = size(allrst,1);
            for j = 1: ndet
                midtime = allrst(j,1);
                objind = find(hfmaptime(:,end)==str2double(fam) & ...
                              hfmaptime(:,8)==str2double(strcat(YEAR,JDAY)) & ...
                              abs(hfmaptime(:,10)-midtime)< 0.01);
                if isempty(objind) || size(objind,1) > 1
                    disp(midtime)
                    break
                end
                ccaddhf(objind,1:4) = allrst(j,26:29);
            end
        else
            continue
        end
    end
end
disp('CC from additional stas linked to hf detections done');


ccaddlf = zeros(size(lfmaptime,1),4);   % hf, amplitude of detections for all days of all fams
for i=1: size(nfampool,1)
    fam = nfampool(i,:);
    for nd=1:length(timoffrot(:,1))      % num of rows, also num of days
        year=timoffrot(nd,1);
        YEAR=int2str(year);
        jday=timoffrot(nd,2);
        if jday <= 9
            JDAY=['00',int2str(jday)];
        elseif jday<= 99
            JDAY=['0',int2str(jday)];
        else
            JDAY=int2str(jday);
        end
        IDENTIF=[YEAR,'.',JDAY,'.',fam,'.lo4.cc0.35.22.ms34_0.5-1.25_16s20sps4nsta'];
        fname = strcat(tracepath, '/MAPS/mapallrst',IDENTIF);
        if isfile(fname)
            allrst = load(fname);
            ndet = size(allrst,1);
            for j = 1: ndet
                midtime = allrst(j,1);
                objind = find(lfmaptime(:,end)==str2double(fam) & ...
                              lfmaptime(:,8)==str2double(strcat(YEAR,JDAY)) & ...
                              abs(lfmaptime(:,10)-midtime)< 0.5);
                if isempty(objind) || size(objind,1) > 1
                    disp(midtime)
                    break
                end
                ccaddlf(objind,1:4) = allrst(j,26:29);
            end
        else
            continue
        end
    end
end
disp('CC from additional stas linked to lf detections done');


%% read the original detection results to get the max energy in dtmin per detection window
%%% NOTE: it is impossible to track the order of detections since they have been sorted somewhere
%%% thus the only way to link them is the fam number, day and time
energyhf = zeros(size(hfmaptime,1),2);   % hf, amplitude of detections for all days of all fams
for i=1: size(nfampool,1)
    fam = nfampool(i,:);
    for nd=1:length(timoffrot(:,1))      % num of rows, also num of days
        year=timoffrot(nd,1);
        YEAR=int2str(year);
        jday=timoffrot(nd,2);
        if jday <= 9
            JDAY=['00',int2str(jday)];
        elseif jday<= 99
            JDAY=['0',int2str(jday)];
        else
            JDAY=int2str(jday);
        end
        IDENTIF=[YEAR,'.',JDAY,'.',fam,'.lo1.5.cc0.4.22.ms14_1.25-6.5_4s40sps4nsta'];
        fname = strcat(tracepath, '/MAPS/mapallrst_up',IDENTIF);
        if isfile(fname)
            allrst = load(fname);
            ndet = size(allrst,1);
            for j = 1: ndet
                midtime = allrst(j,1);
                objind = find(hfmaptime(:,end)==str2double(fam) & ...
                              hfmaptime(:,8)==str2double(strcat(YEAR,JDAY)) & ...
                              abs(hfmaptime(:,10)-midtime)< 0.01);
                if isempty(objind) || size(objind,1) > 1
                    disp(midtime)
                    break
                end
                energyhf(objind,1) = allrst(j,6);   % max energy in the dtmin window
                energyhf(objind,2) = allrst(j,8);   % max energy in the dtmin window normalized by energy of entire 4s win
            end
        else
            continue
        end
    end
end
disp('Energy from trio stas linked to hf detections done');


energylf = zeros(size(lfmaptime,1),2);   % hf, amplitude of detections for all days of all fams
for i=1: size(nfampool,1)
    fam = nfampool(i,:);
    for nd=1:length(timoffrot(:,1))      % num of rows, also num of days
        year=timoffrot(nd,1);
        YEAR=int2str(year);
        jday=timoffrot(nd,2);
        if jday <= 9
            JDAY=['00',int2str(jday)];
        elseif jday<= 99
            JDAY=['0',int2str(jday)];
        else
            JDAY=int2str(jday);
        end
        IDENTIF=[YEAR,'.',JDAY,'.',fam,'.lo4.cc0.35.22.ms34_0.5-1.25_16s20sps4nsta'];
        fname = strcat(tracepath, '/MAPS/mapallrst',IDENTIF);
        if isfile(fname)
            allrst = load(fname);
            ndet = size(allrst,1);
            for j = 1: ndet
                midtime = allrst(j,1);
                objind = find(lfmaptime(:,end)==str2double(fam) & ...
                              lfmaptime(:,8)==str2double(strcat(YEAR,JDAY)) & ...
                              abs(lfmaptime(:,10)-midtime)< 0.5);
                if isempty(objind) || size(objind,1) > 1
                    disp(midtime)
                    break
                end
                energylf(objind,1) = allrst(j,6);   % max energy in the dtmin window
                energylf(objind,2) = allrst(j,8);   % max energy in the dtmin window normalized by energy of entire 4s win            end
            end
        else
            continue
        end
    end
end
disp('Energy from trio stas linked to lf detections done');


%% add the above new info into the original matrix
% structure, 12+4+2+2=20 cols, format is:
%   lon lat dep off12 off13 off12sec off13sec date strongest_arr_time center_of_win cc cca1 cca2 
%   cca3 cca4 ampmax ampmin eng normeng fam
ind = find(amphf(:,1)~=0 & ccaddhf(:,1)~=0 & energyhf(:,1)~=0);
hfnewtime = [hfmaptime(ind, 1:end-1) ccaddhf(ind, :) amphf(ind, :) energyhf(ind, :) ...
             hfmaptime(ind, end)];
ind = find(amplf(:,1)~=0 & ccaddlf(:,1)~=0);
lfnewtime = [lfmaptime(ind, 1:end-1) ccaddlf(ind, :) amplf(ind, :) energylf(ind, :) ...
             lfmaptime(ind, end)];


%% apply distance cutoff
%%% convert to relative locations
hfrelatime = [];
lfrelatime = [];
for ifam = 1: length(nfampool)        
    tmp1 = hfnewtime(hfnewtime(:,end)==str2double(nfampool(ifam,:)),:);
    [dx, dy] = absloc2relaloc(tmp1(:,1),tmp1(:,2),loccont(ifam,1),loccont(ifam,2));
    dist = sqrt(dx.^2+dy.^2);   % distance to their own family
    hfrelatime = [hfrelatime; dx dy dist tmp1];     % now increases to 23 cols
    
    tmp2 = lfnewtime(lfnewtime(:,end)==str2double(nfampool(ifam,:)),:);
    [dx, dy] = absloc2relaloc(tmp2(:,1),tmp2(:,2),loccont(ifam,1),loccont(ifam,2));
    dist = sqrt(dx.^2+dy.^2);   % distance to their own family
    lfrelatime = [lfrelatime; dx dy dist tmp2];     % now increases to 23 cols
end

% set dist cutoff, retain detections that are within a threshold to its own family
distmaxhf = 8;
distmaxlf = 12;
% disthf = sqrt(hfrelatime(:,1).^2+hfrelatime(:,2).^2);
% distlf = sqrt(lfrelatime(:,1).^2+lfrelatime(:,2).^2);
hfrelatimecut = hfrelatime(hfrelatime(:,3)<=distmaxhf,:);
lfrelatimecut = lfrelatime(lfrelatime(:,3)<=distmaxlf,:);

% relative coordinates to fam 043
[dx, dy] = absloc2relaloc(hfrelatimecut(:,4),hfrelatimecut(:,5),-123.772167, 48.493000);
hfrelatimecut = [dx dy hfrelatimecut];     % now increases to 25 cols

[dx, dy] = absloc2relaloc(lfrelatimecut(:,4),lfrelatimecut(:,5),-123.772167, 48.493000);
lfrelatimecut = [dx dy lfrelatimecut];     % now increases to 25 cols

% sort according to day, sec
hfrelatimecut = sortrows(hfrelatimecut, [13, 14]);
lfrelatimecut = sortrows(lfrelatimecut, [13, 14]);

%%% save the results here
% 25 cols, format is:
%   E(043) N(043) E(own) N(own) dist(own) lon lat dep off12 off13 off12sec off13sec date 
%   main_arrival_time  cent_of_win  avecc ccadd1 ccadd2 ccadd3 ccadd4 ampmax ampmin eng normeng famnum
%

fid = fopen(strcat(rstpath, '/evtloc.ex',famex,'.dcut.',SUFFIXhf),'w+');
fprintf(fid,'%.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %d %.4f %.1f %.4f %.4f %.4f %.4f %.4f %.4e %.4e %10.3e %10.3f %d \n',...
        hfrelatimecut');
fclose(fid);

fid = fopen(strcat(rstpath, '/evtloc.ex',famex,'.dcut.',SUFFIXlf),'w+');
fprintf(fid,'%.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %d %.4f %.1f %.4f %.4f %.4f %.4f %.4f %.4e %.4e %10.3e %10.3f %d \n',...
        lfrelatimecut');
fclose(fid);


%%% Also save a copy of results without dist cutoff
[dx, dy] = absloc2relaloc(hfrelatime(:,4),hfrelatime(:,5),-123.772167, 48.493000);
hfrelatimenocut = [dx dy hfrelatime];

[dx, dy] = absloc2relaloc(lfrelatime(:,4),lfrelatime(:,5),-123.772167, 48.493000);
lfrelatimenocut = [dx dy lfrelatime];

% sort according to day, sec
hfrelatimenocut = sortrows(hfrelatimenocut, [13, 14]);
lfrelatimenocut = sortrows(lfrelatimenocut, [13, 14]);

% format is the same as above
fid = fopen(strcat(rstpath, '/evtloc.ex',famex,'.nodcut.',SUFFIXhf),'w+');
fprintf(fid,'%.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %d %.4f %.1f %.4f %.4f %.4f %.4f %.4f %.4e %.4e %10.3e %10.3f %d \n',...
        hfrelatimenocut');
fclose(fid);

fid = fopen(strcat(rstpath, '/evtloc.ex',famex,'.nodcut.',SUFFIXlf),'w+');
fprintf(fid,'%.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f %d %.4f %.1f %.4f %.4f %.4f %.4f %.4f %.4e %.4e %10.3e %10.3f %d \n',...
        lfrelatimenocut');
fclose(fid);

   








