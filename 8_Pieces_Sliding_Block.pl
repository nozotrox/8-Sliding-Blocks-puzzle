left(A/0/B/C/D/E/F/G/H, 0/A/B/C/D/E/F/G/H).
left(A/B/0/C/D/E/F/G/H, A/0/B/C/D/E/F/G/H).
left(A/B/C/D/0/E/F/G/H, A/B/C/0/D/E/F/G/H).
left(A/B/C/D/E/0/F/G/H, A/B/C/D/0/E/F/G/H).
left(A/B/C/D/E/F/G/0/H, A/B/C/D/E/F/0/G/H).
left(A/B/C/D/E/F/G/H/0, A/B/C/D/E/F/G/0/H).

right(0/A/B/C/D/E/F/G/H, A/0/B/C/D/E/F/G/H).
right(A/0/B/C/D/E/F/G/H, A/B/0/C/D/E/F/G/H).
right(A/B/C/0/D/E/F/G/H, A/B/C/D/0/E/F/G/H).
right(A/B/C/D/0/E/F/G/H, A/B/C/D/E/0/F/G/H).
right(A/B/C/D/E/F/0/G/H, A/B/C/D/E/F/G/0/H).
right(A/B/C/D/E/F/G/0/H, A/B/C/D/E/F/G/H/0).

up(A/B/C/0/D/E/F/G/H, 0/B/C/A/D/E/F/G/H).
up(A/B/C/D/0/E/F/G/H, A/0/C/D/B/E/F/G/H).
up(A/B/C/D/E/0/F/G/H, A/B/0/D/E/C/F/G/H).
up(A/B/C/D/E/F/0/G/H, A/B/C/0/E/F/D/G/H).
up(A/B/C/D/E/F/G/0/H, A/B/C/D/0/F/G/E/H).
up(A/B/C/D/E/F/G/H/0, A/B/C/D/E/0/G/H/F).

down(0/A/B/C/D/E/F/G/H, C/A/B/0/D/E/F/G/H).
down(A/0/B/C/D/E/F/G/H, A/D/B/C/0/E/F/G/H).
down(A/B/0/C/D/E/F/G/H, A/B/E/C/D/0/F/G/H).
down(A/B/C/0/D/E/F/G/H, A/B/C/F/D/E/0/G/H).
down(A/B/C/D/0/E/F/G/H, A/B/C/D/G/E/F/0/H).
down(A/B/C/D/E/0/F/G/H, A/B/C/D/E/H/F/G/0).

a(0,0). a(1,1). a(2,2). a(3,1). a(4,2). a(5,3). a(6,2). a(7,3). a(8,4).
b(0,0). b(1,0). b(2,1). b(3,2). b(4,1). b(5,2). b(6,3). b(7,2). b(8,3).
c(0,0). c(1,1). c(2,0). c(3,3). c(4,2). c(5,1). c(6,4). c(7,3). c(8,2).
d(0,0). d(1,2). d(2,3). d(3,0). d(4,1). d(5,2). d(6,1). d(7,2). d(8,3).
e(0,0). e(1,1). e(2,2). e(3,1). e(4,0). e(5,1). e(6,2). e(7,1). e(8,2).
f(0,0). f(1,2). f(2,1). f(3,2). f(4,1). f(5,0). f(6,3). f(7,2). f(8,1).
g(0,0). g(1,3). g(2,4). g(3,1). g(4,2). g(5,3). g(6,0). g(7,1). g(8,2).
h(0,0). h(1,2). h(2,3). h(3,2). h(4,1). h(5,2). h(6,1). h(7,0). h(8,1).
i(0,0). i(1,3). i(2,2). i(3,3). i(4,2). i(5,1). i(6,2). i(7,1). i(8,0).

igual(X, Y, Z):- X > Y, fail; X < Y, fail; Z is X.

move(A, C, left):- left(A, C), !; C = A.
move(A, C, right):- right(A, C), !; C = A.
move(A, C, down):- down(A, C), !; C = A.
move(A, C, up):- up(A, C), !; C = A.

minimo(A,-1, S):- S = A.
minimo(-1, A, S):- S = A.
minimo(A,B,S):- A<B, S = A,!.
minimo(A,B,S):- S = B.

minList([],0).
minList([X], X).
minList([Head | Tail], Min):- minList(Tail, SMin), minimo(Head, SMin, SSMin), Min is SSMin.

heuristica(A/B/C/D/E/F/G/H/I, Heu):-
    a(A, Ha), b(B, Hb), c(C, Hc),
    d(D, Hd), e(E, He), f(F, Hf),
    g(G, Hg), h(H, Hh), i(I ,Hi),
    Heu is Ha+Hb+Hc+Hd+He+Hf+Hg+Hh+Hi.

heurMov(A, Mov, H):- move(A, C, Mov), C \== A,  heuristica(C, T), H is T, !; H = 100.

melhorHeu(A, C):- heurMov(A, left, Hl), heurMov(A, right, Hr), minimo(Hl, Hr, MH1), heurMov(A, up, Hu), minimo(Hu,MH1, MH2),heurMov(A, down, Hd), minimo(Hd, MH2, MH3), C is MH3.

melhorMOv(A, Heu, C):- move(A, C, left), heurMov(A, left, H1), H1 == Heu, !, write("Left ").

melhorMOv(A, Heu, C):- move(A, C, right), heurMov(A, right, H1), H1 == Heu, !, write("Right ").

melhorMOv(A, Heu, C):- move(A, C, up), heurMov(A, up, H1), H1 == Heu, !, write("UP ").

melhorMOv(A, Heu, C):- move(A, C, down), heurMov(A, down, H1), H1 == Heu, !, write("Down ").


mm(A, D):- melhorHeu(A, C), melhorMOv(A, C, K), D = K.

movimentar(A, 0):- write(" Fin"), !.
movimentar(A, _):- mm(A, D), heuristica(D, Heu), movimentar(D, Heu).
