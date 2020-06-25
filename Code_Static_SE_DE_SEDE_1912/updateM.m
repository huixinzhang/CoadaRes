function M = updateM(M, x0, y0, x1, y1)

%%%%%%%%%%%%%%%%%%%%%%%%% JiHui Nie's Update's Method%%%%%%%%%%%%%%
[m, n] = size(M);

for i = 1 : m
	for j = 1 : n
		if (M(i, j) ~= 0 && x0(j) ~= 0 && y0(i) ~= 0)
			M(i, j) = M(i, j) * x1(j) / x0(j) * y1(i) / y0(i);
		end
	end
end
%%%%%%%%%%%%%%%%%%%%%%%%% JiHui Nie's Update's Method%%%%%%%%%%%%%%
