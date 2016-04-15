%初期設定(M,L)
M=3;
L=3;
n=M * L;
dx = 0.1 / ( M + 1);
dy = 0.1 / ( L + 1);

%x,y両方向の差分逆数二乗和の二倍をa_1とし、またx,y方向の差分逆数二乗をそれぞれa_2,a_3とする
a_1 = -2 / dx^2 - 2 / dy^2;
a_2 = 1 / dx^2;
a_3 = 1 / dy^2;


%pを単位行列として作成
p = eye(M * L);


%対角項にa_1を代入
for i = 1: size(p)
	p(i,i) = a_1;
endfor

%fを(M+1)*(L+1)のゼロ行列として作成
f = zeros(M + 1,L + 1);

%psaiをML*1のゼロ行列として作成
psai = zeros(M * L,1);

for i=1:L
	for j=1:M
		%aを定義
		a = (j - 1) * L + (i - 1) + 1;
		%a = 1のとき
		if(i == 1 && j ==1)
			%3.の処理
			p(a,a + 1) = a_2;
			%5.の処理
			p(a,a + L) = a_3;
		else
			%a=4のとき
			if(i == 1 && 1 < j && j < M)
				%3.の処理
				p(a,a + 1) = a_2;
				%4.5.の処理
				p(a,a - L) = a_2;
				p(a,a + L) = a_3;
			else
				%a=7のとき
				if(i == 1 && j == M)
					%3.の処理
					p(a,a + 1) = a_2;
					%4.の処理
					p(a,a - L) = a_3;
					%5.の処理
					psai(a,1) = -a_3*100;
				else
					%a=2のとき
					if( 1 < i && i < L && j == 1)
						%2,3の処理
						p(a,a-1) = a_2;
						p(a,a+1) = a_3;
						%5.の処理
						p(a,a + L) = a_3;
					else
						%a=5のとき
						if( 1 < i && i < L && 1 < j && j < M)
							%2,3の処理
							p(a,a-1) = a_2;
							p(a,a+1) = a_3;
							%4.5の処理
							p(a,a - L) = a_2;
							p(a,a + L) = a_3;
												%a=8のとき
						else
							%a=8のとき
							if( 1 < i && i < L && j == M)
								%2,3の処理
								p(a,a-1) = a_2;
								p(a,a+1) = a_3;
								%4.の処理
								p(a,a - L) = a_3;
								%5.の処理
								psai(a,1) = -a_3 * 100;
							else
								%a=3のとき
								if( i == L && j == 1)
									%2.の処理
									p(a,a - 1) = a_2;
									%3.の処理
									psai(a,1) = psai(a,1) .- a_2 * 100;
									%5.の処理
									p(a,a + L) = a_3;
								else
									%a=6のとき
									if( i == L && 1 < j && j < M)
										%2.の処理
										p(a,a - 1) = a_2;
										%3.の処理
										psai(a,1) = psai(a,1) .- a_2 * 100;
										%4.5の処理
										p(a,a - L) = a_2;
										p(a,a + L) = a_3;
									else
										%2.の処理
										p(a,a - 1) = a_2;
										%3.の処理
										psai(a,1) = psai(a,1) .- a_2 * 100;
										%4.の処理
										p(a,a - L) = a_3;
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

%p=L*Uを満たすL(下三角行列),U(上三角行列)を計算する
%L,Uをそれぞれ(L+1)×(M+1)のゼロ行列として初期化
L = zeros(n);
U = zeros(n);

%L,Uを計算する
for i = 1:n
	for j = i:n
		U(i,j) = p(i,j);
		L(j,i) = p(j,i)./p(i,i);
	endfor
	for j = i+1:n
		for k = i+1:n
			p(j,k) = p(j,k) - p(i,k) .* L(j,i);
		endfor
	endfor
endfor

%LY=psaiを満たすYを求める
%Yをn×1のゼロ行列として初期化
Y = zeros(n,1);

%Yを求める
Y(1,1) = psai(1,1);
for k = 2:n
	Y(k,1) = psai(k,1);
	for i = 1:k
		Y(k,1) = Y(k,1) .- L(k,i).*Y(k,1);
	endfor
endfor

%UX=Yを満たすXを求める
%Xをn×1のゼロ行列として初期化
X = zeros(n,1);

%Xを求める
X(n,1) = Y(n,1) ./ U(n,n);
for k = 1;n-1
	X(n-k,1) = Y(n-k,1);
	for i = 1:k-1
		X(n-k,1) = X(n-k,1) - U(n-k,n-1).*X(n-i,1);
	endfor
	X(n-k,1) = X(n-k,1)./U(n-k,n-k);
endfor

%disp(p);
%disp(f);
disp(psai);
%disp(L);
disp(Y);