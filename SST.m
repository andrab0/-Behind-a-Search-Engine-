function [x] = SST(A, b)
  % Functie care rezolva un sistem superior-triunghiular
  [latime lungime] = size(A);
  n = min(latime, lungime);
  
  % initializarea solutiei cu valoarea 0.
  x = zeros(n, 1);
  
  % determinarea solutiilor sistemului superior triungiular
  x(n) = b(n) / A(n, n);
  for i = n - 1:-1:1
    x(i) = (b(i) - A(i, i + 1:n) * x(i + 1:n)) / A(i, i);
  endfor
endfunction
