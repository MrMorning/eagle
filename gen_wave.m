function y = gen_wave(tone, rhythm)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
    Fs = 44100;
    rhythm = rhythm * 0.5;
    freqs = [0, 523, 587, 659, 698, 783, 880, 988, 1046];
    x = linspace(0, 2 * pi * rhythm, floor(Fs * rhythm));
    if(tone > 0)
        if(tone <= 7)
            y = sin(freqs(tone+1) * x) .* (1 - x / (2 * pi * rhythm));
        else
            if(mod(tone, 7) == 0)
                y = sin(freqs(7+1) * 2 ^ floor(tone / 7) * x) .* (1 - x / (2 * pi * rhythm));
            else
                y = sin(freqs(mod(tone, 7)+1) * 2 ^ floor(tone / 7) * x) .* (1 - x / (2 * pi * rhythm));
            end
        end
    elseif(tone < 0)
        tone = -1 * tone;
        if(mod(tone, 7) == 0)
            y = sin(freqs(7+1) * 0.5 ^ floor(tone / 7) * x) .* (1 - x / (2 * pi * rhythm));
        else 
            y = sin(freqs(mod(tone, 7)+1) * 0.5 * 0.5 ^ floor(tone / 7) * x) .* (1 - x / (2 * pi * rhythm));
        end
    else
        y = 0 * x;
    end
end

