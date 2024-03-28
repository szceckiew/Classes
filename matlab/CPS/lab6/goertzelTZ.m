
function [y] = goertzelTZ(data, freq_index)
    
    % data - data to transform
    % freq_index - indices of freq. stripes for given length
    

    % Initialization
    lx = length(data);
    x = reshape(data,lx,1); %forcing x to be column
    
    no_freq = length(freq_index); % Number of stripes
    y = zeros(no_freq, 1); % memory for information about stripes
    
    %% Computation loop  - Goertzel algorithm
    
    for curr_freq = 1:no_freq
        
        % Calculation for a single stripe
        pik_term = 2*pi*(freq_index(curr_freq))/(lx);
        cos_term = 2*cos(pik_term);
        W = exp(-1i*pik_term);
        % Iteration variables
        s0 = 0;
        s1 = 0;
        s2 = 0;
        % Main loop - N calculations
        for idx = 1:lx
            s0 = x(idx) + cos_term*s1 - s2;
            % Shifting states
            s2 = s1;
            s1 = s0;
        end
        
        % Final calculation
        s0 = cos_term*s1 - s2;
        y(curr_freq) = s0 - s1*W;
    end
end