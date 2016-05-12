%初期設定M,L,n,I
M = 11;
L = 11;
n = M * L;
I = eye(n);

%C_p,lambda,dt,it,a(温度を取る点の座標)を設定
C_p = 139 * 13546;
lambda = 7/8;
dt = 5;
a = (n+1)/2;

%Qを計算する
%dx,dyを計算
dx = 0.1 / ( M + 1);
dy = 0.1 / ( L + 1);

%x,y両方向の差分逆数二乗和の二倍をa_1とし、またx,y方向の差分逆数二乗をそれぞれa_2,a_3とする
a_1 = -2 / dx^2 - 2 / dy^2;
a_2 = 1 / dx^2;
a_3 = 1 / dy^2;

%pを単位行列として作成
p = eye(n);

%対角項にa_1を代入
for i = 1: size(p)
	p(i,i) = a_1;
endfor

%psaiをML*1のゼロ行列として作成
psai = zeros(M * L,1);

for i=1:L
	for j=1:M
		%aを定義
		a = (j - 1) * L + (i - 1) + 1;
		%a = 1のとき
		if(i == 1 && j == 1)
			%3.の処理
			p(a,a + 1) = p(a,a + 1) .+ a_2;
			%5.の処理
			p(a,a + L) = p(a,a + L) .+ a_3;
		else
			%a=4のとき
			if(i == 1 && 1 < j && j < M)
				%3.の処理
				p(a,a + 1) = p(a,a + 1) .+ a_2;
				%4.5.の処理
				p(a,a - L) = p(a,a - L) .+ a_2;
				p(a,a + L) = p(a,a + L) .+ a_3;
			else
				%a=7のとき
				if(i == 1 && j == M)
					%3.の処理
					p(a,a + 1) = p(a,a + 1) .+ a_2;
					%4.の処理
					p(a,a - L) = p(a,a - L) .+ a_3;
					%5.の処理
					psai(a,1) = -a_3*100;
				else
					%a=2のとき
					if( 1 < i && i < L && j == 1)
						%2,3の処理
						p(a,a - 1) = p(a,a - 1) .+ a_2;
						p(a,a + 1) = p(a,a + 1) .+ a_3;
						%5.の処理
						p(a,a + L) = p(a,a + L) .+ a_3;
					else
						%a=5のとき
						if( 1 < i && i < L && 1 < j && j < M)
							%2,3の処理
							p(a,a - 1) = p(a,a - 1) .+ a_2;
							p(a,a + 1) = p(a,a + 1) .+ a_3;
							%4.5の処理
							p(a,a - L) = p(a,a - L) .+ a_2;
							p(a,a + L) = p(a,a + L) .+ a_3;
						else
							%a=8のとき
							if( 1 < i && i < L && j == M)
								%2,3の処理
								p(a,a - 1) = p(a,a - 1) .+ a_2;
								p(a,a + 1) = p(a,a + 1) .+ a_3;
								%4.の処理
								p(a,a - L) = p(a,a - L) .+ a_3;
								%5.の処理
								psai(a,1) = -a_3 * 100;
							else
								%a=3のとき
								if( i == L && j == 1)
									%2.の処理
									p(a,a - 1) = p(a,a + 1) .+ a_2;
									%3.の処理
									psai(a,1) = psai(a,1) .- a_2 * 100;
									%5.の処理
									p(a,a + L) = p(a,a + L) .+ a_3;
								else
									%a=6のとき
									if( i == L && 1 < j && j < M)
										%2.の処理
										p(a,a - 1) = p(a,a - 1) .+ a_2;
										%3.の処理
										psai(a,1) = psai(a,1) .- a_2 * 100;
										%4.5の処理
										p(a,a - L) = p(a,a - L) .+ a_2;
										p(a,a + L) = p(a,a + L) .+ a_3;
									else
										%2.の処理
										p(a,a - 1) = p(a,a - 1) .+ a_2;
										%3.の処理
										psai(a,1) = psai(a,1) .- a_2 * 100;
										%4.の処理
										p(a,a - L) = p(a,a - L) .+ a_3;
										%5.の処理
										psai(a,1) = psai(a,1) .- a_3 * 100;
									endif
								endif
							endif
						endif
					endif
				endif
			endif
		endif
	endfor
endfor

Q = I - lambda * dt / C_p * p;

%lambda * dt * psai / C_pを計算し、Rとする
R = lambda * dt * psai / C_p;

%面全体の温度分布を配列に持つ行列をt_newとする
t_new = zeros(n,1);

%ループ処理を行う回数をkとし、温度変化の値を持つ行列をT(k×1)とする
k=100000;
T = zeros(k,1);

for i=1:k
	t_old = t_new;
	S = t_old -R;
	t_new = inv(Q) * S;
	T(i+1,1) = t_new(a,1);
endfor

disp(T);

plot(T);

%%QをLU分解する
%for i = 1:n
%	for j = i:n
%		U(i,j) = p(i,j);
%		L(j,i) = p(j,i)./p(i,i);
%	endfor
%	for j = i+1:n
%		for k = i+1:n
%			%p(j,k) = p(j,k) - p(i,k) .* L(j,i);
%		endfor
%	endfor
%endfor

