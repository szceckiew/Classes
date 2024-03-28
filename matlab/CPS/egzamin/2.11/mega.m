clear all; close all;
dur = 0.3*8192;
Fs = 8192;
notecreate = @(frq,dur) [sin(2*pi* [1:dur]/8192 * (440*2.^((frq-1)/12))), zeros(1,75)];

notename = {'A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#'};

song = {{'D'} {'D'} {'D'} {'A'} {'G#'} {'G'} {'F'} {'D'} {'F'} {'G'} {'C'} {'C'} {'D'} {'A'} {'G#'} {'G'} {'F'} {'D'} {'F'} {'G'} {'H'} {'H'} ...
    {'D'} {'A'} {'G#'} {'G'} {'F'} {'D'} {'F'} {'G'}...
    {'A#'} {'A#'} {'D'} {'A'} {'G#'} {'G'} {'F'} {'D'} {'F'} {'G'}};

songidx = cellfun(@(Notes) cell2mat(cellfun(@(Note) find(strcmp(Note, notename)), Notes, 'uniform', 0)), song,'uniform',0 );

songnotes = cellfun(@(NoteIdxs) sum(cell2mat(arrayfun(@(NoteIdx) notecreate(NoteIdx, dur), NoteIdxs(:), 'uniform', 0)),1), songidx, 'uniform', 0);

songnote = [songnotes{:}];

sound(songnote, Fs)


