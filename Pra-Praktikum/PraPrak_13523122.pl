/* Nama: Naomi Risaka Sitorus */
/* NIM: 13523122 */
/* Kelas: K-02 */

/* ********************************* */
/* Bagian I : Fakta Rules, dan Query */
/* ********************************* */
/* Deklarasi Fakta */
/* pria(X) : X adalah pria */
pria(qika).
pria(panji).
pria(shelby).
pria(barok).
pria(aqua).
pria(eriq).
pria(francesco).

/* wanita(X) : X adalah wanita */
wanita(hinatsuru).
wanita(makio).
wanita(suma).
wanita(frieren).
wanita(yennefer).
wanita(roxy).
wanita(ruby).
wanita(suzy).
wanita(aihoshino).
wanita(eve).

/* usia(X,Y) : X berusia Y */
usia(hinatsuru, 105).
usia(qika, 109).
usia(makio, 96).
usia(suma, 86).
usia(panji, 124).
usia(frieren, 98).
usia(shelby, 42).
usia(yennefer, 61). 
usia(barok, 59).
usia(roxy, 70).
usia(aqua, 66).
usia(ruby, 63).
usia(eriq, 69).
usia(suzy, 23).
usia(francesco, 25).
usia(aihoshino, 48).
usia(eve, 5).

/* menikah(X,Y) : X menikah dengan Y */
menikah(hinatsuru, qika).
menikah(qika, hinatsuru).
menikah(qika, makio).
menikah(makio, qika).
menikah(qika, suma).
menikah(suma, qika).
menikah(panji, frieren).
menikah(frieren, panji).
menikah(barok, roxy).
menikah(roxy, barok).
menikah(ruby, eriq).
menikah(eriq, ruby).
menikah(suzy, francesco).
menikah(francesco, suzy).

/* anak(X,Y) : X adalah anak Y */
anak(shelby, hinatsuru).
anak(shelby, qika).
anak(yennefer, hinatsuru).
anak(yennefer, qika).
anak(barok, qika).
anak(barok, makio).
anak(aqua, panji).
anak(aqua, frieren).
anak(ruby, panji).
anak(ruby, frieren).
anak(suzy, barok).
anak(suzy, roxy).
anak(aihoshino, ruby).
anak(aihoshino, eriq).
anak(eve, suzy).
anak(eve, francesco).

/* Deklarasi Rules */
/* saudara(X,Y) : X adalah saudara kandung maupun tiri dari Y */
saudara(X,Y) :- 
    anak(X,Z),
    anak(Y,Z),
    X \== Y.

/* saudaratiri(X,Y) : X adalah saudara tiri dari Y */
saudaratiri(X,Y) :-
    saudara(X,Y),
    anak(X,Z),
    anak(Y,Z),
    anak(X,A),
    anak(Y,B),
    menikah(Z,A),
    menikah(Z,B),
    A \== B.

/* kakak(X,Y) : X adalah kakak dari Y (kakak kandung maupun tiri) */
kakak(X,Y) :-
    saudara(X,Y),
    usia(X,A),
    usia(Y,B),
    A > B.

/* keponakan(X,Y) : X adalah keponakan dari Y */
keponakan(X,Y) :-
    anak(X,Z),
    saudara(Z,Y).

/* mertua(X,Y) : X adalah mertua dari Y */
mertua(X,Y) :-
    menikah(Y,Z),
    anak(Z,X).

/* nenek(X,Y) : X adalah nenek dari Y */
nenek(X,Y) :-
    wanita(X),
    anak(Y,Z),
    anak(Z,X).

/* keturunan(X,Y) : X adalah keturunan dari Y (anak, cucu, dan seterusnya) */
keturunan(X,Y) :- anak(X, Y).
keturunan(X,Y) :- 
    anak(X, Z), 
    keturunan(Z,Y).

/* lajang(X) : X adalah orang yang tidak menikah */
lajang(X) :-
    pria(X),
    \+ menikah(X,_).
lajang(X) :-
    wanita(X),
    \+ menikah(X,_).

/* anakbungsu(X) : X adalah anak paling muda */
anakbungsu(X) :-
    anak(X,_),
    \+ (saudara(X,Y), usia(X,A), usia(Y,B), A > B).

/* anaksulung(X) : X adalah anak paling tua */
anaksulung(X) :- 
    anak(X,_),
    \+ (saudara(X,Y), usia(X,A), usia(Y,B), A < B).

/* yatimpiatu(X) : X adalah orang yang orang tuanya tidak terdefinisi */
yatimpiatu(X) :- 
    pria(X), 
    \+ anak(X,_).
yatimpiatu(X) :- 
    wanita(X), 
    \+ anak(X,_).


/* *********************** */
/* Bagian II: Rekursivitas */
/* *********************** */
/* 1. Exponent 
A (Nilai A > 0) merupakan basis perpangkatan, sedangkan B merupakan pangkat
dari A (Nilai B ≥ 0). exponent(A, B, X) akan mengeluarkan hasil perpangkatan AB yaitu X. */
exponent(_, 0, 1).
exponent(A, B, X) :-
    B > 0,
    B1 is B - 1,
    exponent(A, B1, X1),
    X is A * X1.

/* 2. Growth
Fungsi growth(I, G, H, T, X) akan mengembalikan jumlah item X pada tahun ke-T. 
Pola ini diawali dengan jumlah item awal I (dengan nilai I > 0). Pada setiap tahun ke-T 
(dengan nilai T ≥ 0), jumlah item akan bertambah atau berkurang tergantung pada pola yang ditentukan oleh dua
parameter (G dan H) dengan aturan sebagai berikut.
● Jika T adalah bilangan prima, jumlah item bertambah sebesar G.
● Jika T bukan bilangan prima, jumlah item berkurang sebesar H (dengan nilai H < I). */
prime(2).
prime(N) :- 
    N > 2, 
    \+ hasDiv(N, 2).

hasDiv(N, M) :-
    M * M =< N,
    N mod M =:= 0,
    !.
hasDiv(N, M) :-
    M * M =< N,
    M1 is M + 1, 
    hasDiv(N, M1).

growth(I, _, _, 0, I).
growth(I, G, H, T, X) :-
    T > 0, 
    (prime(T) -> I1 is I + G; I1 is I - H),
    T1 is T - 1,
    growth(I1, G, H, T1, X).

/* 3. Si Imut Anak Nakal
Fungsi harvestFruits(N, Fruits, TreeNumber, FinalFruits) menghitung total buah yang 
didapatkan Si Imut selama aksi pencuriannya. Si Imut mulai dari nomor pohon yang 
dipilihnya (TreeNumber) dan dapat menjelajahi semua pohon hingga (N). */
prima(2).
prima(N) :- 
    N > 2, 
    \+ hasPembagi(N, 2).

hasPembagi(N, M) :-
    M * M =< N,
    N mod M =:= 0,
    !.
hasPembagi(N, M) :-
    M * M =< N,
    M1 is M + 1, 
    hasPembagi(N, M1).

harvestFruits(N, Fruits, TreeNumber, FinalFruits) :-
    TreeNumber > N,
    FinalFruits is Fruits.
harvestFruits(_, Fruits, _, FinalFruits) :-
    Fruits =< 0,
    write('Si Imut pulang sambil menangis :('),
    FinalFruits is 0.
harvestFruits(N, Fruits, TreeNumber, FinalFruits) :-
    (TreeNumber mod 3 =:= 0 -> Fruits1 is Fruits + 2; Fruits1 is Fruits),
    (TreeNumber mod 4 =:= 0 -> Fruits2 is Fruits1 - 5; Fruits2 is Fruits1),
    (TreeNumber mod 5 =:= 0 -> Fruits3 is Fruits2 + 3; Fruits3 is Fruits2),
    (prima(TreeNumber) -> Fruits4 is Fruits3 - 10; Fruits4 is Fruits3),
    TreeNumber1 is TreeNumber + 1,
    harvestFruits(N, Fruits4, TreeNumber1, FinalFruits).

/* 4. KPK
X adalah kelipatan persekutuan terkecil(KPK) dari A dan B. */
fpb(A, 0, A).
fpb(A, B, Y) :-
    M is A mod B,
    fpb(B, M, Y).

kpk(A, B, X) :-
    fpb(A, B, Y),
    X is (A * B) // Y.

/* 5. Factorial
N (Nilai N ≥ 0) adalah bilangan yang akan dihitung faktorialnya. factorial(N, X)
akan mengeluarkan hasil faktorial dari N, yaitu X. */
factorial(0, 1).
factorial(N, X) :-
    N > 0,
    N1 is N - 1,
    factorial(N1, X1),
    X is N * X1.

/* 6. Make Pattern
makePattern(N) akan menuliskan sebuah persegi angka sebesar N satuan dengan
setiap angkanya menyatakan kedalaman persegi. */
makePattern(N) :-
    writePattern(1, N, N), 
    !.

writePattern(CurrR, N, R) :-
    CurrR =< R,
    writeLine(CurrR, N, R, 1),
    nl,
    NextR is CurrR + 1,
    writePattern(NextR, N, R).
writePattern(CurrR, _, R) :-
    CurrR > R.

writeLine(CurrR, N, R, CurrC) :-
    CurrC =< R,
    countDepth(CurrR, CurrC, R, Depth),
    write(Depth), 
    write(' '),
    NextC is CurrC + 1,
    writeLine(CurrR, N, R, NextC).
writeLine(_, _, R, CurrC) :-
    CurrC > R.

countDepth(Row, Col, R, Depth) :-
    Top is Row,
    Bottom is R - Row + 1,
    Left is Col,
    Right is R - Col + 1,
    findMin(Top, Bottom, MinVertical),
    findMin(Left, Right, MinHorizontal),
    findMin(MinVertical, MinHorizontal, Depth).

findMin(A, B, Min) :- (A =< B -> Min is A; Min is B).


/* **************** */
/* Bagian III: List */
/* **************** */
/* 1. List Statistic */
/* a. min: mencari elemen dengan nilai minimum */
min([X], X).
min([H|T], X) :-
    min(T, X1),
    (H < X1 -> X is H; X is X1).

/* b. max: mencari elemen dengan nilai maksimum */
max([X], X).
max([H|T], X) :-
    max(T, X1),
    (H > X1 -> X is H; X is X1).

/* c. range: mencari selisih antara elemen terbesar dan elemen terkecil */
range(L, X) :-
    max(L, Max),
    min(L, Min),
    X is Max - Min.

/* d. count: mencari jumlah elemen pada list */
count([], 0).
count([_|T], X) :-
    count(T, X1),
    X is X1 + 1.

/* e. sum: mencari jumlah total elemen pada list */
sum([], 0).
sum([H|T], X) :-
    sum(T, X1),
    X is H + X1.

/* 2. List Manipulation */
/* a. mergeSort
Merge Sort adalah algoritma sorting populer yang menggunakan strategi divide and
conquer. Algoritma ini terbagi menjadi 3 bagian utama, yaitu divide, conquer, dan
merge. Pada bagian merge, terdapat 2 list yang akan diambil nilainya satu persatu
untuk kemudian disatukan ke dalam 1 list yang terurut. */
mergeSort(ListA, [], ListA).
mergeSort([], ListB, ListB).
mergeSort([HA|TA], [HB|TB], [HA|T]) :-
    HA < HB,
    mergeSort(TA, [HB|TB], T).
mergeSort([HA|TA], [HB|TB], [HB|T]) :-
    HA >= HB,
    mergeSort([HA|TA], TB, T). 

/* b. filterArray
Filter Array adalah fungsi yang digunakan untuk memfilter elemen-elemen dari
sebuah array berdasarkan dua kriteria:
1. Elemen harus lebih besar dari Element1.
2. Elemen harus kelipatan dari Element2.
Fungsi ini akan menelusuri elemen-elemen dalam list satu per satu dan hanya
menyertakan elemen-elemen yang memenuhi kedua syarat tersebut ke dalam Result. */
filterArray([], _, _, []).
filterArray([H|T], Element1, Element2, [H|Rest]) :-
    H > Element1,
    H mod Element2 =:= 0,
    filterArray(T, Element1, Element2, Rest).
filterArray([_|T], Element1, Element2, Rest) :-
    filterArray(T, Element1, Element2, Rest).

/* c. reverse
Reverse adalah proses membalik urutan elemen sehingga elemen yang berada di
posisi paling akhir menjadi yang pertama dan sebaliknya. */
reverseList(List, Result) :- rev(List, [], Result).     % fungsi reverse(), namanya beda agar tidak bentrok dengan fungsi bawaan Prolog

rev([], Temp, Temp).
rev([H|T], Temp, Result) :- rev(T, [H|Temp], Result).

/* d. cekPalindrom
Fungsi cekPalindrom/1 dalam Prolog berfungsi untuk memeriksa apakah sebuah 
bilangan bulat adalah palindrom. Sebuah bilangan disebut palindrom jika 
angka-angka dalam bilangan tersebut sama saat dibaca dari depan maupun dari
belakang. */
cekPalindrom([_]) :- !.
cekPalindrom(List) :-
    balikList(List, Reversed),
    List = Reversed.

balikList(List, Result) :- balik(List, [], Result).

balik([], Temp, Temp).
balik([H|T], Temp, Result) :- balik(T, [H|Temp], Result).
/*
the correct ver:
cekPalindrom([]).
cekPalindrom([_]).
cekPalindrom([H|T]) :-
    findLast(T, Last, T2),
    H =:= Last,
    cekPalindrom(T2).

findLast([_, Y], Y, []):- !.
findLast([H|T], Last, [H|T2]):- findLast(T, Last, T2).
*/

/* e. rotate
rotate(List, N, Result) adalah fungsi untuk memutar elemen dalam list sebanyak N
kali ke arah kiri. Jika N lebih besar dari panjang list, jumlah rotasi akan dihitung
dengan cara N mod Length, di mana Length adalah panjang list.
● List kosong ([]) harus ditangani dengan mengembalikan list kosong.
● Jika N < 0, rotasi ke arah kanan dilakukan dengan mengonversi N ke rotasi
ke kiri yang ekuivalen.
● Jika N > Panjang List, silahkan normalisasi jumlah rotasi. */
rotate([], _, []).
rotate(List, N, Result) :-
    countLength(List, Length),
    (Length =:= 0 -> 
        Result = List
    ; 
        (
        N1 is (N mod Length + Length) mod Length,  
        splitList(List, N1, Left, Right),
        mergeList(Right, Left, Result)
        )
    ).

splitList(List, 0, [], List).
splitList([H|T], N, [H|Left], Right) :-
    N > 0,
    N1 is N - 1,
    splitList(T, N1, Left, Right).

countLength([], 0).
countLength([_|T], Len) :-
    countLength(T, Len1),
    Len is Len1 + 1.

mergeList([], List, List).
mergeList([H|T], List, [H|R]) :-
    mergeList(T, List, R).

/* f. Mapping
Sebuah program yang dapat mengkonversi array of nilai dalam bentuk angka ke 
array of nilai dalam bentuk huruf/indeks. Program tersebut akan menerima input berupa 
nama mahasiswa dan nilai dari mahasiswa tersebut. Program akan mengkonversi nilai-nilai 
tersebut ke dalam bentuk huruf dan menghitung nilai rata-rata mahasiswa tersebut. 
Program akan mengeluarkan output berupa nama mahasiswa, nilai-nilai mahasiswa dalam bentuk
huruf, nilai rata-rata, dan status kelulusan mahasiswa tersebut. Jika nilai rata-rata >=
80, maka status kelulusan adalah "Pass", jika tidak, maka status kelulusan adalah "Fail". */
prosesMahasiswa(Name, Grades, Result) :-
    mapGrades(Grades, LetterGrades),
    average(Grades, Average),
    (Average >= 80 -> Status = 'Pass'; Status = 'Fail'),
    Result = [Name, LetterGrades, Average, Status].

mapGrades([], []).
mapGrades([H1|T1], [H2|T2]) :-
    convertGrade(H1, H2),
    mapGrades(T1, T2).

convertGrade(Grade, 'A') :- Grade >= 80.
convertGrade(Grade, 'B') :- Grade >= 70.
convertGrade(Grade, 'C') :- Grade >= 60.
convertGrade(Grade, 'D') :- Grade >= 50.
convertGrade(Grade, 'E') :- Grade < 50.

sumGrades([], 0).
sumGrades([H|T], Sum) :-
    sumGrades(T, Sum1),
    Sum is H + Sum1.

countLen([], 0).        % fungsi length(), namanya beda agar tidak bentrok dengan fungsi bawaan Prolog
countLen([_|T], Len) :-
    countLen(T, Len1),
    Len is Len1 + 1.

average(Grades, Average) :- 
    sumGrades(Grades, Sum),
    countLen(Grades, Length),
    (Length =:= 0 -> Average is 0; Average is Sum / Length).


/* ******************************* */
/* BONUS: Petualangan Mencari Koin */
/* ******************************* */
/* Kamu terbangun di padang pasir dengan hati yang berat. Unta putih dan unta hitam, sahabat
setiamu selama bertahun-tahun, kini berada dalam kendali para pedagang karavan. Mereka
bersedia mengembalikan untamu jika kamu dapat membuktikan kemampuanmu dalam
menjelajahi reruntuhan kuno gurun ini untuk mengumpulkan koin sebanyak mungkin.
Akan tetapi, perjalanan ini tidak mudah. Para pencuri makam telah meninggalkan jebakan
di setiap sudut reruntuhan. Setiap langkah yang kamu ambil bisa menjadi berbahaya,
tergantung pada keberuntunganmu. Kamu ingin melakukan simulasi sebelum mulai
melakukan penjelajahan, oleh karena itu buatlah sebuah simulasi permainan sederhana. */

/* 1. start
Memulai permainan. Koin awal diatur ke 0. Menampilkan pesan pengantar tentang tujuan permainan. */
:- dynamic(started/1).
:- dynamic(coins/1).

started(false).
coins(0).

start :-
    started(false),
    !, 
    retract(started(false)),
    asserta(started(true)),
    retract(coins(_)),
    asserta(coins(0)),
    write('Unta putih dan unta hitammu diambil oleh pedagang'), nl,
    write('karavan. Kumpulkan koin sebanyak-banyaknya !!!'), nl.
start :-
    started(true),
    !,
    write('Permainan sudah dimulai. Gunakan "exit" untuk keluar dan'), nl,
    write('memulai ulang.'), nl.

/* 2. move(Direction)
Menggerakkan pemain ke arah tertentu (north, south, east, atau west). Setiap langkah memiliki dua kemungkinan:
- Jalur Aman: Koin bertambah 10.
- Terkena Jebakan: Koin berkurang 10.
Skor dapat menjadi negatif. */
random_trap(X) :-
    random(1, 5, X). 

move(Direction) :-
    started(true),
    !, 
    write('Kamu bergerak ke arah '), write(Direction), write('.'), nl,
    random_manual(Trap),
    (Trap =:= 1 ->  
        write('Oh tidak! Kamu terkena jebakan!'), nl,
        retract(coins(CurrCoins)),
        NewCoins is CurrCoins - 10,
        asserta(coins(NewCoins))
    ;
        write('Jalannya aman.'), nl,
        write('Kamu mendapatkan 10 poin.'), nl,
        retract(coins(CurrCoins)),
        NewCoins is CurrCoins + 10,
        asserta(coins(NewCoins))
    ),
    display_status, 
    !.

/* 3. display_status
Menampilkan informasi koin terkini. */
display_status :-
    started(true),
    !,  
    coins(CurrCoins),
    write('Koin Saat Ini: '), write(CurrCoins), nl.

/* 4. exit
Untuk keluar dari permainan. Jika permainan belum dimulai, tampilkan pesan kalau
permainan belum dimulai. */
exit :-
    started(true),
    !, 
    retract(started(true)),
    retract(coins(_)),
    asserta(started(false)),
    asserta(coins(0)),
    write('Terima kasih telah memainkan simulasi ini! Sampai jumpa'), nl,
    write('lagi.'), nl.
exit :-
    started(false),
    !,
    write('Permainan belum dimulai. Gunakan "start" untuk memulai.'), nl, 
    fail.