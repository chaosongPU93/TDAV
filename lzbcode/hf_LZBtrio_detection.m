%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% THIS is the high-frequency detection with LZB-TWKB-MGCB trio in Cascadia
% using data at 40 sps. LZB is the main station 
%
% Features:
%   1. LZB-TWKB-MGCB trio
%   2. Test and start with family 002, but not limited, aim to extended to
%      all available LFE families used in Yajun's 2015 paper. (So the PERMROTS
%      and POLROTS will change for each family, but trio used remains the
%      same.
%
% Based on chaoSTA.m
%
% Modified by Chao Song, chaosong@princeton.edu
% First created date:   2019/04/17
% Last modified date:   2019/04/23
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

format short e   % Set the format to 5-digit floating point
clear
close all

% set(0,'DefaultFigureVisible','on');
set(0,'DefaultFigureVisible','off');   % switch to show the plots or not

% WHEN CHANGING FAMILIES CHANGE: (1)dates (2)Bostnames (3)hilo,frequency band 
% (4)mshift (5)bostsec (6)stas (7)PERMROTS and POLROTS (8)tempoffs

workpath = getenv('ALLAN');
temppath = strcat(workpath, '/templates/');

fam='068';     % family number

if isequal(fam,'002')  %DON'T FORGET additional family-specific delcarations around line 156
    
    %%% permanent stations rotation angles, NAMES can be found in Rubin &
    %%% Armbruster 2013, Armbruster et al., 2014
    
    %%%%%%%% Meanning of each column in PERMROTS/POLROTS %%%%%%%%
    %%% 1. offset in samples between fast/slow direction for SAME station,
    %      given at 40 sps
    %%% 2. rotation angle to get fast/slow direction for SAME station
    %%% 3. rotation angle to maximize the energy/particle
    %%%    motion/polarization, for SAME station
    %%% 4. offset in samples between the arrival times at different
    %%%    stations, given at 40 sps
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    PERMROTS=[0 90 32 -10;  %PGC , Yajun's "0" changed to 90.  Don't think that matters, if no splitting.
              0 90 54 0]; %LZB
    %%% POLARIS stations rotation angles
    POLROTS=[6 85 33 77;  %SSIB from Yajun
             0 90 39 11;  %SILB
             0 90  7 0;  %KLNB
             4 70 48 -35;  %MGCB
             4 75 38 -14]; %TWKB
    
    % generate unique dates matrix that in that family
    timoffrot = Readbostock(fam);
    ind=[];
    timoffrot(ind, :)=[];
    
    tempoffs=[1222 1222 1222 1222 1222 1222]; %these are the zero crossings
    nstack=2127;
    
elseif isequal(fam, '043')  % use 043 instead of 013, but with error
    
    PERMROTS=[0  0 29  94;  %PGC
              6 95 41  0]; %LZB
    POLROTS=[0  0  0  177;  %SSIB
             0  0  0  154;  %SILB
             0  0 20  0;  %KLNB
             2 65 36  13;  %MGCB
             3 65 12  14]; %TWKB
    
    % generate unique dates matrix that in that family
    timoffrot = Readbostock(fam);
    ind=[];
    timoffrot(ind, :)=[];
    
    tempoffs=[1195 1289 1374 1349 1210 1208]; %these are the zero crossings
    nstack=1825;
    
elseif isequal(fam, '141')  % use 141 instead of 025, but with error
    
    PERMROTS=[0  0  0  136;  %PGC
              3 80 15  0]; %LZB
    POLROTS=[0  0  0  218;  %SSIB
             0  0  0  208;  %SILB
             0  0 27  0;  %KLNB
        0  0 41  32;  %MGCB
        3 45 13  23]; %TWKB
    
    % generate unique dates matrix that in that family
    timoffrot = Readbostock(fam);
    ind=[];
    timoffrot(ind, :)=[];
    
    tempoffs=[1182 1318 1398 1391 1204 1214]; %these are the zero crossings
    nstack=1488;
    
elseif isequal(fam, '047')  % use 047 instead of 028
    
    PERMROTS=[0  0 36  28;  %PGC
              5 60 39  0]; %LZB
    POLROTS=[5 90 44  119;  %SSIB
             0  0 42  61;  %SILB
             0  0  4  0;  %KLNB
             3 80 48  -16;  %MGCB
             4 70 31  -1]; %TWKB
    
    % generate unique dates matrix that in that family
    timoffrot = Readbostock(fam);
    ind=[];
    timoffrot(ind, :)=[];
    
    tempoffs=[1212 1240 1331 1274 04 1196]; %these are the zero crossings
    nstack=1629;
    
elseif isequal(fam, '010')  % use 010 instead of 056
    
    PERMROTS=[0  0  0  152;  %PGC
              2 55  2  0]; %LZB
    POLROTS=[0  0  0  215;  %SSIB
             0  0  0  243;  %SILB
             0  0  0  0;  %KLNB
             2 95 51  22;  %MGCB
             5 70 27  25]; %TWKB
    
    % generate unique dates matrix that in that family
    timoffrot = Readbostock(fam);
    ind=[7 10];
    timoffrot(ind, :)=[];
    
    %%% PROBLEMATIC
    tempoffs=[1179 1278 1391 1296 1204 1201]; %these are the zero crossings
    nstack=993;
    
elseif isequal(fam, '144')  % use 144 instead of 084
    
    PERMROTS=[3 85 52  150;  %PGC
              4 90 29  0]; %LZB
    POLROTS=[0  0  0  221;  %SSIB
             0  0  0  228;  %SILB
             0  0  0  0;  %KLNB
             3 90 50  36;  %MGCB
             4 80 30  26]; %TWKB
    
    % generate unique dates matrix that in that family
    timoffrot = Readbostock(fam);
    ind=[];
    timoffrot(ind, :)=[];
    
    tempoffs=[1191 1341 1413 1419 1217 1226]; %these are the zero crossings
    nstack=1323;
    
elseif isequal(fam, '099')
    
    PERMROTS=[0  0  0  134;  %PGC
              2 80 13  0]; %LZB
    POLROTS=[0  0  0  222;  %SSIB
             0  0  0  199;  %SILB
             0  0  0  0;  %KLNB
             0  0 35  32;  %MGCB
             2 65 19  26]; %TWKB
    
    % generate unique dates matrix that in that family
    timoffrot = Readbostock(fam);
    ind=[8];
    timoffrot(ind, :)=[];
    
    tempoffs=[1179 1315 1400 1378 1205 1212]; %these are the zero crossings
    nstack=1385;
    
elseif isequal(fam, '068')  % use 068 instead of 115
    
    PERMROTS=[0  0 48  89;  %PGC
              8 65  6  0]; %LZB
    POLROTS=[0  0  0  154;  %SSIB
             0  0  0  158;  %SILB
             2 50 25  0;  %KLNB
             5 65 41  7;  %MGCB
             4 60 14  8]; %TWKB
    
    % generate unique dates matrix that in that family
    timoffrot = Readbostock(fam);
    ind=[];
    timoffrot(ind, :)=[];
    
    tempoffs=[1193 1281 1347 1352 1201 1201]; %these are the zero crossings
    nstack=1368;
    
elseif isequal(fam, '125')
    
    PERMROTS=[0  0 40  64;  %PGC
              8 75 26  0]; %LZB
    POLROTS=[0  0  0  142;  %SSIB
             0  0  0  117;  %SILB
             0  0 10  0;  %KLNB
             4 95 60  -1;  %MGCB
             6 55 16  4]; %TWKB
    
    % generate unique dates matrix that in that family
    timoffrot = Readbostock(fam);
    ind=[];
    timoffrot(ind, :)=[];
    
    tempoffs=[1200 1262 1341 1316 1203 1198]; %these are the zero crossings for 002: PGC,SSIB,SILB.
    nstack=869;
    
elseif isequal(fam, '147')
    
    PERMROTS=[0  0 39  119;  %PGC
              6 85 36  0]; %LZB
    POLROTS=[0  0  0  189;  %SSIB
             0  0  0  194;  %SILB
             0  0 24  0;  %KLNB
             3 80 51  20;  %MGCB
             4 75 27  15]; %TWKB
    
    % generate unique dates matrix that in that family
    timoffrot = Readbostock(fam);
    ind=[2 4];
    timoffrot(ind, :)=[];
    
    tempoffs=[1191 1309 1378 1383 1205 1210]; %these are the zero crossings for 002: PGC,SSIB,SILB.
    nstack=216;
    
elseif isequal(fam, '017')    % use 017 instead of 149
    
    PERMROTS=[0   0 39  126;  %PGC
              6  90 35  0]; %LZB
    POLROTS=[0   0  0  193;  %SSIB
             6 115 57  203;  %SILB
             2  55 21  0;  %KLNB
             3  85 54  24;  %MGCB
             4  70 21  18]; %TWKB
    
    % generate unique dates matrix that in that family
    timoffrot = Readbostock(fam);
    ind=[2 7];
    timoffrot(ind, :)=[];
    
    tempoffs=[1186 1311 1379 1389 1203 1209]; %these are the zero crossings for 002: PGC,SSIB,SILB.
    nstack=561;
end


%%% corresponds to PERMROTS
PERMSTA=['PGC'        % permanent station names
         'LZB'];
POLSTA=['SSIB '           % polaris station names
        'SILB '
        'KLNB '
        'MGCB '
        'TWKB '];

%  station trio used, 1st station is the main station
stas=['LZB  '
      'TWKB '
      'MGCB '];

  
% number of used stations  
nsta=size(stas,1);         %  number of stations

nday = size(timoffrot, 1);

% convert angles to rads
PERMROTS(:,2:3)=pi*PERMROTS(:,2:3)/180.;     % convert 2-3 columns to rad 
POLROTS(:,2:3)=pi*POLROTS(:,2:3)/180.;


sps=40;     % samples per second

tempwinsec = 60;
tempwinlen = tempwinsec*sps;    % template window length, 60s, 60*sps samples, 1 min
stack=zeros(nsta,tempwinlen);     
stackort=zeros(nsta,tempwinlen);      % stackort, orthogonal

%%% IMPORTANT, NEED change sometimes
%Basics of the cross-correlation:  Window length, number of windows, filter parameters, etc.
winlensec=4;
% winlensec=12.5;     % cc window length in sec
winoffsec=3;        % window offset in sec, which is the step of a moving window
winlen=winlensec*sps;      % length in smaples
winoff=winoffsec*sps;      % offset in samples
tracelen=86400*sps; %one day of data at 40 sps, overall trace length, 24*3600
cutsec = 2;
winbig=2*(tracelen/2-(cutsec*sps)); %ignore 2 seconds at each end of day, bigger window contains positive and negative, why tracelen/2?, -4s
timbig=winbig/(2*sps); %half that time, in seconds, half day - 2s
igstart=floor(tracelen/2-winbig/2)+1; %start counting seis data from here, 2*sps+1, floor(1.8)==1
nwin=floor((winbig-winlen)/winoff)+1;    % number of windows, first one not included, ADD +1 by Chao, 2019/02/17

%UPGRADING SINCE MODIFYING READPOLS & READPERMS STOPED HERE
%hi=6.5;  %002 Stanford
%lo=1.25; %002 Stanford
%hi=6;
%lo=1.5;
hi=6.5;    % frequency band
lo=1.25;
% hi=1.25;
% lo=0.5;
% hi=10;
% lo=4;
npo=2;     % poles, passes of filters
npa=2;
mshift=19; %19; %maximum shift for the x-correlations. 19 for 002 Stanford,    % in sps, 0.5s*40sps=20
loopoffmax=2.1; %1.5 for standard 1.5-6Hz; 4 for 0.5-1.5Hz.  2 for non-interpolated.   % what is loopoffmax, the circuit of time offsets
xcmaxAVEnmin=0.44; %0.44; %0.44 for 002 Stanford %0.45; %0.36 for 4s 1-12 Hz; %0.4 for 4s 1.5-6 Hz and 6s 0.5-1.5Hz; 0.36 for 4s2-8 Hz ; 0.38 for 4s0.75-6 Hz; 0.094 for 128s 2-8Hz;  0.1 for 128s 1.5-6Hz; 0.44 for 3-s window?
%%% xcmaxAVEnmin = x-correlation max average min ?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Get the templates for the stations. Won't be always required.  PGCopt_002_1.25-6.5Hz_2pass_100sps.le14shift.resamp
%%% THIS loads the templates from Allan
% for ista=1:nsta
%     if stas(ista,4) == ' '          % which means it has a 3-letter code, permanent stations
%         temptemps(ista,:)=load([stas(ista,1:3),'opt_',fam,'_',num2str(lo),'-',num2str(hi), ...
%                          'Hz_',int2str(npa),'pass_',int2str(sps),'sps.input'],'w');         % write permission to data file
%     else          % which means it has a 4 (maybe more)-letter code, Polaris stations
%         temptemps(ista,:)=load([stas(ista,1:4),'opt_',fam,'_',num2str(lo),'-',num2str(hi), ...
%                          'Hz_',int2str(npa),'pass_',int2str(sps),'sps.input'],'w');
%     end
% end
%%%
%%% THIS loads the  templates from Chao
for ista=1:nsta
    data = load(strcat(temppath,'new_', fam, '_', strtrim(stas(ista, :)), '_', ...
                num2str(sps), 'sps_', num2str(tempwinsec), 'sec_', num2str(nstack), ...
                'DirectStacks_', 'opt_Nofilter_Nonorm.txt'));
    [num, denom] = rat(sps/40);
%     temp1(ista,:) = Bandpass(data, sps, lo, hi, npo, npa, 'butter');    % bandpass with wrong sps
%     temp2(ista,:) = resample(temp1(ista,:), num, denom);    % continue to downsample
    %%% ATTENTION: the sample rate in bandpass must be the same as the data 
    data = Bandpass(data, 40, lo, hi, npo, npa, 'butter');
    temptemps(ista,:) = resample(data, num, denom); 
    
end
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% a simple plot to find the temoffs
figure
for ista=1:nsta
    plot(temptemps(ista,:)); hold on
end
%%%

figure
for ista = 1: nsta
    %%% normalization
    ampmax = max(temptemps(ista, :));
    ampmin = min(temptemps(ista, :));
    norm = max(ampmax, -ampmin);
    tempno = temptemps(ista, :)/ norm;
    plot(tempno); hold on
%     pause(5)
end
%%%

% % tempbef=70;
% % tempaft=89;
tempbef=59;        % template before time in samples
tempaft=60;         % template after time in samples
templen=tempbef+tempaft+1;        % template length in sec
for ista=1:nsta
    STAtemps(ista,:)=temptemps(ista,tempoffs(ista)-tempbef:tempoffs(ista)+tempaft);   % 120 samples, 3s
    snips(templen*(ista-1)+1: templen*ista)=STAtemps(ista,:);       % concatenate all data to one vector
end

%%% 'scalefact' scales templates; 'scaleseisms' scales seisms.  Strategy changes with family.
if isequal(fam,'002')
    tempoffs=tempoffs-1; %Center of strongest window is 1 or 2 samples ahead of zero crossing (002); make it 1.
    whichtoplot=2;          % flag to which to plot
    scaleseisms=[1.0 0.76 0.95];       % scaleseisms scales seismograms
elseif isequal(fam,'068')
    whichtoplot=1;
    scaleseisms=[1.0 1.0 1.0];
end
minses=-min(STAtemps,[],2); %STAtemps is (currently) 3 by 120     % give the min/max of the each trace(row) of the STAtemps
maxses= max(STAtemps,[],2);
plustominus=maxses./minses;        % ratio of +/-
scalefact=minses*max(plustominus); %This is used to scale templates, just for plotting purposes
for ista=1:nsta
    STAtemps(ista,:)=STAtemps(ista,:)/scalefact(ista); %This plots the templates with the largest positive value (of any) at +1
end
% %%% EXAMPLE of scaling:
% % STAtemps = [5 -4 1; 10 -5 2];
% % minses=-min(STAtemps,[],2);
% % maxses= max(STAtemps,[],2);
% % plustominus=maxses./minses;
% % scalefact=minses*max(plustominus);
% % for ista=1:2
% %     STAtemps(ista,:)=STAtemps(ista,:)/scalefact(ista);
% % end
% % STAtemps =
% % 
% %     0.6250   -0.5000    0.1250
% %     1.0000   -0.5000    0.2000
% %%%
figure
plot(STAtemps(1,:),'r', 'linewidth', 1.5)
hold on
plot(STAtemps(2,:),'b', 'linewidth', 1.5)
plot(STAtemps(3,:),'k', 'linewidth', 1.5)
drawnow     % update figures immediately

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% get the all catalog LFEs in that family
bostname = ('/BOSTOCK/total_mag_detect_0000_cull_NEW.txt');
catalog = load(strcat(workpath, bostname));
famnum = str2double(fam);
dateall = catalog(famnum == catalog(:, 1), :);

%% START TO LOOP FOR every day
%cycle over each day:
for id=1: nday      % num of rows, also num of days
%     nd=1;
    close all

    %Which days of data to read?
    year=timoffrot(id,1);
    YEAR=int2str(year);
    jday=timoffrot(id,2);
    if year == 2003
        date = jday-62+30303;
    elseif year == 2004
        date = jday-196+40714;
    elseif year == 2005
        date = jday-254+50911;
    end
    bostocks = dateall(date == dateall(:, 2), :);
    bostsec = 3600*(bostocks(:,3)-1)+bostocks(:,4);
    bostsamp = round(bostsec*40);
    
    if jday <= 9
        JDAY=['00',int2str(jday)];
    elseif jday<= 99
        JDAY=['0',int2str(jday)];
    else
        JDAY=int2str(jday);
    end
%     MO = 'SEP';
    MO=day2month(jday,year);     % EXTERNAL function, day2month, get the month of one particular date
    IDENTIF=[YEAR,'.',JDAY,'.',fam,'.loff',num2str(loopoffmax),'.ccmin',num2str(xcmaxAVEnmin),'.nponpa',int2str(npo),int2str(npa),'.ms',int2str(mshift)]
    direc=[workpath, '/', YEAR,'/',MO,'/'];     % directory name
    prename=[direc,YEAR,'.',JDAY,'.00.00.00.0000.CN'];    %  path plus prefix of data file, 

    %Read the data; find glitches (many consecutive zeros) and flag those windows in STAnzeros.
    %Get timsSTA from the permanent stations (last one over-writes):
    STAopt=zeros(nsta,tracelen);    % one day of samples
    %STAort=STAopt;
    STAnzeros=zeros(nsta,nwin);    % used to flag windows with glitches
    for ista=1:nsta
        found=0;
        [LIA,idx]=ismember(stas(ista,:),PERMSTA,'rows');     % ismember, to determine whether each row of stas is contained in PERMSTA, return logical value 1/0 and index
        if LIA
            found=found+LIA;
            if strcmp(PERMSTA(idx,1:3),'PGC')     % string compare
                %%% WAHT is the meanning of 'fact', similar to instrument
                %%% response
                fact=1.6e-4;
            elseif strcmp(PERMSTA(idx,1:3),'LZB')
                fact=4.e-3;
            end
            %%% readperms is an EXTERNAL FUNCTION
            % opt: optimal seismogram after rotations
            % ort: orthogonal seismogram after rotations
            % nzeros: number of zeros in the trace
            % timsSTA: time sequence
            [opt,ort,nzeros,timsSTA]=readperms(prename,PERMSTA,PERMROTS,idx,sps,lo,hi,npo,npa,fact,nwin,winlen,winoff,igstart);
        end
        
        [LIA,idx]=ismember(stas(ista,:),POLSTA,'rows');    
        if LIA        % if are in POLSTA
            found=found+LIA; %better be 1
            if year==2003 && jday<213        % should result from some criteria
                fact=20.0e-3;
            else
                fact=4.0e-3; 
            end
            %%% readpols is an EXTERNAL FUNCTION
            % opt:
            % ort:
            % nzeros:
            [opt,ort,nzeros]=readpols(prename,POLSTA,POLROTS,idx,sps,lo,hi,npo,npa,fact,nwin,winlen,winoff,igstart);
        end
        found=found         % could be a benchmark
        %factr1(ista)=prctile(abs(opt),90); %Not normalized
        %factr2(ista)=factr1(ista)/factr1(1); %This is what is used; keeps 1st station unchanged but scales the others
        STAopt(ista,:)=opt/scaleseisms(ista);   % what is STAopt for??
        %STAort(ista,:)=ort;
        STAnzeros(ista,:)=nzeros;    % STAnzeros is to count the number of zeros in each window of each station
    end

    %NOW for broader band (bb)
    %%% the broader frequency band is the main difference compared to above
    lobb=0.5;
    hibb=8;
%    lobb=4;
%    hibb=10;
    STAoptbb=zeros(nsta,tracelen);
    for ista=1:nsta
        [LIA,idx]=ismember(stas(ista,:),PERMSTA,'rows');
        if LIA
            if strcmp(PERMSTA(idx,1:3),'PGC')
                fact=1.6e-4;
            elseif strcmp(PERMSTA(idx,1:3),'LZB')
                fact=4.e-3;
            end
            [opt,~,~,~]=readperms(prename,PERMSTA,PERMROTS,idx,sps,lobb,hibb,npo,npa,fact,nwin,winlen,winoff,igstart);
        end
        [LIA,idx]=ismember(stas(ista,:),POLSTA,'rows');
        if LIA
            if year==2003 && jday<213
                fact=20.0e-3;
            else
                fact=4.0e-3; 
            end
            [opt,~,~]=readpols(prename,POLSTA,POLROTS,idx,sps,lobb,hibb,npo,npa,fact,nwin,winlen,winoff,igstart);
        end
        STAoptbb(ista,:)=opt/scaleseisms(ista); 
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   Autocorrelation of stations.  Those that end in "sq" are the running
    %   cumulative sum, to be used later by differencing the window edpoints.
    %   (Used to be PGCauto, PGC2, SSIBauto, SSIB2, etc.)
    %   Station to itself is in a 3 x tracelen array
    %   Cross-station measurements are in their own linear array
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    STAauto=STAopt.*STAopt;
    STAsq=cumsum(STAauto,2);    % cumulative sum of each trace(row)
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  Cross-correlation between stations, with small offsets up to +/- mshift.
    %  First index is pointwise multiplication of traces; second is shifting offset.
    %  lenx is shorter than tracelen by mshift at each end (see notebook sketch)
    %  For STA12 and PGSI, SSI and SIL are shifted relative to PGC, by 1 each time through loop.
    %  For SISS, SSI is shifted relative to SILB.
    %  cumsumSTA12 etc. are the running cumulative sum of the x-correlation.
    %  PGSSx becomes STA12x, PGSI -> STA13, SISS -> STA32
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    lenx=tracelen-2*mshift;     % 86400*sps-19*2
    STA12x=zeros(lenx, 2*mshift+1);    % 19*2+1
    STA13x=zeros(lenx, 2*mshift+1);    % stas: 1->PGC, 2->SSIB, 3->SILB
    STA32x=zeros(lenx, 2*mshift+1);
    %%% SEE NOTES, Chao
    for n=-mshift:mshift
        % PGC corr SSIB, 1+mshift:tracelen-mshift == 1+mshift-n:tracelen-mshift-n == lenx
        STA12x(:,n+mshift+1)=STAopt(1,1+mshift:tracelen-mshift).* ...
            STAopt(2,1+mshift-n:tracelen-mshift-n);
        % PGC corr SILB
        STA13x(:,n+mshift+1)=STAopt(1,1+mshift:tracelen-mshift).* ...
            STAopt(3,1+mshift-n:tracelen-mshift-n);
        % SILB corr SSIB
        STA32x(:,n+mshift+1)=STAopt(3,1+mshift:tracelen-mshift).* ...
            STAopt(2,1+mshift-n:tracelen-mshift-n);
    end
    cumsumSTA12=cumsum(STA12x);  %prev cumsumPGSS    % ==cumsum(STA12x,1),column
    cumsumSTA13=cumsum(STA13x);  %prev cumsumPGSI
    cumsumSTA32=cumsum(STA32x);  %prev cumsumSISS

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  "winbig"             is now the whole day, minus 2 sec at each end (apparently).
    %  "timbig"             is the time of half that.
    %  'igstart'            is the index of the starting sample.
    %  'winlen and winoff'  refer to the small windows.
    %  'timswin'            refers to the central times of those small windows.
    %  'sumsPGSS' (etc.)    is the cross-correlation sum over the window.  The first
    %    index refers to the window number and the second the shift over +/-mshift.
    %
    %  Normalized x-correlation:
    %    For PGSS and PGSI, for a given window PGC does not shift but SSI and 
    %    SIL do.  So can compute sumsPGC2 (from the running cum. sum PGC2) just
    %    once for each window.  Same for sumsSILB2b.  But for the stations that
    %    shift, SSI and SIL (for PGC) and SSI (for SIL), must compute sumsSSIB2 
    %    and sumsSILB2 upon each shift (actually, this is is easy book-keeping
    %    but not efficient).  Again, the first index refers to the window
    %    number and the second the shift over +/-mshift.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    timswin=zeros(nwin,1);    %%% timswin refers to the central times of those small windows.
%     sumsPGSS=zeros(nwin,2*mshift+1);
%     sumsPGSI=zeros(nwin,2*mshift+1);
%     sumsSISS=zeros(nwin,2*mshift+1);
%     sumsPGC2=zeros(nwin,2*mshift+1);
%     sumsSSIB2=zeros(nwin,2*mshift+1);
%     sumsSILB2=zeros(nwin,2*mshift+1);
%     sumsSILB2b=zeros(nwin,2*mshift+1);
    sumsSTA12=zeros(nwin,2*mshift+1);   % PGC-SSIB
    sumsSTA13=zeros(nwin,2*mshift+1);   % PGC-SILB
    sumsSTA32=zeros(nwin,2*mshift+1);   % SILB-SSIB
    sumsSTA1sq=zeros(nwin,2*mshift+1);  % "sq" are the running cumulative sum, to be used later by differencing the window edpoints
    sumsSTA2sq=zeros(nwin,2*mshift+1);
    sumsSTA3sq=zeros(nwin,2*mshift+1);
    sumsSTA3Bsq=zeros(nwin,2*mshift+1); % refers the shifting SSI for SIL is not moving?
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  sumsPGSS is shorter than sumsPGC2 by 2*mshift.  This is why sumsPGC2 etc
    %  is shifted by +mshift.  cumsumPGSS(1,:)=cumsum(PGSSx)(1,:) starts mshift
    %  to the right of the first data sample.  igstart is how many to the right
    %  of that.
    %  6/29/2018:  I'm pretty sure I want to subtract mshift from every iend or
    %  istart index to the right of the equal signs in the following FOR loop.
    %  The following looks like it (previously) had the proper relative shifts but the
    %  absolute time wasn't registered to the global igstart properly.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for n=1:nwin
        istart=igstart+(n-1)*winoff;     % 2*sps+1 + (n-1)*3*sps, igstart is the index of the starting sample; istart is index of each sample window
        iend=istart+winlen-1;              % + 12.5*sps, ADD -1 by Chao, 2019/02/17
        timswin(n)=timsSTA(istart+winlen/2);    % timsSTA, time serie data of STA; timswin, center of win, also == (istart+iend)/2
        sumsSTA12(n,:)=cumsumSTA12(iend-mshift,:)-cumsumSTA12(istart-mshift-1,:);  %Yes, -mshift (6/29/18), sum of square of points between istart-mshift and iend-shift
        sumsSTA13(n,:)=cumsumSTA13(iend-mshift,:)-cumsumSTA13(istart-mshift-1,:);  %%% result in the sum from istart-mshift to iend-mshift
        sumsSTA32(n,:)=cumsumSTA32(iend-mshift,:)-cumsumSTA32(istart-mshift-1,:);
        sumsSTA1sq(n,:)=STAsq(1,iend)-STAsq(1,istart-1);  %PGC2 is cumsummed. Yes, +mshift.  No, no mshift (6/29/18)
        sumsSTA3Bsq(n,:)=STAsq(3,iend)-STAsq(3,istart-1); %Similar, for the SILB-SSIB connection, here SILB does not shift
        for m=-mshift:mshift
            sumsSTA2sq(n,m+mshift+1)=STAsq(2,iend-m)-STAsq(2,istart-1-m); %+m??? (yes).
            sumsSTA3sq(n,m+mshift+1)=STAsq(3,iend-m)-STAsq(3,istart-1-m);
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  Denominator for the normalization.  A 2D array, nwin by 2*mshift+1.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %An attempt to bypass glitches in data.  Min value of good data typically ~10^{-2}
    glitches=1.e-7;
    sumsSTA1sq=max(sumsSTA1sq,glitches);    
    sumsSTA2sq=max(sumsSTA2sq,glitches);
    sumsSTA3sq=max(sumsSTA3sq,glitches);    % return maximum between A and B
    %
    denomSTA12n=realsqrt(sumsSTA1sq.*sumsSTA2sq);    % Real square root, An error is produced if X is negative
    denomSTA13n=realsqrt(sumsSTA1sq.*sumsSTA3sq);
    denomSTA32n=realsqrt(sumsSTA3Bsq.*sumsSTA2sq);
    %
    sumsSTA12n=sumsSTA12./denomSTA12n;   % suffix 'n' means normalized
    sumsSTA13n=sumsSTA13./denomSTA13n;
    sumsSTA32n=sumsSTA32./denomSTA32n;
    [xcmaxSTA12n,imaxSTA12]=max(sumsSTA12n,[],2);   %Integer-offset max cross-correlation
    [xcmaxSTA13n,imaxSTA13]=max(sumsSTA13n,[],2);   % along row, max cc val and index in each window
    [xcmaxSTA32n,imaxSTA32]=max(sumsSTA32n,[],2);
    %Parabolic fit:
    [xmaxSTA12n,ymaxSTA12n,aSTA12]=parabol(nwin,mshift,sumsSTA12n,imaxSTA12); %Interpolated max cross-correlation
    [xmaxSTA13n,ymaxSTA13n,aSTA13]=parabol(nwin,mshift,sumsSTA13n,imaxSTA13);
    [xmaxSTA32n,ymaxSTA32n,aSTA32]=parabol(nwin,mshift,sumsSTA32n,imaxSTA32);

    %h=figure('Position',[0.1*wid 1 2.5*wid hite]); %center

    ix=sub2ind(size(denomSTA12n),(1:nwin)',imaxSTA12); %Find the linear index of the largest denominator
    ampSTA12=sqrt(denomSTA12n(ix)); %This makes amplitude linear rather than quadratic with counts.   % JUST FOR EASIER USAGE
    ampSTA1sq=sumsSTA1sq(ix); %by construction PGC2 is the same for all shifts  % sumsPGC2 becomes sumsSTA1sq
    ampSTA2sq=sumsSTA2sq(ix); % sumsSSIB2 becomes sumsSTA2sq, NOTICE: here ampSTA1sq are still sum of sqaures, i.e., quadratic
    ix=sub2ind(size(denomSTA13n),(1:nwin)',imaxSTA13);
    ampSTA13=sqrt(denomSTA13n(ix));
    ampSTA3sq=sumsSTA3sq(ix);
    ix=sub2ind(size(denomSTA32n),(1:nwin)',imaxSTA32);
    ampSTA32=sqrt(denomSTA32n(ix));
    AmpComp(1:4)=0;       % amplitude compare
    %AmpComp seems to be amplitude squared in 4s window minus amp squared in prior window,
    %divided by sum of amp squared in the two windows.  And why?
    AmpComp(5:nwin)=((ampSTA1sq(5:nwin)+ampSTA2sq(5:nwin)+ampSTA3sq(5:nwin))- ...
                    (ampSTA1sq(1:nwin-4)+ampSTA2sq(1:nwin-4)+ampSTA3sq(1:nwin-4)))./ ...
                    ((ampSTA1sq(5:nwin)+ampSTA2sq(5:nwin)+ampSTA3sq(5:nwin))+ ...
                    (ampSTA1sq(1:nwin-4)+ampSTA2sq(1:nwin-4)+ampSTA3sq(1:nwin-4))) ;
                
    %Center them
    imaxSTA12cent=imaxSTA12-mshift-1;  % "cent" is "centered"; imaxSTA12 is original 1: 2*mshift+1, corresponds to -mshift: mshift
    imaxSTA13cent=imaxSTA13-mshift-1;  
    imaxSTA32cent=imaxSTA32-mshift-1;
    %%% NOTICE: the right order of a closed 3-sta pair is +13, -12, +32, where 13 means 1-->3 
    iloopoff=imaxSTA13cent-imaxSTA12cent+imaxSTA32cent; %How well does the integer loop close?
    %
    xmaxSTA12n=xmaxSTA12n-mshift-1;
    xmaxSTA13n=xmaxSTA13n-mshift-1;
    xmaxSTA32n=xmaxSTA32n-mshift-1;
    loopoff=xmaxSTA13n-xmaxSTA12n+xmaxSTA32n; %How well does the interpolated loop close?
    xcmaxAVEn=(xcmaxSTA12n+xcmaxSTA13n+xcmaxSTA32n)/3;     % arithmetic average, == x-corr max average normalized
    % xcnshifts=cputime-t
    % t=cputime;
    %%% ampmax == max amplitude among all windows of all 3 2-station pairs
    ampmax=max([ampSTA12; ampSTA13; ampSTA32]);  % ';' means another row, size of the concatenate is 3*nwin, 2*mshift+1
    medxcmaxAVEn=median(xcmaxAVEn)
    xmaxSTA12ntmp=xmaxSTA12n;    % tmp == temporary
    xmaxSTA13ntmp=xmaxSTA13n;
    xmaxSTA32ntmp=xmaxSTA32n;

    %% find the strongest 0.5s window with main arrival
    % iup=4;
    nin=0;      % subscript flag, to count the successful detections
    zerosallowed=20*winlen/160;   % 20*12.5*sps/160, BUT what is the meaning of this eqn, 5 zeros /sec == 5*12.5 /win ???  
    concentration=0.5; %in seconds; how concentrated is the coherent energy within the window?
    cncntr=concentration*sps;   % in samples, 20
    offset=round(0.5*cncntr);   % +- 1/2*cncntr, 10 samples, 0.25s
    for n=1:nwin
%         n=1;
        %%%%%%%%%%%%%%% Detection Rejection Criteria %%%%%%%%%%%%%%%%%%%%%%
        % 1. if < min threshold == 0.3, or
        % 2. abs(loopoff) > loopoffmax == 2.1, or
        % 3. imaxSTA12/13/32 is 1 or 2*mshift+1, which is located at the edge of the range [1, 2*mshift+1], or
        % 4. too much zeros in the trace
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% xmaxSTA13n(n)-xmaxSTA12n(n)+xmaxSTA32n(n) == loopoff(n)
        if xcmaxAVEn(n)<xcmaxAVEnmin || abs(xmaxSTA13n(n)-xmaxSTA12n(n)+xmaxSTA32n(n))>loopoffmax ...
                || isequal(abs(imaxSTA12cent(n)),mshift) || isequal(abs(imaxSTA13cent(n)),mshift) ...
                || isequal(abs(imaxSTA32cent(n)),mshift) || max(STAnzeros(:,n))>zerosallowed        
            xmaxSTA12ntmp(n)=mshift+1; xmaxSTA13ntmp(n)=mshift+1; xmaxSTA32ntmp(n)=mshift+1; %dummy them, if these criteria are met
        else
    %         interpPGSSn=interp(sumsPGSSn(n,:),iup,3);
    %         interpPGSIn=interp(sumsPGSIn(n,:),iup,3);
    %         interpSISSn=interp(sumsSISSn(n,:),iup,3);
    %         leninterp=length(interpPGSSn);
    %         [xcmaxinterpPGSSn,imaxinterpPGSS]=max(interpPGSSn(1:leninterp-(iup-1)));
    %         [xcmaxinterpPGSIn,imaxinterpPGSI]=max(interpPGSIn(1:leninterp-(iup-1)));
    %         [xcmaxinterpSISSn,imaxinterpSISS]=max(interpSISSn(1:leninterp-(iup-1)));
    %         xcmaxconprev=-99999.;  %used to be 0; not good with glitches
    %         for iPGSS=max(1,imaxinterpPGSS-3*iup):min(imaxinterpPGSS+3*iup,iup*(2*mshift+1)-(iup-1)) %3 samples from peak; 
    %                                                                                  %intentionally wider than acceptable;
    %                                                                                  %iup-1 are extrapolated points
    %             for iPGSI=max(1,imaxinterpPGSI-3*iup):min(imaxinterpPGSI+3*iup,iup*(2*mshift+1)-(iup-1))
    %                 ibangon = (iup*mshift+1)-iPGSI+iPGSS;
    %                 if ibangon >= 1 && ibangon<=iup*(2*mshift+1)
    %                     xcmaxcon=interpPGSSn(iPGSS)+interpPGSIn(iPGSI)+interpSISSn(ibangon);
    %                     if xcmaxcon > xcmaxconprev
    %                         xcmaxconprev=xcmaxcon;
    %                         iPGSSbang=iPGSS;
    %                         iPGSIbang=iPGSI;
    %                     end
    %                 end
    %             end
    %         end
            xcmaxconprev=-99999.;  %used to be 0; not good with glitches
            imaxSTA12n=imaxSTA12(n); %This "n" for nth window; other "n's" for "normalized".  Unfortunately.
            imaxSTA13n=imaxSTA13(n);
            imaxSTA32n=imaxSTA32(n);
            sumsSTA12nn=sumsSTA12n(n,:);   % xxx'n' for normalized,
            sumsSTA13nn=sumsSTA13n(n,:);
            sumsSTA32nn=sumsSTA32n(n,:);
            % Usually, the loop is happened between imaxSTA12n +- floor(loopoffmax+1)
            %%% floor(2.5)=2; floor(-2.6)=-3
            for iSTA12 =     max(1,imaxSTA12n-floor(loopoffmax+1)): min(imaxSTA12n+floor(loopoffmax+1),2*mshift+1)
                for iSTA13 = max(1,imaxSTA13n-floor(loopoffmax+1)): min(imaxSTA13n+floor(loopoffmax+1),2*mshift+1)
                    ibangon = (mshift+1)-iSTA13+iSTA12;     %%% SEE NOTES #2019/03/17# page 66 to understand better 
                    %%% i.e., -mshift <= -iSTA13+iSTA12 <= mshift
                    if ibangon >= 1 && ibangon <= 2*mshift+1
                        xcmaxcon=sumsSTA12nn(iSTA12)+sumsSTA13nn(iSTA13)+sumsSTA32nn(ibangon);
                        if xcmaxcon > xcmaxconprev
                            xcmaxconprev=xcmaxcon;
                            iSTA12bang=iSTA12;
                            iSTA13bang=iSTA13;
                        end
                    end
                end
            end
            %%% will result in the max xcmaxcon and corresponding iSTA12,
            %%% iSTA13, and save them into xcmaxconprev, iSTA12bang and iSTA13bang
            
    %         iSISSbang=(iup*mshift+1)-iPGSIbang+iPGSSbang;
    %         if abs(iPGSSbang-imaxinterpPGSS) <= loopoffmax*iup && ...
    %            abs(iPGSIbang-imaxinterpPGSI) <= loopoffmax*iup && ...
    %            abs(iSISSbang-imaxinterpSISS) <= loopoffmax*iup && ...
    %            interpPGSSn(iPGSSbang)+interpPGSIn(iPGSIbang)+interpSISSn(iSISSbang) >= 3*xcmaxAVEnmin
    %             xmaxPGSSntmp(n)=(iPGSSbang-(iup*mshift+1))/iup;
    %             xmaxPGSIntmp(n)=(iPGSIbang-(iup*mshift+1))/iup;
    %             xmaxSISSntmp(n)=(iSISSbang-(iup*mshift+1))/iup;
            iSTA32bang=(mshift+1)-iSTA13bang+iSTA12bang;
            if abs(iSTA12bang-imaxSTA12n) <= loopoffmax && ...  %not sure if these 3 lines are satisfied automatically ...
               abs(iSTA13bang-imaxSTA13n) <= loopoffmax && ...  % SHOULD not be, i think, could be floor(loopoffmax+1) > loopoffmax 
               abs(iSTA32bang-imaxSTA32n) <= loopoffmax && ...
               sumsSTA12n(n,iSTA12bang)+sumsSTA13n(n,iSTA13bang)+sumsSTA32n(n,iSTA32bang) >= 3*xcmaxAVEnmin   % xcmaxAVEnmin, predetermined
               %%% ALSO, sumsSTA12n(n,iSTA12bang) == sumsSTA12nn(iSTA12bang)
               
                xmaxSTA12ntmp(n)=iSTA12bang-(mshift+1); %without interpolation this is just centering.
                xmaxSTA13ntmp(n)=iSTA13bang-(mshift+1);
                xmaxSTA32ntmp(n)=iSTA32bang-(mshift+1);

                %for plotting traces
                imaxSTA12wr=round(xmaxSTA12ntmp(n)); %without interpolation this is not needed.
                imaxSTA13wr=round(xmaxSTA13ntmp(n));
    % 
                istart=igstart+(n-1)*winoff; %+mshift; %a better way might exist?  %ADDED mshift 10/20/12; DELETED IT 1/19/17.
                    %ADDED IT BACK 10/4/2017 to fix bug.  PGC is offset from igstart by mshift before first x-correlation.
                    %Not sure why mshift was added.  It changes STA12tr, STA1file etc. relative to the window that was used
                    %in the original x-correlation.  This will affect the stated time of max energy (through idiff).
                    %GOT RID of the mshift, yet again, 6/29/18, but only after subtracing mshift from all those istarts and
                    %iends in lines 342-355.
                iend=istart+winlen-1;
                imid=round((istart+iend)/2);
                %Check power spectrum for reasonableness
                %%% pwelch is a built-in function, [Pxx F] = pwelch(X, WINDOW, NOVERLAP, NFFT, Fs)
                [STA1xx fp] = pwelch(STAopt(1,istart:iend),[],[],[],sps); %40 is sps   
                STA1xx=STA1xx/max(STA1xx);    % normalization
                [STA2xx fp] = pwelch(STAopt(2,istart-imaxSTA12wr:iend-imaxSTA12wr),[],[],[],sps);  % WHY substract imaxSTA12wr ???
                STA2xx=STA2xx/max(STA2xx);
                [STA3xx fp] = pwelch(STAopt(3,istart-imaxSTA13wr:iend-imaxSTA13wr),[],[],[],sps);
                STA3xx=STA3xx/max(STA3xx);
                flo=find(fp > lo,1)-1;    % find(fp > lo,1) finds the first 1 indice that satisfies fp > lo
                fhi=find(fp > hi,1)+1;    %extra 1 for good measure
                belowcut=median([STA1xx(2:flo); STA2xx(2:flo); STA3xx(2:flo)]);   
                ppeaksSTA1=findpeaks(STA1xx(flo+1:fhi));   % PKS = findpeaks(Y) finds local peaks in the data vector Y
                if length(ppeaksSTA1)>=1
                    maxppeakSTA1=max(ppeaksSTA1);
                else
                    maxppeakSTA1=0.;
                end
                ppeaksSTA2=findpeaks(STA2xx(flo+1:fhi));   % for STA2, use exactly the same procedure as STA1 
                if length(ppeaksSTA2)>=1
                    maxppeakSTA2=max(ppeaksSTA2);
                else
                    maxppeakSTA2=0.;
                end
                ppeaksSTA3=findpeaks(STA3xx(flo+1:fhi));   % for STA3, still the same
                if length(ppeaksSTA3)>=1
                    maxppeakSTA3=max(ppeaksSTA3);
                else
                    maxppeakSTA3=0.;
                end
                abovecut=median([maxppeakSTA1 maxppeakSTA2 maxppeakSTA3]);   % relative to belowcut, remain [belowcut, abovecut]
                if abovecut > 0.9*belowcut %-1 %This checks for frequency range; make sure it's not too narrow?
                    STA12tr=STAopt(1,istart:iend).*STAopt(2,istart-imaxSTA12wr:iend-imaxSTA12wr);   % see line 554, imax is already centered
                    STA13tr=STAopt(1,istart:iend).*STAopt(3,istart-imaxSTA13wr:iend-imaxSTA13wr);   % see line 556
                    STA32tr=STAopt(3,istart-imaxSTA13wr:iend-imaxSTA13wr).*STAopt(2,istart-imaxSTA12wr:iend-imaxSTA12wr);
                    cumsumtr=cumsum(STA12tr)+cumsum(STA13tr)+cumsum(STA32tr);    % sum of the cumsum of all traces
                    %%% first get the squared sum of each 0.5s window, then get the maximum and start indice
                    [cumsumtrdiff, idiff]=max(cumsumtr(cncntr+1:winlen)-cumsumtr(1:winlen-cncntr));
                    
                    %What is amp squared in strongest coherent 1/2 sec?
                    %%% amp squared is a self to self operation
                    %%% NOTICE!   HERE, istart=igstart+(n-1)*winoff >= igstart,
                    %%% So, isdiff >= istart >= igstart 
                    isdiff=istart+idiff; %Start of strongest 0.5s, DELETE -1 by Chao, 2019/02/17, see NOTES
                    iediff=istart+idiff-1+cncntr;  % cncntr is 20sps == 0.5s
                    dummy=STAopt(1,isdiff:iediff).*STAopt(1,isdiff:iediff)+ ...   % point square 
                          STAopt(2,isdiff-imaxSTA12wr:iediff-imaxSTA12wr).*STAopt(2,isdiff-imaxSTA12wr:iediff-imaxSTA12wr)+ ...
                          STAopt(3,isdiff-imaxSTA13wr:iediff-imaxSTA13wr).*STAopt(3,isdiff-imaxSTA13wr:iediff-imaxSTA13wr);
                    dum2=cumsum(dummy);
                    Ampsq(nin+1)=dum2(end);   % Ampsq(1) == amplitude square = cumsum of all dummy = squared sum
                    
                    %%Energy in prior 1.25s == 1.25*sps == 2.5*cncntr, with offset (assuming 0.5cncntr)
                    %%% energy is a self to self operation, and is proportional to amp squared 
                    dummy=STAopt(1,isdiff-2.5*cncntr-offset:isdiff-offset).*STAopt(1,isdiff-2.5*cncntr-offset:isdiff-offset)+ ...
                          STAopt(2,isdiff-2.5*cncntr-imaxSTA12wr-offset:isdiff-imaxSTA12wr-offset).*STAopt(2,isdiff-2.5*cncntr-imaxSTA12wr-offset:isdiff-imaxSTA12wr-offset)+ ...
                          STAopt(3,isdiff-2.5*cncntr-imaxSTA13wr-offset:isdiff-imaxSTA13wr-offset).*STAopt(3,isdiff-2.5*cncntr-imaxSTA13wr-offset:isdiff-imaxSTA13wr-offset);
                    dum2=cumsum(dummy);
                    Prev(nin+1)=dum2(end);    % Prev(1) == previous 1.25s window before the strongest window, length 2.5*cncntr
                    clear dummy
                    
                    %CC in same window (test)
                    %%% cc is a cross-station operation
                    dummy(1,:)=STAopt(1,istart:iend);
                    dummy(2,:)=STAopt(2,istart-imaxSTA12wr:iend-imaxSTA12wr);
                    dummy(3,:)=STAopt(3,istart-imaxSTA13wr:iend-imaxSTA13wr);
                    denoms=dot(dummy,dummy,2);    % dot(A,B,DIM) returns the summed scalar product of A and B in the dimension DIM, 2 is row 
                    cc(nin+1)=(dot(dummy(1,:),dummy(2,:))/sqrt(denoms(1)*denoms(2))+dot(dummy(2,:),dummy(3,:))/sqrt(denoms(2)*denoms(3))+ ...
                               dot(dummy(3,:),dummy(1,:))/sqrt(denoms(3)*denoms(1)))/3;
                    clear dummy
                    
                    %CC in prior 1.25 seconds, with offset
                    dummy(1,:)=STAopt(1,isdiff-2.5*cncntr-offset:isdiff-1-offset);   % 2.5*cnctr == 1.25s *sps
                    dummy(2,:)=STAopt(2,isdiff-imaxSTA12wr-2.5*cncntr-offset:isdiff-imaxSTA12wr-1-offset);
                    dummy(3,:)=STAopt(3,isdiff-imaxSTA13wr-2.5*cncntr-offset:isdiff-imaxSTA13wr-1-offset);
                    denoms=dot(dummy,dummy,2);   % dot(A,B,DIM) returns the summed scalar product of A and B in the dimension DIM, 2 is row
                    ccprior125(nin+1)=(dot(dummy(1,:),dummy(2,:))/sqrt(denoms(1)*denoms(2))+dot(dummy(2,:),dummy(3,:))/sqrt(denoms(2)*denoms(3))+ ...
                                       dot(dummy(3,:),dummy(1,:))/sqrt(denoms(3)*denoms(1)))/3;  % ccprior125(1) means cc in prior 1.25s
                    clear dummy
                    
                    %CC in prior 4 seconds, with offset
                    if isdiff > winlen+mshift+offset   % >winsec*sps+19+10
                        dummy(1,:)=STAopt(1,isdiff-winlen-offset:isdiff-1-offset);   % this is 12.5s much more than 4s, maybe the previous winlen is 4s
                        dummy(2,:)=STAopt(2,isdiff-imaxSTA12wr-winlen-offset:isdiff-imaxSTA12wr-1-offset);
                        dummy(3,:)=STAopt(3,isdiff-imaxSTA13wr-winlen-offset:isdiff-imaxSTA13wr-1-offset);
                    else
                        dummy(1,:)=STAopt(1,mshift:isdiff-1);   % 19: isdiff-1    % MIGHT this part be a mistake? no symmetry, with offset
                        dummy(2,:)=STAopt(2,mshift-imaxSTA12wr:isdiff-imaxSTA12wr-1-offset);
                        dummy(3,:)=STAopt(3,mshift-imaxSTA13wr:isdiff-imaxSTA13wr-1-offset);
                    end
                    denoms=dot(dummy,dummy,2);
                    ccprior(nin+1)=(dot(dummy(1,:),dummy(2,:))/sqrt(denoms(1)*denoms(2))+dot(dummy(2,:),dummy(3,:))/sqrt(denoms(2)*denoms(3))+ ...
                                    dot(dummy(3,:),dummy(1,:))/sqrt(denoms(3)*denoms(1)))/3;
                    clear dummy
                    
                    %CC in following 1.25 seconds, with 2*offset
                    dummy(1,:)=STAopt(1,iediff+1+2*offset:iediff+2.5*cncntr+2*offset);  % 1.25s win after 0.5s after 2*offset
                    dummy(2,:)=STAopt(2,iediff+1-imaxSTA12wr+2*offset:iediff-imaxSTA12wr+2.5*cncntr+2*offset);
                    dummy(3,:)=STAopt(3,iediff+1-imaxSTA13wr+2*offset:iediff-imaxSTA13wr+2.5*cncntr+2*offset);
                    denoms=dot(dummy,dummy,2);
                    ccpost125(nin+1)=(dot(dummy(1,:),dummy(2,:))/sqrt(denoms(1)*denoms(2))+dot(dummy(2,:),dummy(3,:))/sqrt(denoms(2)*denoms(3))+ ...
                                      dot(dummy(3,:),dummy(1,:))/sqrt(denoms(3)*denoms(1)))/3;
                    clear dummy
                    
%                   %CC in following 4 seconds
%                   if iediff < winbig-winlen-mshift
%                       dummy(1,:)=STAopt(1,iediff+1:iediff+winlen);
%                       dummy(2,:)=STAopt(2,iediff+1-imaxSTA12wr:iediff-imaxSTA12wr+winlen);
%                       dummy(3,:)=STAopt(3,iediff+1-imaxSTA13wr:iediff-imaxSTA13wr+winlen);
%                   else
%                       dummy(1,:)=STAopt(1,iediff+1:winbig-mshift);
%                       dummy(2,:)=STAopt(2,iediff+1-imaxSTA12wr:winbig-mshift-imaxSTA12wr);
%                       dummy(3,:)=STAopt(3,iediff+1-imaxSTA13wr:winbig-mshift-imaxSTA13wr);
%                   end
%                   denoms=dot(dummy,dummy,2);
%                   ccpost(nin+1)=(dot(dummy(1,:),dummy(2,:))/sqrt(denoms(1)*denoms(2))+dot(dummy(2,:),dummy(3,:))/sqrt(denoms(2)*denoms(3))+ ...
%                                 dot(dummy(3,:),dummy(1,:))/sqrt(denoms(3)*denoms(1)))/3;
%                   clear dummy

                    %Energy in prior 15 seconds
                    %%% STAauto is dot product, an array, why use median?
                    if isdiff > 15*sps+mshift
                        dummy=median(STAauto(1,isdiff-15*sps:isdiff))+ ...    % sum of median of 15-s win
                              median(STAauto(2,isdiff-15*sps-imaxSTA12wr:isdiff-imaxSTA12wr))+ ...
                              median(STAauto(3,isdiff-15*sps-imaxSTA13wr:isdiff-imaxSTA13wr));
                    else
                        dummy=median(STAauto(1,1:isdiff))+ ...
                              median(STAauto(2,1:isdiff-imaxSTA12wr))+ ...
                              median(STAauto(3,1:isdiff-imaxSTA13wr));
                    end
                    Prev15(nin+1)=dummy;
                    clear dummy
                    
                    %Energy in prior 30 seconds
                    if isdiff > 30*sps+mshift
                        dummy=median(STAauto(1,isdiff-30*sps:isdiff))+ ...
                              median(STAauto(2,isdiff-30*sps-imaxSTA12wr:isdiff-imaxSTA12wr))+ ...
                              median(STAauto(3,isdiff-30*sps-imaxSTA13wr:isdiff-imaxSTA13wr));
                    else
                        dummy=median(STAauto(1,1:isdiff))+ ...
                              median(STAauto(2,1:isdiff-imaxSTA12wr))+ ...
                              median(STAauto(3,1:isdiff-imaxSTA13wr));
                    end
                    Prev30(nin+1)=dummy;
                    clear dummy
                    
                    % energy (amp squared sum) in post 1.25s window
                    dummy=STAopt(1,iediff:iediff+2.5*cncntr).*STAopt(1,iediff:iediff+2.5*cncntr)+ ...   % 1.25s after iediff
                          STAopt(2,iediff-imaxSTA12wr:iediff+2.5*cncntr-imaxSTA12wr).*STAopt(2,iediff-imaxSTA12wr:iediff+2.5*cncntr-imaxSTA12wr)+ ...
                          STAopt(3,iediff-imaxSTA13wr:iediff+2.5*cncntr-imaxSTA13wr).*STAopt(3,iediff-imaxSTA13wr:iediff+2.5*cncntr-imaxSTA13wr);
                    dum2=cumsum(dummy);
                    Post(nin+1)=dum2(end);
                    clear dummy
                    
                    %%%%%%%For comparison, start
                    %
                    %%% isdiff=istart+idiff-1, so indx == isdiff+round(cncntr/2)
                    indx=istart+idiff-1+round(cncntr/2); %indx should be centered ~ on zero-crossing of main arrival
                    traces(1,:)=STAopt(1,indx-tempbef:indx+tempaft);   % -59;+60
                    traces(2,:)=STAopt(2,indx-tempbef-imaxSTA12wr:indx+tempaft-imaxSTA12wr);
                    traces(3,:)=STAopt(3,indx-tempbef-imaxSTA13wr:indx+tempaft-imaxSTA13wr);
                    for ista=1:nsta
                        % tempxc == template x-corr, |max lag| == 0.25s == 10 samples
                        % cc between template and the window with the main arrival
                        tempxc(ista,:)=xcorr(traces(ista,:),STAtemps(ista,:),floor(cncntr/2),'coeff');
                    end
                    sumxc=sum(tempxc)/nsta;    % sum along column, average cc coeff of all 3 stats at each shift
                    [match(nin+1,1), ioff]=max(sumxc);  % get the max coeff and the index of the shift
                    %%% the follow line is to convert index to real shift value
                    ioff=ioff-(floor(cncntr/2)+1); %shift STAtemps by match(nin+1) (shift right for positive values)
                    %%% timstemp == times of template, 1: 120, 121: 240
                    timstemp(nin*templen+1:(nin+1)*templen)=timsSTA(indx-tempbef+ioff:indx+tempaft+ioff);
                    for ista=1:nsta
                        % tempxcneg means x-corr with negative template
                        tempxcneg(ista,:)=xcorr(traces(ista,:),-STAtemps(ista,:),floor(cncntr/2),'coeff'); 
                    end
                    sumxcneg=sum(tempxcneg)/nsta;    
                    [match(nin+1,2), ioff]=max(sumxcneg);
                    ioff=ioff-(floor(cncntr/2)+1); %shift "snips" by match(nin+1) (shift right for positive values), what is snips ???
                    timstempneg(nin*templen+1:(nin+1)*templen)=timsSTA(indx-tempbef+ioff:indx+tempaft+ioff);
                    %%%%%%%For comparison, end

                    % STA1file, STA2file, STA3file are back-to-back windows for the day (plus sample times)
                    % 1st column: time
                    % 2nd column: data
                    STA1file(nin*winlen+1:(nin+1)*winlen,1:2)=[timsSTA(istart:iend)' STAopt(1,istart:iend)'];
                    STA2file(nin*winlen+1:(nin+1)*winlen,1:2)=[timsSTA(istart:iend)' STAopt(2,istart-imaxSTA12wr:iend-imaxSTA12wr)'];
                    STA3file(nin*winlen+1:(nin+1)*winlen,1:2)=[timsSTA(istart:iend)' STAopt(3,istart-imaxSTA13wr:iend-imaxSTA13wr)'];
                    STAamp(nin+1,1)=prctile(abs(STAopt(1,istart:iend)),80);  % prctile,  Percentiles of a sample, SEE NOTES
                    STAamp(nin+1,2)=prctile(abs(STAopt(2,istart-imaxSTA12wr:iend-imaxSTA12wr)),80);
                    STAamp(nin+1,3)=prctile(abs(STAopt(3,istart-imaxSTA13wr:iend-imaxSTA13wr)),80);
                    STAamp(nin+1,:)=STAamp(nin+1,:)/STAamp(nin+1,1);   % normalization relative to 1st stat
                    STA1bbfile(nin*winlen+1:(nin+1)*winlen,1:2)=[timsSTA(istart:iend)' STAoptbb(1,istart:iend)'];  % bb is broader band
                    STA2bbfile(nin*winlen+1:(nin+1)*winlen,1:2)=[timsSTA(istart:iend)' STAoptbb(2,istart-imaxSTA12wr:iend-imaxSTA12wr)'];
                    STA3bbfile(nin*winlen+1:(nin+1)*winlen,1:2)=[timsSTA(istart:iend)' STAoptbb(3,istart-imaxSTA13wr:iend-imaxSTA13wr)'];
                    %%% imaxSTA12wr     -> cc shift of qualified win only, so remain no changed until the next qualified win;
                    %%% xcmaxSTA12n(n)  -> max cc coef in all 4s win
                    %%% cumsumtrdiff/cumsumtr(winlen) -> normalized cumsumtrdiff
                    STA12file(nin+1,1:2)=[imaxSTA12wr xcmaxSTA12n(n)];  
                    STA13file(nin+1,1:2)=[imaxSTA13wr xcmaxSTA13n(n)];
                    STA32file(nin+1,1:3)=[cumsumtrdiff/cumsumtr(winlen) xcmaxSTA32n(n) idiff];

                    nin=nin+1;
                    istartkeep(nin)=istart; %For adding other stations later, keep the istart of each win
                    aSTA12keep(nin,:)=[timswin(n) aSTA12(n)];   % timswin == time at the center of each win 
                    aSTA13keep(nin,:)=[timswin(n) aSTA13(n)];   
                    aSTA32keep(nin,:)=[timswin(n) aSTA32(n)];
                    loopoffkeep(nin,:)=[timswin(n) loopoff(n)];
                    
                    %%% 1. Without interpolation, xmaxSTA13ntmp == imaxSTA13wr
                    %%% 2. xcmaxAVEn is arithmetic average, == x-corr coeff max average normalized in each win 
                    %%% 3. Ampsq -> amplitude square == squared sum in each strongest 0.5s win
                    %%% 4. cumsumtrdiff -> the maximum squared sum of among all 0.5s windows
                    %%% 5. timswin(n)-winlensec/2+idiff/sps -> start time in sec of the strongest 0.5s win
                    %%% 6. cumsumtrdiff/cumsumtr(winlen) -> normalized cumsumtrdiff
                    %%% 7. match(1) -> max cc coeff between template and the window with the main arrival, 2s win, 120 samples
                    %%% 8. match(2) -> max cc coeff between negtive template and the window with the main arrival, 2s win, 120 samples
                    %%% 9. Prev -> amp squared sum (energy) in previous 1.25s window before the strongest window
                    %%% 10. Post -> amp squared sum (energy) in post 1.25s window before the strongest window
                    %%% 11. ccprior -> cc coeff in previous 4 secs window
                    %%% 12. STAamp -> normalized 80 percentile of amplitude of data
                    %%% 13. xcmaxSTA12n -> max cc coeff in each 4s window
                    mapfile(nin,:)=[timswin(n) xmaxSTA13ntmp(n) xmaxSTA12ntmp(n) ...
                        xcmaxAVEn(n) loopoff(n) Ampsq(nin) cumsumtrdiff timswin(n)-winlensec/2+idiff/sps cumsumtrdiff/cumsumtr(winlen) ...
                        match(nin,1) match(nin,2) Prev(nin) Post(nin) Prev15(nin) Prev30(nin) ...
                        ccprior125(nin) ccprior(nin) ccpost125(nin) STAamp(nin,2) STAamp(nin,3) xcmaxSTA12n(n) xcmaxSTA13n(n) xcmaxSTA32n(n) ];
                else
                    % 20 == mshift+1
                    xmaxSTA12ntmp(n)=mshift+1; xmaxSTA13ntmp(n)=mshift+1; xmaxSTA32ntmp(n)=mshift+1;
                end
            else
                xmaxSTA12ntmp(n)=mshift+1; xmaxSTA13ntmp(n)=mshift+1; xmaxSTA32ntmp(n)=mshift+1; 
            end
        end
    end

    %% Write results into files
    %fid = fopen(['ARMMAP/MAPS/map',IDENTIF,'_',num2str(lo),'-',num2str(hi),'-','ms',int2str(mshift),'-',int2str(winlen/40),'s'],'w');
%     fid = fopen(['ARMMAP/MAPS/2018Sep/map',IDENTIF,'_',num2str(lo),'-',num2str(hi),'-','ms',int2str(mshift),'-',int2str(winlen/40),'s'],'w');
    fid = fopen([workpath,'/LZBtrio/MAPS/map',IDENTIF,'_',num2str(lo),'-',num2str(hi),'_',num2str(winlen/sps),'s',num2str(sps),'sps'],'w+');

    fprintf(fid,'%9.1f %6.2f %6.2f %8.3f %7.2f %10.3e %10.3e %10.3f %7.3f %7.3f %7.3f %10.3e %10.3e %10.3e %10.3e %7.3f %7.3f %7.3f %5.2f %5.2f %7.3f %7.3f %7.3f\n',mapfile(1:nin,:)');
    fclose(fid);
    
    fid = fopen(strcat(workpath, '/LZBtrio/MAPS/seistrace_',IDENTIF,'_',num2str(lo),'-',num2str(hi),'_',num2str(winlen/sps),'s',num2str(sps),'sps'),'w+');
    tracefile = [STA1file(1:nin*winlen,:) STA2file(1:nin*winlen,2) STA3file(1:nin*winlen,2)];
    fprintf(fid,'%.4f %.6f %.6f %.6f \n',tracefile');
    fclose(fid);

    %% Plot
    % The follow 4 subplots are basically the same, dividing the time axis
    % into 4 parts
    figure(101)
    subplot(4,1,1,'align'); 
    hold on
    plot(timswin,xcmaxAVEnmin*mshift+zeros(nwin,1),'k:');
    plot(timsSTA(winlen:2*winlen),7+zeros(winlen+1,1),'k','linewidth',2);
    plot(timswin,zeros(nwin,1),'k:');
    plot(timswin,xcmaxAVEn*mshift,'g');
    plot(timswin,xmaxSTA12ntmp,'bs','MarkerSize',2);
    plot(timswin,xmaxSTA13ntmp,'ro','MarkerSize',2);
    plot(timswin,xmaxSTA32ntmp,'k*','MarkerSize',2);
    axis([0 timbig/2 -mshift mshift]);
    ylabel('samples')
    title([IDENTIF,'_{',num2str(lo),'-',num2str(hi),'}'])
    box on
    
    subplot(4,1,2,'align'); 
    hold on
    plot(timswin,xcmaxAVEnmin*mshift+zeros(nwin,1),'k:');
    plot(timswin,zeros(nwin,1),'k:');
    plot(timswin,xcmaxAVEn*mshift,'g');
    plot(timswin,xmaxSTA12ntmp,'bs','MarkerSize',2);
    plot(timswin,xmaxSTA13ntmp,'ro','MarkerSize',2);
    plot(timswin,xmaxSTA32ntmp,'k*','MarkerSize',2);
    axis([timbig/2 timbig -mshift mshift]);
    ylabel('samples')
    box on
    
    subplot(4,1,3,'align'); 
    hold on
    plot(timswin,xcmaxAVEnmin*mshift+zeros(nwin,1),'k:');
    plot(timswin,zeros(nwin,1),'k:');
    plot(timswin,xcmaxAVEn*mshift,'g');
    plot(timswin,xmaxSTA12ntmp,'bs','MarkerSize',2);
    plot(timswin,xmaxSTA13ntmp,'ro','MarkerSize',2);
    plot(timswin,xmaxSTA32ntmp,'k*','MarkerSize',2);
    axis([timbig 3*timbig/2 -mshift mshift]);
    ylabel('samples')
    box on
    
    subplot(4,1,4,'align'); 
    hold on
    plot(timswin,xcmaxAVEnmin*mshift+zeros(nwin,1),'k:');
    plot(timswin,zeros(nwin,1),'k:');
    plot(timswin,xcmaxAVEn*mshift,'g');
    plot(timswin,xmaxSTA12ntmp,'bs','MarkerSize',2);
    plot(timswin,xmaxSTA13ntmp,'ro','MarkerSize',2);
    plot(timswin,xmaxSTA32ntmp,'k*','MarkerSize',2);
    axis([3*timbig/2 2*timbig -mshift mshift]);
    xlabel('sec')
    ylabel('samples')
    box on
    orient landscape    % is used to set up the paper orientation of a Figure or Model window for printing
    print('-depsc',[workpath,'/LZBtrio/FIGS/',IDENTIF,'_',num2str(winlen/sps),'s_',num2str(sps),'sps_',num2str(lo),'-',num2str(hi),'b.eps'])
    close(101)
    % fid = fopen(['HILBERTS/xcmax',IDENTIF,'_',num2str(lo),'-',num2str(hi),'-','ms',int2str(mshift),'-',int2str(winlen/40),'s'],'w');
    % fprintf(fid,'%9.3f %9.5f\n',[timswin xcmaxAVEn]');
    % fclose(fid);
    % 

    % for n=1:nwin;
    %     if abs(loopoff(n))>2.0
    %         loopoff(n)=30; 
    %     end
    % end
    % figure 
    % subplot(4,1,1,'align'); 
    % hold on
    % plot(timswin,zeros(nwin,1),'k:');
    % plot(timswin,xmaxSTA12ntmp,'bs','MarkerSize',2);
    % plot(timswin,xmaxSTA13ntmp,'ro','MarkerSize',2);
    % plot(timswin,xmaxSTA32ntmp,'k*','MarkerSize',2);
    % plot(timsSTA(winlen:2*winlen),7+zeros(winlen+1,1),'k','linewidth',2);
    % axis([0 timbig/2 -mshift mshift]);
    % title('blue = STA12 ;   red = STA13 ;  black = STA32')
    % box on
    % subplot(4,1,2,'align'); 
    % hold on
    % hrf = plotreflinesr(gca,detects,'x','k'); 
    % hrf = plotreflinesr(gca,Detects,'x','r'); 
    % hrf = plotreflinesr(gca,detects2_8,'x','g'); 
    % hrf = plotreflinesr(gca,Detects2_8,'x','b'); 
    % plot(timswin,xcmaxAVEnmin+zeros(nwin,1),'k:');
    % plot(timswin,xcmaxAVEn,'k');
    % plot(timswin,-1+0.1*abs(loopoff),'g.','MarkerSize',1);
    % plot(timsSTA,min(0,STAopt(1,:),'r');
    % plot(timsSTA,min(0,STAopt(2,:),'b');
    % plot(timsSTA,min(0,STAopt(3,:),'k');
    % axis([0 timbig/2 -1 1]);
    % box on
    % subplot(4,1,3,'align'); 
    % hold on
    % plot(timswin,zeros(nwin,1),'k:');
    % plot(timswin,xmaxSTA12ntmp,'bs','MarkerSize',2);
    % plot(timswin,xmaxSTA13ntmp,'ro','MarkerSize',2);
    % plot(timswin,xmaxSTA32ntmp,'k*','MarkerSize',2);
    % axis([timbig/2 timbig -mshift mshift]);
    % box on
    % subplot(4,1,4,'align'); 
    % hold on
    % hrf = plotreflinesr(gca,detects,'x','k'); 
    % hrf = plotreflinesr(gca,Detects,'x','r'); 
    % hrf = plotreflinesr(gca,detects2_8,'x','g'); 
    % hrf = plotreflinesr(gca,Detects2_8,'x','b'); 
    % plot(timswin,xcmaxAVEnmin+zeros(nwin,1),'k:');
    % plot(timswin,xcmaxAVEn,'k');
    % plot(timswin,-1+0.1*abs(loopoff),'g.','MarkerSize',1);
    % plot(timsSTA,min(0,STAopt(1,:),'r');
    % plot(timsSTA,min(0,STAopt(2,:),'b');
    % plot(timsSTA,min(0,STAopt(3,:),'k');
    % axis([timbig/2 timbig -1 1]);
    % box on
    % title([IDENTIF,'_{',num2str(lo),'-',num2str(hi),'}'])
    % orient landscape
    % print('-depsc',['FIGS/',IDENTIF,'-',int2str(winlen/40),'s_',num2str(lo),'-',num2str(hi),'c.eps'])
    % 
    % figure
    % subplot(4,1,1,'align'); 
    % hold on
    % plot(timswin,zeros(nwin,1),'k:');
    % plot(timswin,xmaxSTA12ntmp,'bs','MarkerSize',2);
    % plot(timswin,xmaxSTA13ntmp,'ro','MarkerSize',2);
    % plot(timswin,xmaxSTA32ntmp,'k*','MarkerSize',2);
    % plot(timsSTA(tracelen/2+winlen:tracelen/2+2*winlen),7+zeros(winlen+1,1),'k','linewidth',2);
    % axis([timbig 3*timbig/2 -mshift mshift]);
    % box on
    % subplot(4,1,2,'align'); 
    % hold on
    % hrf = plotreflinesr(gca,detects,'x','k'); 
    % hrf = plotreflinesr(gca,Detects,'x','r'); 
    % hrf = plotreflinesr(gca,detects2_8,'x','g'); 
    % hrf = plotreflinesr(gca,Detects2_8,'x','b'); 
    % plot(timswin,xcmaxAVEnmin+zeros(nwin,1),'k:');
    % plot(timswin,xcmaxAVEn,'k');
    % plot(timswin,-1+0.1*abs(loopoff),'g.','MarkerSize',1);
    % plot(timsSTA,min(0,STAopt(1,:),'r');
    % plot(timsSTA,min(0,STAopt(2,:),'b');
    % plot(timsSTA,min(0,STAopt(3,:),'k');
    % axis([timbig 3*timbig/2 -1 1]);
    % box on
    % subplot(4,1,3,'align'); 
    % hold on
    % plot(timswin,zeros(nwin,1),'k:');
    % plot(timswin,xmaxSTA12ntmp,'bs','MarkerSize',2);
    % plot(timswin,xmaxSTA13ntmp,'ro','MarkerSize',2);
    % plot(timswin,xmaxSTA32ntmp,'k*','MarkerSize',2);
    % axis([3*timbig/2 2*timbig -mshift mshift]);
    % box on
    % subplot(4,1,4,'align'); 
    % hold on
    % hrf = plotreflinesr(gca,detects,'x','k'); 
    % hrf = plotreflinesr(gca,Detects,'x','r'); 
    % hrf = plotreflinesr(gca,detects2_8,'x','g'); 
    % hrf = plotreflinesr(gca,Detects2_8,'x','b'); 
    % plot(timswin,xcmaxAVEnmin+zeros(nwin,1),'k:');
    % plot(timswin,xcmaxAVEn,'k');
    % plot(timswin,-1+0.1*abs(loopoff),'g.','MarkerSize',1);
    % plot(timsSTA,min(0,STAopt(1,:),'r');
    % plot(timsSTA,min(0,STAopt(2,:),'b');
    % plot(timsSTA,min(0,STAopt(3,:),'k');
    % axis([3*timbig/2 2*timbig -1 1]);
    % box on
    % title([IDENTIF,'_{',num2str(lo),'-',num2str(hi),'}'])
    % orient landscape
    % print('-depsc',['FIGS/',IDENTIF,'-',int2str(winlen/40),'s_',num2str(lo),'-',num2str(hi),'d.eps'])
    %
    
    %%
    figure(102)
    colormap(jet)
    %%% loopoff == xmaxSTA13n-xmaxSTA12n+xmaxSTA32n
    %%% AmpComp -> difference of (sum of squared amplitude in 4s win) between each win and its previous 4th win 
    %%% scatter, 3 is the marker size, AmpComp is the color of the marker
    patch([-loopoffmax -loopoffmax loopoffmax loopoffmax], [xcmaxAVEnmin 1 1 xcmaxAVEnmin], [0.8 0.8 0.8], 'FaceAlpha', 0.9);
    hold on 
    scatter(xmaxSTA13n-xmaxSTA12n+xmaxSTA32n,xcmaxAVEn,3,AmpComp)
    plot(-50:50,xcmaxAVEnmin+zeros(101,1),'k:');
    axis([min(-5,-2.5*loopoffmax) max(5,2.5*loopoffmax) -0.2 1.0])
    hrf = plotreflinesr(gca,-loopoffmax,'x','k');colorbar   % plots dotted lines at the locations specified
    hrf = plotreflinesr(gca,loopoffmax,'x','k');colorbar
    box on
    %%% Tex syntax to use subscript, '_{}'
    title([IDENTIF,'_{',num2str(lo),'-',num2str(hi),'}'])
    xlabel('Sum of the circuit of time offsets')
    ylabel('Average maximum CC coefficients')
    print('-depsc',[workpath,'/LZBtrio/FIGS/',IDENTIF,'_',num2str(winlen/sps),'s_',num2str(sps),'sps_',num2str(lo),'-',num2str(hi),'e.eps'])
    close(102)
    
    %if winlen>500
    scrsz=get(0,'ScreenSize');
    nt=0;
    nrow=4;
%     mcol=6; %6 for 4s; %2 for 20s;
    if winlen<400
        mcol=6;
    else
        mcol=2;
    end
%     writeouts=0; %how many traces to write out?
    ninnin=nin
    %%% ifig -> the number count of the figures plotted
    for ifig=1:floor(nin/(nrow*mcol))+1
        figure('Position',[scrsz(3)/10 scrsz(4)/10 4*scrsz(3)/5 9*scrsz(4)/10]);
        fign(ifig)=gcf;
        if ifig > 5
            close(fign(ifig-5))
        end
        for n = 1:nrow
            for m = 1:mcol
                nt=nt+1;
                if nt <= nin %&& ismember(round(STA1file(winlen*(nt-1)+1)),displaytim) %For display, uncommment this and all "writeouts" lines
%                     if ismember(round(STA1file(winlen*(nt-1)+1)),displaytim) 
%                         writeouts=writeouts+1
%                     end
                     %if STA12file(nt,1) >= 10 && STA12file(nt,1) <= 16 && STA13file(nt,1) >= 2 && STA13file(nt,1) <= 8
                        
                        %% plot subfigures at 1st row (0*3+1), 4th row (1*3+1), (n-1)*3+1
                        subplot(3*nrow,mcol,3*(n-1)*mcol+m,'align');
                        %%% STA1file(*, 2) stores the seismogram of each window
                        yma=max(max([STA1file(winlen*(nt-1)+1:winlen*nt,2) STA2file(winlen*(nt-1)+1:winlen*nt,2) ...
                            STA3file(winlen*(nt-1)+1:winlen*nt,2)]));
                        ymi=min(min([STA1file(winlen*(nt-1)+1:winlen*nt,2) STA2file(winlen*(nt-1)+1:winlen*nt,2) ...
                            STA3file(winlen*(nt-1)+1:winlen*nt,2)]));
                        yma=2.4*max(yma,-ymi);
                        ymakeep=yma/2.4;
% Lines below plot + or - template:
%                         if match(nt,1) >= match(nt,2) %if positive cc with template is larger ...
%                             plot(timstemp((nt-1)*templen+1:nt*templen),STAtemps(whichtoplot,:)*yma/2.4,'c','linewidth',2)
%                         else %if cc with negative template is larger ...
%                             plot(timstempneg((nt-1)*templen+1:nt*templen),-STAtemps(whichtoplot,:)*yma/2.4,'m','linewidth',2)
%                         end
% Lines above plot + or - template:
                        hold on
                        %%% plot the seismogram at 3 stations of each win
                        plot(STA1file(winlen*(nt-1)+1:winlen*nt,1),STA1file(winlen*(nt-1)+1:winlen*nt,2),'r')
                        plot(STA2file(winlen*(nt-1)+1:winlen*nt,1),STA2file(winlen*(nt-1)+1:winlen*nt,2),'b')
                        plot(STA3file(winlen*(nt-1)+1:winlen*nt,1),STA3file(winlen*(nt-1)+1:winlen*nt,2),'k')
                        is = STA1file(winlen*(nt-1)+1,1);   % start time of each win
                        ien= STA1file(winlen*nt,1);         % end time of each win
                        axis([is ien -yma yma])
                        % plot amplitude scaling ?
                        xvect=[is is+2*(yma-ymi)*(winlen/160.)]; %*mean(scalefact)]; %amplitude bar originally scaled for 4-s window.  Not sure "mean" is necessary.
                        yvect=[-0.9*yma -0.9*yma];
                        plot(xvect,yvect,'r','linewidth',3)
                        % plot freq. band
                        plot([is+1/hi is+1/lo],[-0.8*yma -0.8*yma],'k','linewidth',3)
                        % STA32file(nt,3), 3rd col. -> idiff, /sps to time instead of samples
                        xcvect=[is+STA32file(nt,3)/sps is+(STA32file(nt,3)+cncntr)/sps];
                        ycvect=[0.95*yma 0.95*yma];
                        plot(xcvect,ycvect,'b','linewidth',3)
                        % plot Bostock's detections (in sec), red circle
                        plot(bostsec,0.93*yma,'ro','MarkerSize',4,'MarkerFaceColor','r')
                        % plot text of max cc coeff val
                        % match(1/2) -> max cc coeff between positive/negative template and the window with the main arrival, 2s win, 120 samples
                        text(is+STA32file(nt,3)/sps,  0.58*yma, num2str(match(nt,1),2),'fontsize',6,'color','b');
                        text(is+STA32file(nt,3)/sps, -0.75*yma, num2str(match(nt,2),2),'fontsize',6,'color','r');
                        % makes more sense now, because STA13file(nt,1) -> imaxSTA13wr, which stores the max cc shift of
                        % qualified window only, whose size is smaller than nwin
                        text(is+0.2, 0.66*yma, int2str(STA13file(nt,1)),'fontsize',6);
                        text(ien-0.6, 0.66*yma, int2str(STA12file(nt,1)),'fontsize',6);
                        
                        if n ==1 && m ==1
                            title([int2str(timoffrot(id,1)),'.',int2str(timoffrot(id,2)),'  p.',int2str(ifig)])
                        end
                        box on
                        set(gca,'XTick',[is (is+ien)/2],'fontsize',6);
                        
                        %% plot subfigures at 2nd row (0*3+2), 5th row (1*3+2), (n-1)*3+2
                        subplot(3*nrow,mcol,3*(n-1)*mcol+mcol+m,'align');
                        plot(STA1bbfile(winlen*(nt-1)+1:winlen*nt,1),STA1bbfile(winlen*(nt-1)+1:winlen*nt,2),'r')
                        hold on
                        plot(STA2bbfile(winlen*(nt-1)+1:winlen*nt,1),STA2bbfile(winlen*(nt-1)+1:winlen*nt,2),'b')
                        plot(STA3bbfile(winlen*(nt-1)+1:winlen*nt,1),STA3bbfile(winlen*(nt-1)+1:winlen*nt,2),'k')
                        is = STA1bbfile(winlen*(nt-1)+1,1);
                        ien= STA1bbfile(winlen*nt,1);
%                         yma=max(max([STA1bbfile(winlen*(nt-1)+1:winlen*nt,2) STA2bbfile(winlen*(nt-1)+1:winlen*nt,2) ...
%                             STA3bbfile(winlen*(nt-1)+1:winlen*nt,2)]));
%                         ymi=min(min([STA1bbfile(winlen*(nt-1)+1:winlen*nt,2) STA2bbfile(winlen*(nt-1)+1:winlen*nt,2) ...
%                             STA3bbfile(winlen*(nt-1)+1:winlen*nt,2)]));
%                         xvect=[is is+2*(yma-ymi)*(winlen/160.)]; %amplitude bar originally scaled for 4-s window
%                         yma=2.4*max(yma,-ymi);
%                         yvect=[-0.9*yma -0.9*yma];
%                         plot(xvect,yvect,'r','linewidth',3)
                        plot([is+1/hibb is+1/lobb],[-0.8*yma -0.8*yma],'k','linewidth',3)
                        text(is+0.2, 0.66*yma, int2str(STA13file(nt,1)),'fontsize',6);
                        text(ien-0.6, 0.66*yma, int2str(STA12file(nt,1)),'fontsize',6);
                        box on
                        axis([is ien -yma yma])
                        set(gca,'XTick',[is (is+ien)/2],'fontsize',6);

                    %% plot subfigures at 3rd row (0*3+3), 6th row (1*3+3), (n-1)*3+3
                    subplot(3*nrow,mcol,3*(n-1)*mcol+2*mcol+m,'align');
                    % plot dot product of 1 and 2, which is already shifted
                    STA12tr=STA1file(winlen*(nt-1)+1:winlen*nt,2).*STA2file(winlen*(nt-1)+1:winlen*nt,2);            
                    STA13tr=STA1file(winlen*(nt-1)+1:winlen*nt,2).*STA3file(winlen*(nt-1)+1:winlen*nt,2);
                    STA23tr=STA2file(winlen*(nt-1)+1:winlen*nt,2).*STA3file(winlen*(nt-1)+1:winlen*nt,2);
                    % find the peaks etc.
                    avedots=(STA12tr+STA13tr+STA23tr)/3.;
                    [peaks, locs]=findpeaks(avedots,'minpeakdistance',3);
                    npeaks=length(peaks);
                    [maxpk, imaxpk]=max(peaks);
                    pks=zeros(npeaks,2);
                    pks(:,2)=peaks;     % store peaks val in 2nd col.
                    pks(:,1)=STA1file(winlen*(nt-1)+locs);      % store global ind of loc in 1st col.
                    pksort=sortrows(pks,2);     % sort pks according to peaks val in ascending order 
                    rat14=maxpk/pksort(npeaks-4,2); %ratio of max to 4th largest anywhere in window, 5th instead of 4th???
                    if imaxpk==1 
                        maxpkp=peaks(2);
                        maxpkm=-9e9;
                        pkwid=2*(pks(2,1)-pks(1,1));
                        pksid12=maxpk/maxpkp;
                        pksid13=maxpk/peaks(3);
                    elseif imaxpk==npeaks
                        maxpkp=-9e9;
                        maxpkm=peaks(npeaks-1);
                        pkwid=2*(pks(npeaks,1)-pks(npeaks-1,1));
                        pksid12=maxpk/maxpkm;
                        pksid13=maxpk/peaks(npeaks-2);
                    else
                        maxpkp=peaks(imaxpk+1);
                        maxpkm=peaks(imaxpk-1);
                        pkwid=pks(imaxpk+1,1)-pks(imaxpk-1,1);
                        pksid12=maxpk/max(maxpkp,maxpkm);
                        pksid13=maxpk/min(maxpkp,maxpkm);
                    end
                    %%% cumsumSTA12tr is cum sum of dot product
                    cumsumSTA12tr=cumsum(STA12tr);
                    cumsumSTA13tr=cumsum(STA13tr);
                    cumsumSTA23tr=cumsum(STA23tr);
%                     yma=1.1; %yma=max(avedots);
%                     ymi=-0.1; %ymi=min(avedots);
% The following for running cc
                    cclen=20; %running cc window length, in samples, 0.5s
                    yma=max(max([cumsumSTA12tr cumsumSTA13tr cumsumSTA23tr]));   % here, yma & ymi are redefined
                    ymi=min(min([cumsumSTA12tr cumsumSTA13tr cumsumSTA23tr]));
                    %%% auto dot product, ST1auto can be compared to STA12tr
                    ST1auto=STA1file(winlen*(nt-1)+1:winlen*nt,2).*STA1file(winlen*(nt-1)+1:winlen*nt,2);
                    ST1sq=cumsum(ST1auto);  % cum sum of squre
                    ST2auto=STA2file(winlen*(nt-1)+1:winlen*nt,2).*STA2file(winlen*(nt-1)+1:winlen*nt,2);
                    ST2sq=cumsum(ST2auto);  % ST2sq can be compared with cumsumSTA12tr
                    ST3auto=STA3file(winlen*(nt-1)+1:winlen*nt,2).*STA3file(winlen*(nt-1)+1:winlen*nt,2);
                    ST3sq=cumsum(ST3auto);
                    ST12num=cumsumSTA12tr(cclen+1:winlen)-cumsumSTA12tr(1:winlen-cclen);  % length of cumsumSTA12tr is (winlen)
                    ST13num=cumsumSTA13tr(cclen+1:winlen)-cumsumSTA13tr(1:winlen-cclen);  % result in sum of square of cclen long
                    ST23num=cumsumSTA23tr(cclen+1:winlen)-cumsumSTA23tr(1:winlen-cclen);  % window from [2, cnlen+1]
                    ST1den=ST1sq(cclen+1:winlen)-ST1sq(1:winlen-cclen);
                    ST2den=ST2sq(cclen+1:winlen)-ST2sq(1:winlen-cclen);
                    ST3den=ST3sq(cclen+1:winlen)-ST3sq(1:winlen-cclen);
                    ST12n=ST12num./realsqrt(ST1den.*ST2den);
                    ST13n=ST13num./realsqrt(ST1den.*ST3den);
                    ST23n=ST23num./realsqrt(ST2den.*ST3den);  % length of alln, ST12n, ST1den, ST12num are (winlen-cclen)
                    alln=(ST12n+ST13n+ST23n)/3;   % alln --> [-1,1]  
                    alln(alln<0)=-10*yma;   %just so they don't plot. %% reassign those alln<0 to be larger then yaxis
                    %%idiff=STA32file(nt,3);
                    %%maxxc=max(alln(idiff:idiff+cclen)); %endpoints of alln window should be endpoints of 1 sec cumsum interval
                    plot(STA1file(winlen*(nt-1)+cclen/2+1:winlen*nt-cclen/2,1),(yma+ymi)/2+(yma-ymi)*alln/2,'co','markersize',1)
                    hold on
                    plot(STA1file(winlen*(nt-1)+1:winlen*nt,1), (yma+ymi)/2+zeros(winlen,1), 'k--');
                    %plot(STA1file(winlen*(nt-1)+cclen/2+1:winlen*nt-cclen/2,1),ST12n,'b')
                    %plot(STA1file(winlen*(nt-1)+cclen/2+1:winlen*nt-cclen/2,1),ST13n,'r')
                    %plot(STA1file(winlen*(nt-1)+cclen/2+1:winlen*nt-cclen/2,1),ST23n,'k')
                    %%plot(STA1file(winlen*(nt-1)+1:winlen*nt,1),0.75*maxxc*ones(winlen,1),'k:');
                    %%plot(STA1file(winlen*(nt-1)+1:winlen*nt,1),0.65*maxxc*ones(winlen,1),'k:');
% The above for running cc
% The following for running-sum dot product
                    plot(STA1file(winlen*(nt-1)+1:winlen*nt,1),cumsumSTA12tr,'k') %Use the color of the excluded station
                    hold on
                    plot(STA1file(winlen*(nt-1)+1:winlen*nt,1),cumsumSTA13tr,'b')
                    plot(STA1file(winlen*(nt-1)+1:winlen*nt,1),cumsumSTA23tr,'r')
%                     if ismember(round(STA1file(winlen*(nt-1)+1)),displaytim) 
%                         %%%%This is to write stuff
%                         i1=winlen*(nt-1)+1; i2=winlen*nt;
%                         cumsumSTA=cumsumSTA12tr+cumsumSTA13tr+cumsumSTA23tr;
%                         cumsumSTA=cumsumSTA/cumsumSTA(end);
%                         datfile(1:9,winlen*(writeouts-1)+1:winlen*writeouts)=[STA1file(i1:i2,1)';
%                                                                               STA1file(i1:i2,2)';
%                                                                               STA2file(i1:i2,2)';
%                                                                               STA3file(i1:i2,2)';
%                                                                               STA1bbfile(i1:i2,2)';
%                                                                               STA2bbfile(i1:i2,2)';
%                                                                               STA3bbfile(i1:i2,2)';
%                                                                               cumsumSTA';
%                                                                               -99*ones(1,winlen)];
%                         datfile(9,winlen*(writeouts-1)+1+cclen/2:winlen*writeouts-cclen/2)=(ST12n+ST13n+ST23n)/3;
%                         guidefile(writeouts,:)=[writeouts STA1file(i1,1) ymakeep];
%                         %%%%That was to write stuff
%                     end
                    axis([is ien ymi yma])
                    set(gca,'XTick',[is (is+ien)/2],'fontsize',6);
%                     set(gca,'XTick',(0:20),'fontsize',6);
% The above for running-sum dot product
                    box on
                    %%% text from up to down is max cc coeff of 13, 12, 32
                    %%% text from right to left is normalized cumsumtrdiff of 32, 80 percentiles of data 3, data 2
                    text(is+0.1, ymi+0.82*(yma-ymi), num2str(STA13file(nt,2),2),'fontsize',6);
                    text(is+0.1, ymi+0.64*(yma-ymi), num2str(STA12file(nt,2),2),'fontsize',6);
                    text(is+0.1, ymi+0.46*(yma-ymi), num2str(STA32file(nt,2),2),'fontsize',6);
                    text(ien-0.6, ymi+0.1*(yma-ymi), num2str(STA32file(nt,1),2),'fontsize',6);
                    text(ien-2.2, ymi+0.1*(yma-ymi), num2str(STAamp(nt,2),2),'fontsize',6);
                    text(ien-1.4, ymi+0.1*(yma-ymi), num2str(STAamp(nt,3),2),'fontsize',6);
                    %axis([lo-1 hi+1 ymi yma])
                    %axis tight
                    %set(gca,'XTick',[is is+2],'fontsize',6);
%                     pkfile(nt,:)=[STA1file(winlen*(nt-1)+1+(winlen/2)) pks(imaxpk,1) maxpk pksid12 pksid13 pkwid rat14];
                    %%% pkfile:  time   index of maxpk     maxpk val
                    %%% pksid12=maxpk/max(maxpkp,maxpkm)    pksid13=maxpk/min(maxpkp,maxpkm) 
                    %%% pkwid=pks(imaxpk+1,1)-pks(imaxpk-1,1)   rat14=maxpk/pksort(npeaks-4,2)
                    pkfile(nt,:)=[STA1file(winlen*(nt-1)+1+(winlen/2), 1) pks(imaxpk,1) maxpk pksid12 pksid13 pkwid rat14];
                end
            end
        end
        drawnow
        orient landscape
        if ifig <= 9
            %%% Should use num2str(winlen/sps) instead of int2str ??
            %%% use 'depsc2', 'r600'
%             print('-depsc',['ARMMAP/WIGS/2018Sep/',IDENTIF,'-',num2str(lo),'-',num2str(hi),'ms',int2str(mshift),'-',int2str(winlen/sps),'s','.',int2str(0),int2str(0),int2str(ifig),'.eps'])
            print('-depsc', [workpath,'/LZBtrio/WIGS/',IDENTIF,'_',num2str(lo),'-',num2str(hi),'_',num2str(winlen/sps),'s_',num2str(sps),'sps','.',int2str(0),int2str(0),int2str(ifig),'.eps'])
        elseif ifig <= 99
%             print('-depsc',['ARMMAP/WIGS/2018Sep/',IDENTIF,'-',num2str(lo),'-',num2str(hi),'ms',int2str(mshift),'-',int2str(winlen/sps),'s','.',int2str(0),int2str(ifig),'.eps'])
            print('-depsc', [workpath,'/LZBtrio/WIGS/',IDENTIF,'_',num2str(lo),'-',num2str(hi),'_',num2str(winlen/sps),'s_',num2str(sps),'sps','.',int2str(0),int2str(ifig),'.eps'])
        else
%             print('-depsc',['ARMMAP/WIGS/2018Sep/',IDENTIF,'-',num2str(lo),'-',num2str(hi),'ms',int2str(mshift),'-',int2str(winlen/sps),'s','.',int2str(ifig),'.eps'])
            print('-depsc', [workpath,'/LZBtrio/WIGS/',IDENTIF,'_',num2str(lo),'-',num2str(hi),'_',num2str(winlen/sps),'s_',num2str(sps),'sps','.',int2str(ifig),'.eps'])
        end
        
    end
    %fid = fopen(['ARMMAP/MAPS/pks',IDENTIF,'_',num2str(lo),'-',num2str(hi),'-','ms',int2str(mshift),'-',int2str(winlen/40),'s'],'w');
%     fid = fopen(['ARMMAP/MAPS/2018/pks',IDENTIF,'_',num2str(lo),'-',num2str(hi),'-','ms',int2str(mshift),'-',int2str(winlen/sps),'s'],'w');
%     fprintf(fid,'%9.1f %9.3f %10.6f %9.3f %9.3f %9.3f %9.3f \n',pkfile(1:nin,:)');
%     fclose(fid);

%     bostsecfile(1,:)=bostsec;
%     bostsecfile(2,:)=1;    
%     fid = fopen(['ARMMAP/WIGS/2018Sep/bostsec',IDENTIF(1:8)],'w');
%     fprintf(fid,'%10.3f %12.4e \n',bostsecfile(:,:));
%     fclose(fid);
%     fid = fopen(['ARMMAP/WIGS/2018Sep/wigdat',IDENTIF,'_',num2str(lo),'-',num2str(hi),'-','ms',int2str(mshift),'-',int2str(winlen/40),'s'],'w');
%     fprintf(fid,'%10.3f %12.4e %12.4e %12.4e %12.4e %12.4e %12.4e %12.4e %12.4e \n',datfile(:,:));
%     fclose(fid);
%     fid = fopen(['ARMMAP/WIGS/2018Sep/guide',IDENTIF,'_',num2str(lo),'-',num2str(hi),'-','ms',int2str(mshift),'-',int2str(winlen/40),'s'],'w');
%     fprintf(fid,'%4i %10.3f %12.4e \n',guidefile');
%     fclose(fid);
%     clear datfile
%     clear bostsecfile
%     clear guidefile
    %end %(if winlen>500)
end

medlok=median(abs(loopoffkeep))     % median is actually effective to the 2nd column, which is loopoff
medaSTA12=median(aSTA12keep)        % 2nd column is aSTA12, which results from PARABOLIC FIT
medaSTA13=median(aSTA13keep)
medaSTA32=median(aSTA32keep)


%cputime-t;
%tot=cputime-tt
%end %(from "if winlen < 500")


