function [R1 R2] = PageRank(nume, d, eps)
  % Functie care calculeaza indicii PageRank pentru
  % cele 3 cerinte scrie fisierul de iesire nume.out
	
  % determinarea numelui fisierului de output
  output = strcat(nume,".out");
  
  % deschiderea fisierului de output pentru adaugarea
  % rezultatelor
  fisier_output = fopen(output, 'w');
  
  % deschiderea fisierului din care extrag datele
  fisier_input = fopen(nume, 'r');
  
  % citirea numarului de resurse web
  N = fscanf(fisier_input, '%f', 1);
  
  % printarea rezultatului extras in fisierul de output
  fprintf(fisier_output, '%i\n', N);
  fprintf(fisier_output, '\n');
  
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
  
  % citirea celor doua valori utilizate ca si capete de interval
  % in algoritmul "Apartenenta"fisier_out
  val1 = fscanf(fisier_input, '%f\n', 1);
  val2 = fscanf(fisier_input, '%f', 1);
  
  % inchiderea fisierului dupa citirea datelor necesare
  fclose(fisier_input);
  
  % calcularea vectorului PR obtinut prin metoda "Iterative"
  PR_Iterativ = Iterative(nume, d, eps);
  R1 = PR_Iterativ;
  
  % afisarea vectorului PR obtinut prin metoda "Iterative"
  % in fisierul de output
  fprintf(fisier_output, '%f\n', PR_Iterativ);
  fprintf(fisier_output, '\n');
  
  % calcularea vectorului PR obtinut prin metoda "Algerbaic"
  PR_Algebraic = Algebraic(nume, d, eps);
  R2 = PR_Algebraic;
  
  % afisarea vectorului PR obtinut prin metoda "Algebraic"
  % in fisierul de output
  fprintf(fisier_output, '%f\n', PR_Algebraic);
  fprintf(fisier_output, '\n');
  
  % sortarea vectorului PR obtinut prin metoda "Algebraic"
  % in mod descrescator
  [PR1, j] = sort(PR_Algebraic, 'descend');
  
  % verific apartenenta elementului in functie de valorile
  % val1 si val2 extrase mai sus
  y = zeros(N,1);
  y = Apartenenta(PR1, val1, val2);
  
  % afisarea in fisierul de output a indicelui din clasament,
  % numarului paginii care a obtinut locul respectiv si a 
  % gradului de apartenenta
  for i = 1:N
    fprintf(fisier_output, '%i %i %f\n', i, j(i), y(i));
  endfor
 
  % inchiderea fisierului de output dupa afisarea tuturor
  % rezultatelor
  fclose(fisier_output);
endfunction