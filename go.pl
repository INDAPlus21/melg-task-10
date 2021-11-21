% Taken and modified from https://gist.github.com/MuffinTheMan/7806903
% Get an element from a 2-dimensional list at (Row,Column)
% using 1-based indexing.
nth1_2d(Row, Column, List, Element) :-
    nth1(Row, List, SubList),
    nth1(Column, SubList, Element).

% Top-level predicate
alive(Row, Column, BoardFileName):-
    see(BoardFileName),     % Loads the input-file
    read(Board),            % Reads the first Prolog-term from the file
    seen,                   % Closes the io-stream
    nth1_2d(Row, Column, Board, Stone),
    not(Stone = e),
    rec(Row, Column, Board, Stone, []).

% Outside board
rec(0, _, _, _, _):-
    false, !.
rec(10, _, _, _, _):-
    false, !.
rec(_, 0, _, _, _):-
    false, !.
rec(_, 10, _, _, _):-
    false, !.

% Found empty
rec(Row, Column, Board, OriginalStone, Visited):-
    nth1_2d(Row, Column, Board, Stone),
    Stone = e, !.

% Main recursion
rec(Row, Column, Board, OriginalStone, Visited):-
    not(member([Row, Column], Visited)),
    nth1_2d(Row, Column, Board, Stone), % Get stone at position
    write(Row),
    write(Column),
    (Stone = OriginalStone), 
    NewRow is Row - 1,
    NewRow2 is Row + 1,
    NewColumn is Column - 1,
    NewColumn2 is Column + 1,
    rec(NewRow, Column, Board, OriginalStone, [[Row, Column]|Visited]);    
    rec(NewRow2, Column, Board, OriginalStone, [[Row, Column]|Visited]);
    rec(Row, NewColumn, Board, OriginalStone, [[Row, Column]|Visited]);
    rec(Row, NewColumn2, Board, OriginalStone, [[Row, Column]|Visited]).
