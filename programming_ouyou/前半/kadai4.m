clear all;
%初期設定M,L,n,I
M = 11;
L = 11;
n = M * L;
I = eye(n);

%初期設定(eta,mu,dt,d,fを決める)
eta = 2 * 10^(-8); %etaは電気抵抗率
mu = 4 * pi * 10^(-7); %muは真空の透磁率
dt = 0.0025; %dtはシミュレーションの時間間隔
d = 0.01; %dは銅板の厚さ
f = 1; %fは周波数

%A点の座標を求めるためのaを設定
a = (((n + 1) / 2) + 1)/2;

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
		if(i == 1 && j == 1)
			%3.の処理
			p(a,a + 1) = p(a,a + 1) .+ a_2;
			%5.の処理
			p(a,a + L) = p(a,a + L) .+ a_3;
		else
			if(i == 1 && 1 < j && j < M)
				%3.の処理
				p(a,a + 1) = p(a,a + 1) .+ a_2;
				%4.5.の処理
				p(a,a - L) = p(a,a - L) .+ a_2;
				p(a,a + L) = p(a,a + L) .+ a_3;
			else
				if(i == 1 && j == M)
					%3.の処理
					p(a,a + 1) = p(a,a + 1) .+ a_2;
					%4.の処理
					p(a,a - L) = p(a,a - L) .+ a_3;
					%5.の処理
					psai(a,1) = -a_3 * 0;
				else
					if( 1 < i && i < L && j == 1)
						%2,3の処理
						p(a,a - 1) = p(a,a - 1) .+ a_2;
						p(a,a + 1) = p(a,a + 1) .+ a_3;
						%5.の処理
						p(a,a + L) = p(a,a + L) .+ a_3;
					else
						if( 1 < i && i < L && 1 < j && j < M)
							%2,3の処理
							p(a,a - 1) = p(a,a - 1) .+ a_2;
							p(a,a + 1) = p(a,a + 1) .+ a_3;
							%4.5の処理
							p(a,a - L) = p(a,a - L) .+ a_2;
							p(a,a + L) = p(a,a + L) .+ a_3;
						else
							if( 1 < i && i < L && j == M)
								%2,3の処理
								p(a,a - 1) = p(a,a - 1) .+ a_2;
								p(a,a + 1) = p(a,a + 1) .+ a_3;
								%4.の処理
								p(a,a - L) = p(a,a - L) .+ a_3;
								%5.の処理
								psai(a,1) = -a_3 * 0;
							else
								if( i == L && j == 1)
									%2.の処理
									p(a,a - 1) = p(a,a + 1) .+ a_2;
									%3.の処理
									psai(a,1) = psai(a,1) .- a_2 * 0;
									%5.の処理
									p(a,a + L) = p(a,a + L) .+ a_3;
								else
									if( i == L && 1 < j && j < M)
										%2.の処理
										p(a,a - 1) = p(a,a - 1) .+ a_2;
										%3.の処理
										psai(a,1) = psai(a,1) .- a_2 * 0;
										%4.5の処理
										p(a,a - L) = p(a,a - L) .+ a_2;
										p(a,a + L) = p(a,a + L) .+ a_3;
									else
										%2.の処理
										p(a,a - 1) = p(a,a - 1) .+ a_2;
										%3.の処理
										psai(a,1) = psai(a,1) .- a_2 * 0;
										%4.の処理
										p(a,a - L) = p(a,a - L) .+ a_3;
										%5.の処理
										psai(a,1) = psai(a,1) .- a_3 * 0;
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

%Q2を計算する
Q2 = zeros(n);
for i=1:L
	for j=1:M
		alpha = (j - 1) * L + (i - 1) + 1;
		r_alpha = [i * dx ; j * dy ; 0];

		for k=1:L
			for l=1:M
				beeta = (l - 1) * L + (k - 1) + 1;
				r_beta = [k * dx; l * dy; d/2];

				%r_alphaとr_betaの距離の3乗を計算し、rとする
				r = sum((r_alpha .- r_beta).^2)^(3/2);

				Q2(alpha,beeta) = -mu * d * dx * dy / (4 * pi * r);
			endfor
		endfor
	endfor
endfor

%Q1,P2を計算する
Q1 = mu * eye(n);
P2 = eta * p;

%面全体の電流ベクトルポテンシャルを配列に持つ行列をM_newとする
M_new = zeros(n,1);

%ループ処理を行う回数をkとし、温度変化の値を持つ行列をT(k×1)とする
k=128; %課題1をやるためには600にすればよい
T = zeros(k+1,2);

%S1 * M_new = S2 * M_old - RとなるようにS1,S2を設定する
	S1 = (Q1 - Q2)/dt - P2;
	S2 = (Q1 - Q2)/dt;

%Mを計算し、A点付近の電流密度を行列Tに格納する
for i=1:k
	%Rを計算する
	R = 2 * pi * f * sin(2 * pi * f * i * dt) * ones(n,1);

	M_old = M_new;
	M_new = inv(S1) * (S2 * M_old .- R);
	J_x = (M_new(42,1) - M_new(20,1)) / (2*dy);
	J_y = -(M_new(32,1) - M_new(30,1)) / (2*dx);
	T(i + 1,1) = J_x;
	T(i + 1,2) = J_y;
endfor
% disp(T); %課題1ではここのコメントアウトを外す
% plot(T); %課題1ではここのコメントアウトを外す

%M_newの整形
M_new = flipud(M_new);
M_new = reshape(M_new(1:n),M,11);
M_new = fliplr(M_new);

% disp(M_new);

JX = [];
JY = [];
for s=1:9
	for t=1:9
		jx = (M_new(s+1,10-t) - M_new(s+1,12-t)) / (2*dy);
		jy = -(M_new(s+2,11-t) - M_new(s,11-t)) / (2*dx);
		JX = [JX ; jx(1) * 3E-9];
		JY = [JY ; jy(1) * 3E-9];
		%ベクトルのプロット
		q = (s-1) * 9 + t;
		hold on;
		x = (s + 1) * dx;
		y = (t + 1) * dy;
		q
		x
		y
		JX(q)
		JY(q)
		quiver(x,y,JX(q),JY(q));
	endfor
endfor
% hold off;
% [x,y] = meshgrid(dx*2:dx:0.1-dx*2,dy*2:dy:0.1-dy*2);
% x2 = x / dx - 1;
% y2 = y / dy - 1;
% q = (x2 -1) * 9 + y2;
% u = JX(q);
% v = JY(q);
% figure
% quiver(x,y,u,v)


% disp(JX);
% disp("JYは下");
% disp(JY);