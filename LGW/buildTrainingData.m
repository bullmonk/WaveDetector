function [hf,encl_pts] =  buildTrainingData(nfile)

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
        hf=figure(1);
        clf;
        setfigpos(gcf, [1  1 6 6]);
        fill([tmin tmin tmax tmax tmin],[fmin fmax fmax fmin fmin],blue,'LineStyle','none');
        encl_pts=[];
        barr=[];
        % draw shapes
        for j = 1:10
            D1=randrange(5,20);
            t1=0.1+(j-1)*0.5;
            f1=randrange(2000,10000);
            t2=t1+randrange(0.4,1);
            t0=t1-D1/sqrt(f1);
            f2=(D1/(t2-t0)).^2;
            tarr=linspace(t1,t2,101);
            farr=(D1./(tarr-t0)).^2;
            hold on
            plot(tarr,farr,'color',red,'LineWidth',5);
            dtbnd=0.08;
            ind=1:5:length(tarr);
            tbnd=[tarr(ind)-dtbnd/2,fliplr(tarr(ind)+dtbnd/2)];
            fbnd=[farr(ind),fliplr(farr(ind))];
            barr{j}={tbnd,fbnd};
            polygon_point=[normT(tbnd),normF(fbnd)];
            encl_pts=[encl_pts;polygon_point];
        end

        axis off
        xlim([tmin, tmax]);
        ylim([fmin, fmax]);

        thisfile=num2str(i,'LGW/LGW_%5.5d');
        pngfile=[thisfile,'_LGW.png'];
        saveeps(pngfile);

        txtfile=[thisfile,'_LGW.txt'];
        save(txtfile,'encl_pts','-ascii');


        rgb = imread(pngfile);
        rgbm = RemoveWhiteSpace(rgb);
        imwrite(rgbm,pngfile);

        if nfile>1
            continue
        end

        for k=1:length(barr)
            plot(barr{k}{1}([1:end,1]),barr{k}{2}([1:end,1]),'-w','LineWidth',1);
        end
        boxpngfile=[thisfile,'_LGW_box.png'];
        saveeps(boxpngfile)
        rgb = imread(boxpngfile);
        rgbm = RemoveWhiteSpace(rgb);
        imwrite(rgbm,boxpngfile);

    end
    % close all;
end