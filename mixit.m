function output = mixit(tracks, weights)

% Function written by Eleni Christoforidou in MATLAB R2022b.

% Consider a multi-track audio recording: a uint16 matrix of N columns 
% where each column represents one track, e.g., the recording of one 
% instrument of a band playing a song. The input range is between 0 and 
% 65535, a value that a 16-bit analog digital converter would provide. This
% function takes the tracks and generates a weighted sum of them. 
% The first input argument is a K-by-N matrix of uint16 values where N is 
% the number of tracks and K is the number of samples per track. The second
% input argument is a vector of N double scalars representing the weights 
% of the tracks. The output of the function is a K-element column vector of
% doubles representing a single-track audio recording obtained by mixing 
% the individual tracks according to the static weights. Note that before 
% any of the processing takes place, the audio data is be converted to 
% standard interval of [-1 1]. That is, uint16 0 is mapped to -1, while 
% 65535 becomes +1. The output is in the same range. If any element of the 
% final mixed audio is outside of this range, the output is scaled.

% Convert input data to the standard interval of [-1, 1]
tracks = double(tracks) / 32768 - 1;
% Multiply each track by its corresponding weight
weighted_tracks = bsxfun(@times, tracks, weights);
% Sum the weighted tracks to get the mixed audio
mixed_audio = sum(weighted_tracks, 2);
% Scale the mixed audio if any element is outside of the range [-1, 1]
max_val = max(mixed_audio);
min_val = min(mixed_audio);
if max_val > 1 || min_val < -1
    output = mixed_audio / max(abs([max_val min_val]));
else
    output = mixed_audio;
end
end