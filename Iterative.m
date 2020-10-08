function R = Iterative(nume, d, eps) 
  % Functia care calculeaza matricea R folosind algoritmul iterativ.
  
  % deschiderea fisierului din care citesc datele 
  fisier_input = fopen(nume, 'r');
  
  % citirea numarului de resurse web de pe prima linie
  N = fscanf(fisier_input, '%f', 1);

  % initializarea matricei de liste de vecini cu zerouri
  liste_adiac = zeros(N);
  
  % citirea listelor de vecini din fisier si salvarea acestora
  % intr-o matrice de liste de vecini
  for i = 1: N
    % citirea nodului 
    liste_adiac(i, 1) = fscanf(fisier_input, '%f', 1);
    % citirea numarului de vecini
    liste_adiac(i, 2) = fscanf(fisier_input, '%f', 1);
    for j = 1 : liste_adiac(i,2)
      % citirea vecinilor pt fiecare nod
      liste_adiac(i, j) = fscanf(fisier_input, '%f', 1);;
    endfor
  endfor
  
  % completarea matricei de adiacenta a grafului 
  for i = 1 : N
    for j = 1 : N
    if ( liste_adiac(i,j) != 0)
      A(i, liste_adiac(i,j)) = 1;
      endif
    endfor
    % pentru a evita stituatiile in care o pagina are link-uri catre
    % ea insasi, initializez diagonala matricei de adiacenta cu 0
    A(i,i) = 0;
  endfor
  liste_adiac
  A
  
  % inchiderea fisierului dupa citirea datelor necesare
  fclose(fisier_input);
  
  % initializarea vectorului de link-uri pentru fiecare pagina
  L = zeros(N,1);
  
  % calcularea numarului de link-uri pentru fiecare pagina si salvarea
  % acestuia in vectorul L, efectuand suma pe fiecare linie a 
  % matricei A
  for i = 1:N
    L(i) = sum(A(i,:));
  endfor
 
  % calcularea matricei M, ce reprezinta multimea paginilor din care
  % se poate ajunge la pagina A printr-un singur click  
  M = zeros(N);
  M = (diag(1./L)) * A;
  M = M';
  % initializarea lui R0 pentru pasul initial
  R0(1:N, 1) =  1/N;
  ok = 1;
  
  % calcularea vectorului R pana cand eroarea obtinuta este mai mica
  % decat valoarea variabilei eps
  
  while ok  
    % calcularea vectorului R in functie de solutia precedenta
    R = d * M * R0  + ((1 - d) / N) * (ones(N,1));
    
    % verificarea erorii:
    % daca eroarea obtinuta este mai mare decat valoarea variabilei eps
    % se continua procesul de determinare a lui R, R0 devenind R ul proaspat
    % calculat 
  
    if (norm(R-R0) >= eps)
      R0 = R;
    % daca eroarea obtinuta este mai mica decat valoarea variabilei eps
    % variabila ok isi schimba valoarea si se va afisa ca si solutie a lui R
    % R-ul calculat la pasul anterior
    else
     ok = 0;
     R = R0;
    endif

    % daca variabila ok isi schimba valoarea, procesul de determinare a lui R
    % se incheie
    if(ok == 0)
      break
    endif
  endwhile
endfunction