function [labels] =  buildTrainingData(nfile, imageFolder, labelFolder)

    % initialization
    rng(0)
    clcarr=jet(255);
    red=clcarr(end,:);
    blue=clcarr(1,:);
    
    % helper functions
    randrange=@(x1,x2) x1+(x2-x1)*rand();
    
    tmin=0; tmax=6;
    normT=@(x) mynorm(x,tmin,tmax);
    
    fmin=0; fmax=12000;
    normF=@(x) mynorm(x,fmin,fmax);
    
    for i=1:nfile

        % create figure
        figure(1);
        clf;
        setfigpos(gcf, [1  1 6 6]);
        fill([tmin tmin tmax tmax tmin],[fmin fmax fmax fmin fmin],blue,'LineStyle','none');
        % barr=[];
        labels = zeros(10, 89);
        % draw shapes
        for j = 1:10 % adjust this number to change number of shapes
            D1=randrange(5,20);
            t1=0.1+(j-1)*0.5; % adjust this number to change space
            f1=randrange(2000,10000);
            t2=t1+randrange(0.4,1);
            t0=t1-D1/sqrt(f1);
            % f2=(D1/(t2-t0)).^2;
            tarr=linspace(t1,t2,101);
            farr=(D1./(tarr-t0)).^2;
            hold on
            plot(tarr,farr,'color',red,'LineWidth',5);
            dtbnd=0.08;
            ind=1:5:length(tarr);
            tbnd=[tarr(ind)-dtbnd/2,fliplr(tarr(ind)+dtbnd/2)];
            fbnd=[farr(ind),fliplr(farr(ind))];
            % barr{j}={tbnd,fbnd};

            x = normT(tbnd);
            y = 1-normF(fbnd);
            pts = reshape([x;y], 1, []);
            cx = (min(x) + max(x))/2;
            cy = (min(y) + max(y))/2;
            width = (max(x) - min(x));
            height = (max(y) - min(y));
            labels(j,:) = [0, cx, cy, width, height, pts];
        end
        tbl = array2table(labels);

        axis off
        xlim([tmin, tmax]);
        ylim([fmin, fmax]);


        thisfile=num2str(i,'LGW_%5.5d');

        pngfile=fullfile(imageFolder, [thisfile '.png']);
        saveeps(pngfile);
        rgb = imread(pngfile);
        rgbm = RemoveWhiteSpace(rgb);
        imwrite(rgbm,pngfile);

        txtfile=fullfile(labelFolder, [thisfile '.txt']);
        writetable(tbl, txtfile, 'Delimiter', ' ', 'WriteVariableNames', false);

    end
    close all;
end