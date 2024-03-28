clear all; close all;
dur = 0.3*8192;
Fs = 8192;
notecreate = @(frq,dur) [sin(2*pi* [1:dur]/8192 * (440*2.^((frq-1)/12))), zeros(1,75)];

notename = {'A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#'};

%song = {{'A'} {'A'} {'E' 'D#'} {'E' 'D'} {'A' 'F#'} {'A#' 'F#'} {'E' 'C'} {'E' 'C' 'A'} {'D'} {'D' 'D#'} {'C#' 'G'} {'C' 'G#'} {'B'} {'B' 'B#'} {'A' 'A#'} {'A' 'A#'}};
song = {{'A'} {'F'} {'A'} {'F'} {'A'} {'F'} ...
        {'B'} {'B'} {'G'} {'G'} {'B'} {'B'} {'G'} {'G'} {'B'} {'B'} {'G'} {'G'} ...
        {'A'} {'F'} {'A'} {'F'} {'A'} {'F'}...
        {'G#'} {'G'} {'F'} {'D'} {'F'} {'G'}};

songidx = cellfun(@(Notes) cell2mat(cellfun(@(Note) find(strcmp(Note, notename)), Notes, 'uniform', 0)), song,'uniform',0 );

songnotes = cellfun(@(NoteIdxs) sum(cell2mat(arrayfun(@(NoteIdx) notecreate(NoteIdx, dur), NoteIdxs(:), 'uniform', 0)),1), songidx, 'uniform', 0);

songnote = [songnotes{:}];

sound(songnote, Fs)

