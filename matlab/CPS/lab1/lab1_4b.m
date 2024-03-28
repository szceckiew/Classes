% Wczytanie sygnałów
real_signal = readtable('DAB_real_2.048MHz_IQ_float.dat');
synthetic_signal = readtable('DAB_synt_2.048MHz_IQ_float.dat');

% Wyznaczenie sygnału PhaseReference Symbol
sigPhaseRefSymb = PhaseRefSymbGen(1);

% Wyszukanie miejsca wystąpienia PhaseReference Symbol w sygnale rzeczywistym
corr_signal = xcorr(real_signal, sigPhaseRefSymb);
[~, max_corr_idx] = max(abs(corr_signal));
phase_ref_start_idx = max_corr_idx - length(real_signal) + 1;

% Wyznaczenie początku sekwencji 76 bloków
null_symbol_energy = sum(abs(sigPhaseRefSymb).^2) / length(sigPhaseRefSymb);
block_energy = zeros(76, 1);
for i = 1:76
    block_energy(i) = sum(abs(real_signal(phase_ref_start_idx + (i-1)*2552 + 2657 : phase_ref_start_idx + i*2552)).^2) / 2552;
end
[block_start_energy, block_start_idx] = min(block_energy);
block_start_idx = phase_ref_start_idx + (block_start_idx - 1) * 2552;

% Sprawdzenie, czy pierwsze i ostatnie 504 próbki kolejnych 76 bloków są identyczne
block_end_idx = block_start_idx + 2551;
for i = 1:75
    next_block_start_idx = block_start_idx + 2552;
    next_block_end_idx = next_block_start_idx + 2551;
    corr = xcorr(real_signal(block_end_idx - 503 : block_end_idx), real_signal(next_block_start_idx : next_block_start_idx + 503));
    [~, max_corr] = max(abs(corr));
    if max_corr ~= 1008
        error('Blocks are not identical');
    end
    block_start_idx = next_block_start_idx;
    block_end_idx = next_block_end_idx;
end
