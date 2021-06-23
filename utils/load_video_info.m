function [seq, ground_truth] = load_video_info(video,base_path,video_path)

    ground_truth = dlmread([base_path '/' video '.txt']);

    seq.len = size(ground_truth, 1);
    seq.init_rect = ground_truth(1,:);
    img_path = [video_path '/'];  

    img_files = dir(fullfile(img_path, '*.jpg'));
    % img_files = img_files(4:end);
    img_files = {img_files.name};
    seq.s_frames = cellstr(img_files);

end

