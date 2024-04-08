% Student exercise profile
:- set_prolog_flag(occurs_check, error).        % disallow cyclic terms
:- set_prolog_stack(global, limit(8 000 000)).  % limit term space (8Mb)
:- set_prolog_stack(local,  limit(2 000 000)).  % limit environment space

% Your program goes here
rodzic(krzysztof,krystian). %Pierwsze jest rodzicem drugiego
rodzic(beata,krystian).
rodzic(krzysztof,wiktor).
rodzic(beata,wiktor).
rodzic(bronislaw,krzysztof).
rodzic(krystyna,krzysztof).
rodzic(bronislaw,malgorzata).
rodzic(krystyna,malgorzata).
rodzic(malgorzata,dawid).
rodzic(malgorzata,bartek).
rodzic(zbyszek,beata).
rodzic(hanna,beata).
rodzic(pani,krzysztof).
rodzic(krzysztof,corka).
rodzic(pani,corka).
rodzic(grzegorz,dawid).
znajomy(dawid,kolega).
znajomy(kolega, pawel).
znajomy(pawel,dawid).


rodzenstwo(X, Y) :-
    rodzic(Z, X),  % Z jest rodzicem X
    rodzic(Z, Y),  % Z jest również rodzicem Y
    X \= Y.       % X nie jest takie same jak Y

kuzyn(X, Y) :-
    rodzic(Z, X),       % Z jest rodzicem X
    rodzic(W, Y),       % W jest rodzicem Y
    rodzenstwo(Z, W),   % Z i W są rodzeństwem
    X \= Y.             % X nie jest takie samo jak Y
dziadkowie_wnuka(X,Y) :-
    rodzic(X,A), rodzic(Y,B), %X jest rodzicem A, Y rodzicem B
    rodzic(A,W), rodzic(B,W), %A jest rodzicem W i B jest rodzicem W
    X \= Y, 
    A \= B.
macocha_ojczym(X, Y) :-
    rodzic(D, Y),               % D jest rodzicem Y
    rodzic(D, Q),               % D jest również rodzicem Q
    rodzic(X, Q),               % X jest rodzicem Q
    D \= X,                     % D nie jest tą samą osobą co X
    \+ rodzic(X, Y),            % X nie jest rodzicem Y
    X \= Q,                     % X nie jest tą samą osobą co Q
    Q \= Y.                    % Q nie jest tą samą osobą co Y
przybrane_rodzenstwo(X,Y) :-
    rodzic(M,X), rodzic(P,Y),
    rodzic(D,X), rodzic(D,Y),
    \+rodzic(P,X),
    \+rodzic(M,Y),
    M \= P,
    D \= M,
    P \= D,
    Y \= X.
szwagrostwo(X,Y) :-
    rodzenstwo(Y,R),    %D to wspolne dziecko  R i X
    rodzic(R, D),       
    rodzic(X, D),    
    R \= X,             % R nie jest tą samą osobą co X
    Y \= D,             % Y nie jest tą samą osobą co D
    X \= Y.            % X nie jest tą samą osobą co Y
wspolni_znajomi(X, Y, Z) :-
    znajomy(X, Y),     
    znajomy(Y, Z),      
    X \= Y,             
    Y \= Z,            
    X \= Z.     
        


    
    
    
    

    

/** <examples> Your example queries go here, e.g.
?- member(X, [cat, mouse]).
*/
