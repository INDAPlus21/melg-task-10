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
    nth1_2d(Row, Column, Board, OriginalStone),
    write(OriginalStone),
    OriginalStone = e -> false ;
    write(OriginalStone),
    rec(Row, Column, Board, OriginalStone, []).

% Main recursion
rec(Row, Column, Board, OriginalStone, Visited):-
    write(recursion),
    Row = 0 -> false ;
    Row = 10 -> false ;
    Column = 0 -> false ;
    Column = 10 -> false ;
    %member([Row, Column], Visited) -> false ;
    nth1_2d(Row, Column, Board, Stone), % Get stone at position
    nth1_2d(Row, Column, Board, Stone2),
    write(Stone),
    write(Stone2),
    write(Row),
    write(Column),
    Stone =:= e -> true ;
    Stone \= OriginalStone -> false ; 
    %\+ member([Row, Column], Visited) -> % Return false if already visited
    NewRow is Row - 1,
    rec(NewRow, Column, Board, OriginalStone, [[Row, Column]|Visited]);
    NewRow2 is Row + 1,
    rec(NewRow2, Column, Board, OriginalStone, [[Row, Column]|Visited]).
    %rec(Row, Column - 1, _, NewVisited),
    %rec(Row, Column + 1, _, NewVisited).
