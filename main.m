image1 = imread('aceeeagle3.png');
image2 = imread('aceeeagle2.png');
tone = [1, 2, 3, 2, 1, 2, 5, 1, -7, 1, 4, 3];
rhythms = [1, 1, 2, 1, 1, 1, 3, 1, 0.5, 1, 1, 2];
y = [];
for i = 1:12
    yx = gen_wave(tone(i), rhythms(i));
    y = cat(2, y, yx);
end
flag = 0;
video = VideoWriter('myvideo.avi');
open(video);
for i = 1:12
    rep = tone(i) + 1;
    if(tone(i) < 0)
        rep = 1;
    end
    totalframe = 0.5 * rhythms(i) * 30;
    eachframe = floor(10 / rep);
    flag = 0;
    for i = 1:totalframe
        if(flag == 0)
            writeVideo(video, image1);
        else
            writeVideo(video, image2);
        end
        if(mod(i, eachframe) == 0)
            if(flag == 0)
                flag = 1;
            else
                flag = 0;
            end
        end
    end
end
close(video);
audiowrite('mymusic.wav', y, 44100);
implay('myvideo.avi')
