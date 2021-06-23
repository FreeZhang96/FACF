%   This script runs the implementation of FACF, which is borrowed from
%   BACF.

clear; 
clc;
close all;
setup_paths;

%   Load video information
% base_path  = 'F:/tracking/datasets/UAVTrack112';

base_path = './seq';
video      = 'air conditioning box1';
video_path = [base_path '/' video];
[seq, ground_truth] = load_video_info(video,base_path,video_path);
seq.path = video_path;
seq.name = video;
seq.startFrame = 1;
seq.endFrame = seq.len;

gt_boxes = [ground_truth(:,1:2), ground_truth(:,1:2) + ground_truth(:,3:4) - ones(size(ground_truth,1), 2)]; 

%   Run FACF
results       = run_FACF(seq);

%   compute the OP
pd_boxes = results.res;
pd_boxes = [pd_boxes(:,1:2), pd_boxes(:,1:2) + pd_boxes(:,3:4) - ones(size(pd_boxes,1), 2)  ];
OP = zeros(size(gt_boxes,1),1);
for i=1:size(gt_boxes,1)
    b_gt = gt_boxes(i,:);
    b_pd = pd_boxes(i,:);
    OP(i) = computePascalScore(b_gt,b_pd);
end
OP_vid = sum(OP >= 0.5) / numel(OP);
FPS_vid = results.fps;
display([video  '---->' '   FPS:   ' num2str(FPS_vid)   '    op:   '   num2str(OP_vid)]);