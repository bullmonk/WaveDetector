
figure(1)
clf
setfigpos(gcf,[1 1 3 3])
rng(0)
% triangles
n=2; nside=3;
x=zeros(nside,n);
y=zeros(nside,n);
x(:,1)=rand(nside,1)*0.5;
y(:,1)=rand(nside,1)*0.5;
x(:,2)=rand(nside,1)*0.5+0.5;
y(:,2)=rand(nside,1)*0.5+0.5;
for i=1:n
    hold on
    %plot(x([1:nside,1],i),y([1:nside,1],i),'r')
    fill(x([1:nside,1],i),y([1:nside,1],i),'r')
end



axis off
saveeps('test_shape.png')