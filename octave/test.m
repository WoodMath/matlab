

x=[1:3];
y=3*x+2;
y=y+stdnormal_cdf(rand(size(y,1),size(y,2)))/100;
a=[x;y];
[u,e,v]=svd(a);

[vecu,valu]=eig(a*a');
[vecv,valv]=eig(a'*a);
vecu=fliplr(vecu);
valu=rot90(rot90(valu));
valu=valu.^.5;

vecv=fliplr(vecv);
#vecv=vecv';
valv=rot90(rot90(valv));
valv=valv.^.5;
#valv=real(valv);
r=100000000;
valv=roundb(valv*r)/r;

mate=cat(2,valu,zeros(size(valu,1),size(valv,2)-size(valu,2)));

vecu*mate*vecv'
%vec=real(vec)
%val=real(val)
