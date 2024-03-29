% Digital Image Processing : Lab Task - 6
% Student: BT20ECE027(AMIT YADAV)
% Professor: Dr. Tapan Jain
% Date: 20 Feb 2023

probability = [0.4, 0.3, 0.2, 0.1];
[code, codelength, efficiency] = shannon_fano(probability)

function [code, codelength, efficiency] = shannon_fano(probability)
p = probability(:);
[sorted_p, sorted_idx] = sort(p, 'descend');


total_p = sum(p);
subset_p = 0;
idx = 1;
while subset_p < total_p/2
    subset_p = subset_p + sorted_p(idx);
    idx = idx + 1;
end
subset1_idx = sorted_idx(1:idx-1);
subset2_idx = sorted_idx(idx:end);


if length(subset1_idx) > 1
    [subset1_code, subset1_codelength, subset1_efficiency] = shannon_fano(p(subset1_idx));
    for i = 1:length(subset1_code)
        subset1_code{i} = [false, subset1_code{i}];
    end
else
    subset1_code = {false};
    subset1_codelength = 1;
    subset1_efficiency = 1;
end
if length(subset2_idx) > 1
    [subset2_code, subset2_codelength, subset2_efficiency] = shannon_fano(p(subset2_idx));
    for i = 1:length(subset2_code)
        subset2_code{i} = [true, subset2_code{i}];
    end
else
    subset2_code = {true};
    subset2_codelength = 1;
    subset2_efficiency = 1;
end


codebook = cell(length(p), 1);
for i = 1:length(subset1_idx)
    codebook{subset1_idx(i)} = subset1_code{i};
end
for i = 1:length(subset2_idx)
    codebook{subset2_idx(i)} = subset2_code{i};
end


code = codebook(sorted_idx);

codelength = cellfun(@length, code);
avg_codelength = dot(p, codelength);
entropy = -dot(p, log2(p));
efficiency = entropy / avg_codelength;
end
