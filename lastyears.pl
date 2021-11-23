% Sequence
sequence(From, To, List):-
    sequence2(From, To, [To], List).

sequence2(From, To, List, Output):-
    From = To, Output=List, !. % Set output to generated list

sequence2(From, To, List, Output):-
    Counter is To - 1, % Count downwards to append from front
    sequence2(From, Counter, [Counter|List], Output).

% Shuffle list
shuffled(InList, OutList):-
    length(InList, Count),
    shuffled2(InList, Count, OutList).

shuffled2(List, 1, OutList):-
    OutList = List, !. % Return shuffled list

shuffled2(List, Counter, OutList):-
    NewCounter is Counter - 1,
    random_between(1, Counter, RandomValue),
    swap(List, RandomValue, Counter, NewList),
    shuffled2(NewList, NewCounter, OutList).

swap(List, First, Second, Output):-
    nth1(First, List, FirstElement),
    nth1(Second, List, SecondElement),
    swap2(List, [], First, Second, FirstElement, SecondElement, 1, Output).

% Base case
swap2(List, CurrentList, _, _, _, _, Counter, OutList):-
    length(List, L),
    Length is L + 1,
    Counter = Length, % Entire list has been recreated
    OutList = CurrentList, !.

swap2(List, CurrentList, First, Second, FirstElement, SecondElement, Counter, OutList):-
    NewCounter is Counter + 1,
    (Counter = First -> swap2(List, [SecondElement|CurrentList], First, Second, FirstElement, SecondElement, NewCounter, OutList); % First element found so add second
    Counter = Second -> swap2(List, [FirstElement|CurrentList], First, Second, FirstElement, SecondElement, NewCounter, OutList); % Second element found so add first
    nth1(Counter, List, CurrentElement),
    swap2(List, [CurrentElement|CurrentList], First, Second, FirstElement, SecondElement, NewCounter, OutList)). % Add current element

% Sum list
sum(List, Sum):-
    sum2(List, 0, Sum).

sum2([], CurrentSum, Sum):-
    Sum = CurrentSum, !. % Return current sum

sum2([H|T], CurrentSum, Sum):-
    NewCurrentSum is CurrentSum + H, % Add current head to sum
    sum2(T, NewCurrentSum, Sum).
