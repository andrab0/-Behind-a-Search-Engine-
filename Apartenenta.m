function y = Apartenenta(x, val1, val2)
	% Functia care primeste ca parametrii x, val1, val2 si
  % care calculeaza valoarea functiei membru in punctul x.
  
  % determinarea parametrilor a si b astfel
  % incat functia u(x) sa fie continuna, aplicand
  % conditiile de continuitate pentru limitele laterale
  % ale functiei
  a = 1 / (val2 - val1);
  b = (1 - val2/(val2-val1));
 
  % calcularea vectorului y in functie de intervalul in care
  % se afla valoarea x 
  y = x * a + b;
  y((x >= 0) && (x < val1)) = 0;
  y((x > val2) && (x <= 1)) = 1;  
  y(y < 0) = 0;
endfunction	