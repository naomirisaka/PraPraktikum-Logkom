/*fakta, sebagai basis*/
p(0, positif).
/*aturan*/
p(N, positif):- N1 is N - 1, p(N1, positif).
p(N, negatif):- \+(p(N, positif)). 

/*not p(N,positif)*/