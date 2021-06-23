%% this function of mask generation is borrowed from ADTrack
function m = mask_generation(I, target_sz)

    ratio = 0.75;
    D = im2double(I);
    Ir = single(D(:,:,1)); Ig=single(D(:,:,2)); Ib=single(D(:,:,3));
    Lw = get_illuminance(I);
    % Lw = im2double(I);
    % % % the maximum luminance value
    Lwmax = max(max(Lw));
    [m, n] = size(Lw);%[]æÿ’Û±Ì æ
    % % % log-average luminance
    Lwaver = exp(sum(sum(log(0.001 + Lw))) / (m * n));
    Lg = log(Lw / Lwaver + 1) / log(Lwmax / Lwaver + 1);
    gain = Lg ./ Lw;
    gain(find(Lw == 0)) = 0;
    II = cat(3, gain .* Ir, gain .* Ig, gain .* Ib);
    delta=get_illuminance(II-D);
    m=im2single(create_map(delta, target_sz, ratio));

end