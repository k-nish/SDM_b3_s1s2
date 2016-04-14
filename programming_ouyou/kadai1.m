%初期設定(M,L)
M=3;
L=3;
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
end

%fを(M+1)*(L+1)のゼロ行列として作成
f = zeros(M + 1,L + 1);
%境界条件を設定
%f(:,1) = 0;
%f(M + 1,:) = 0;
%f(:,L + 1) = 100;
%f(1,:) = 100;


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
		%a=4のとき
		else if(i == 1 && 1 < j && j < M)
			%3.の処理
			p(a,a + 1) = a_2;
			%4.5.の処理
			p(a,a - L) = a_2;
			p(a,a + L) = a_3;
		%a=7のとき
		else if(i == 1 && j == M)
			%3.の処理
			p(a,a + 1) = a_2;
			%4.の処理
			p(a,a - L) = a_3;
			%5.の処理
			psai(a,1) = -a_3*100;
		%a=2のとき
		else if( 1 < i && i < L && j == 1)
			%2,3の処理
			p(a,a-1) = a_2;
			p(a,a+1) = a_3;
			%5.の処理
			p(a,a + L) = a_3;
		%a=5のとき
		else if( 1 < i && i < L && 1 < j && j < M)
			%2,3の処理
			p(a,a-1) = a_2;
			p(a,a+1) = a_3;
			%4.5の処理
			p(a,a - L) = a_2;
			p(a,a + L) = a_3;
		%a=8のとき
		else if( 1 < i && i < L && j == M)
			%2,3の処理
			p(a,a-1) = a_2;
			p(a,a+1) = a_3;
			%4.の処理
			p(a,a - L) = a_3;
			%5.の処理
			psai(a,1) = -a_3 * 100;
		%a=3のとき
		else if( i == L && j == 1)
			%2.の処理
			p(a,a - 1) = a_2;
			%3.の処理
			psai(a,1) = psai(a,1) .- a_2 * 100;
			%5.の処理
			p(a,a + L) = a_3;
		%a=6のとき
		else if( i == L && 1 < j && j < M)
			%2.の処理
			p(a,a - 1) = a_2;
			%3.の処理
			psai(a,1) = psai(a,1) .- a_2 * 100;
			%4.5の処理
			p(a,a - L) = a_2;
			p(a,a + L) = a_3;
		%a=9のとき
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

f = inv(p) * psai;
f = flipud(f);
f = reshape(f(1:9),3,3);
f = fliplr(f);

disp(p);
disp(f);
disp(psai);