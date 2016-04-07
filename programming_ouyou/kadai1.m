%初期設定(M,L)
M=3;
L=3;
dx = 0.1 / ( M + 1);
dy = 0.1 / ( L + 1);
%pを単位行列として作成
p = eye(M * L);
%対角項にa_1を代入
for i = 1: size(p)
	p(i,i) = a_1;
end

%fを(M+1)*(L+1)のゼロ行列として作成
f = zeros(M + 1,L + 1);
%境界条件を設定
f(:,1) = 0;
f(M + 1,:) = 0;
f(:,L + 1) = 100;
f(1,:) = 100;


%psaiをML*1のゼロ行列として作成
psai = zeros(M * L,1);

%x,y両方向の差分逆数二乗和の二倍をa_1とし、またx,y方向の差分逆数二乗をそれぞれa_2,a_3とする
a_1 = -2 / dx^2 -2 / dy^2;
a_2 = 1 / dx^2;
a_3 = 1 / dy^2;

for i = 1:L
	if (i == 1)
		for j = 1:M
			if (j == 1)
				%aを定義
				a = (j - 1) * L + (i - 1) + 1;
				psai(a,1) = psai(a,1) .- a_2 * 100;
				else if (1 < j < M)
				%aを定義
				a = (j - 1) * L + (i - 1) + 1;
				p(a,a - L) = a_2;
				p(a,a + L) = a_3;
				else if (j == M)
				%aを定義
				a = (j - 1) * L + (i - 1) + 1;
				psai(a,1) = psai(a,1) .- a_3 *100;
				end
			end
		end
	end
end
end

disp(p);
disp(f);
disp(psai');