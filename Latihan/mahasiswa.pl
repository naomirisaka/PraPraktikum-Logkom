main :- 
    open('mahasiswa.txt', read, S),
    read_mahasiswa(S, Mahasiswas),
    close(S),
    write(Mahasiswas), nl.

read_mahasiswa(S, []) :-
    at_end_of_stream(S), !.

read_mahasiswa(S, [X|L]) :-
    \+ at_end_of_stream(S), !,
    read(S, X),
    read_mahasiswa(S, L).