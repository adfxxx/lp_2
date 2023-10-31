% А не входит в руководство, если Д не председатель
situation_1(A,_,_,_,D,_) :- D \= "Chairman", A \= "Citizen", !, fail.
situation_1(_,_,_,_,_,_).

% Б не будет в руководстве, если он будет старше В
situation_2(_,B,V,_,_,_) :- B == "Chairman", V == "Vice", !, fail.
situation_2(_,B,V,_,_,_) :- B == "Chairman", V == "Secretary", !, fail.
situation_2(_,B,V,_,_,_) :- B == "Vice", V == "Secretary", !, fail.
situation_2(_,_,_,_,_,_).

% Б не будет работать с Е
situation_3(_,B,_,_,_,E) :- B \= "Citizen", E \= "Citizen", !, fail.
situation_3(_,_,_,_,_,_).

% В не будет работать с Д и Е
situation_4(_,_,V,_,D,E) :- V \= "Citizen", D \= "Citizen" , E \= "Citizen", !, fail.
situation_4(_,_,_,_,_,_).

% В не будет работать, если Е - председатель или Б - секретарь
situation_5(_,_,V,_,_,E) :- E == "Chairman", V \= "Citizen", !, fail.
situation_5(_,B,V,_,_,_) :- B == "Secretary", V \= "Citizen", !, fail.
situation_5(_,_,_,_,_,_).

% Г не будет работать, если он будет ниже В или Д
situation_6(_,_,V,G,_,_) :- V == "Chairman", G == "Vice", !, fail.
situation_6(_,_,V,G,_,_) :- V == "Chairman", G == "Secretary", !, fail.
situation_6(_,_,V,G,_,_) :- V == "Vice", G == "Secretary", !, fail.
situation_6(_,_,_,G,D,_) :- D == "Chairman", G == "Vice", !, fail.
situation_6(_,_,_,G,D,_) :- D == "Chairman", G == "Secretary", !, fail.
situation_6(_,_,_,G,D,_) :- D == "Vice", G == "Secretary", !, fail.
situation_6(_,_,_,_,_,_).

% Д не хочет быть заместителем
situation_7(_,_,_,_,D,_) :- D == "Vice", !, fail.
situation_7(_,_,_,_,_,_).

% Д не хочет быть секретарем, если Г будет в руководстве
situation_8(_,_,_,G,D,_) :- G \= "Citizen", D == "Secretary", !, fail.
situation_8(_,_,_,_,_,_).

% Д не хочет работать с А, если Е не будет в руководстве
situation_9(A,_,_,_,D,E) :- E == "Citizen", D \= "Citizen", A \= "Citizen", !, fail.
situation_9(_,_,_,_,_,_).

% Е будет работать, если председатель он или В
situation_10(_,_,V,_,_,E) :- E \= "Citizen", V \= "Chairman", !, fail.
situation_10(_,_,_,_,_,_).

all_situations([A,B,V,G,D,E]) :- 
	Positions = ["Chairman", "Vice", "Secretary", "Citizen", "Citizen", "Citizen"],
	permutation([A,B,V,G,D,E], Positions),
	situation_1(A,B,V,G,D,E),
	situation_2(A,B,V,G,D,E),
	situation_3(A,B,V,G,D,E),
	situation_4(A,B,V,G,D,E),
	situation_5(A,B,V,G,D,E),
	situation_6(A,B,V,G,D,E),
	situation_7(A,B,V,G,D,E),
	situation_8(A,B,V,G,D,E),
	situation_9(A,B,V,G,D,E),
	situation_10(A,B,V,G,D,E).
	
solve() :- 
	setof([A,B,V,G,D,E], all_situations([A,B,V,G,D,E]), [[T,U,W,X,Y,Z]]),
	write("A: "), write(T), nl,
	write("B: "), write(U), nl,
	write("V: "), write(W), nl,
	write("G: "), write(X), nl,
	write("D: "), write(Y), nl,
	write("E: "), write(Z), nl. 
