clear all
close all
rng(0)
clcarr=jet(255);
red=clcarr(end,:);
blue=clcarr(1,:);
tmin=0; tmax=6;
fmin=0; fmax=12000;
randrange=@(x1,x2) x1+(x2-x1)*rand();
normT=@(x) mynorm(x,tmin,tmax);
normF=@(x) mynorm(x,fmin,fmax);
nfile=1;
%nfile=1000;
for ifile=1:nfile
    

hf=figure(1);
clf
setfigpos(gcf, [1  1 6 6])
fill([tmin tmin tmax tmax tmin],[fmin fmax fmax fmin fmin],blue,'LineStyle','none')
%hold on
	  o=[];
	  barr=[];
      %bnarr=[]; 
	  for iwave=1:10
            D1=randrange(5,20); % dispersion s/sqrt(Hz)
            %D1=5
		    t1=0.1+(iwave-1)*0.5;
		    f1=randrange(2000,10000);
            t2=t1+randrange(0.4,1);
            t0=t1-D1/sqrt(f1);
            % t=D/sqrt(f)+t0
            % f=(D/(t-t0))^2
		    f2=(D1/(t2-t0)).^2;
            tarr=linspace(t1,t2,101);
            farr=(D1./(tarr-t0)).^2;
            
          

            hold on
            plot(tarr,farr,'color',red,'LineWidth',5);
            
            dtbnd=0.08;
            
            ind=[1:5:length(tarr)];
            
            tbnd=[tarr(ind)-dtbnd/2,fliplr(tarr(ind)+dtbnd/2)];
            fbnd=[farr(ind),fliplr(farr(ind))];
            barr{iwave}={tbnd,fbnd};
            %bnarr{iwave}={normT(tbnd),normF(fbnd)};

            polygon_point=[normT(tbnd),normF(fbnd)];
            o=[o;polygon_point];

           
            %plot(t1,f1,'m*')
            %plot(t2,f2,'mo')


	  end % iwave

	  axis off
	  xlim([tmin,tmax])
	  ylim([fmin,fmax])


	  %pngfile='test_box.png'
	  thisfile=num2str(ifile,'LGW/LGW_%5.5d');
	  if nfile==1
	  pngfile='test_LGW.png'
	  txtfile='test_LGW.txt'
	  boxpngfile='test_LGW_box.png'
	  else

	  pngfile=[thisfile,'_LGW.png'];
	  txtfile=[thisfile,'_LGW.txt'];
	  boxpngfile=[thisfile,'_LGW_box.png'];
	  end


	  save(txtfile,'o','-ascii')
	  saveeps(pngfile)
	  %return
      
	  rgb = imread(pngfile);
	  rgbm = RemoveWhiteSpace(rgb);
	  imwrite(rgbm,pngfile);

	  if nfile>1
		    continue
	  end
        % set(gcf,'units','pixels','position',[500,500,512,512]);
      %return
	  % generate figure with box
	  for iwave=1:length(barr)
		    %plot(barr{ichorus}([1 1 3 3 1]),barr{ichorus}([2 4 4 2 2 ]),'-w');
            plot(barr{iwave}{1}([1:end,1]),barr{iwave}{2}([1:end,1]),'-w','LineWidth',1);
	  end
	  saveeps(boxpngfile)
	  rgb = imread(boxpngfile);
	  rgbm = RemoveWhiteSpace(rgb);
	  imwrite(rgbm,boxpngfile);


end % ifile
