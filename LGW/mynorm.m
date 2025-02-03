function y=mynorm(x,xmin,xmax)

    y=(x-xmin)/(xmax-xmin);
    y(y>1)=1;
    y(y<0)=0;
end