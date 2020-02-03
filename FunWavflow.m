% w->windows: Ö¡³¤
% d->delta: ÒÆ¶¯´°

function FunWavflow(filename,t1,t2) 

error(nargchk(2, 3, nargin, 'struct'));

[y fs]=audioread(filename);

pt = (length(y)-1)/fs;

if nargin == 2;
    t2 = pt;
end

t = [t1 t2];

if length(t)~=2 | t(1) < 0 | t(2) > pt
    error('01 - play time.');
    return;
end

l1 = t(1)*fs+1;
l2 = t(2)*fs+1;

if size(y,2) == 2
    y = mean(y(l1:l2,:)');
else
    y = y(l1:l2)';
end

l = l2-l1+1;

w = 2*fs;

if l <= w
    error('02 - short length.')
    return;
end    

k = floor(1.5e7/(fs*(t2-t1)));
d = floor(w/k);

n = ceil((l-w)/d)+1;
if w+(n-1)*d > l
    y = [y zeros(1,w+(n-1)*d+1-l)];
end

for i = 1:n
    pw(i,:) = y((i-1)*d+1:w+(i-1)*d);
    td(i,:) = t(1)+(i-1)*d/fs+[0:w-1]/fs;
end

figure
lim = max(y(:));

sound(y,fs)
pause(w/fs)

ts = datetime('now');
for i = 1:n    
    
    subplot(2,1,1)
    plot(t(1)+[0:length(y)-1]/fs,y,'k-')
    hold on,plot(td(i,:),pw(i,:),'r-')
    set(gca,'ylim',[-lim lim],'xlim',[max(t(1)-2,0),t(2)+2])
    grid on;
    
    subplot(2,1,2)
    plot(td(i,:),pw(i,:),'k-');
    set(gca,'ylim',[-lim lim],'xlim',[td(i,1) td(i,end)])
    grid on;
    
    tp = seconds(datetime('now')-ts)+t(1);
    
    pause(td(i,1)-tp)
    drawnow;
end