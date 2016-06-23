# 0である座標の評価値を取得し、配列zeroにいれる
# 配列zeroにある中で評価値が最大となる座標を取得する
def nishimura()
	zeros =[]
	list = [2, 1, 3, 0, 4]
	for o in 0..$width - 1 do
		for l in 0..$width - 1 do
			i = list[o]
			j = list[l]
			if $field[i][j] == 0 then
				value = toyoda(i,j,$ai)
				zeros.push([i,j,value])
			end
		end
	end

	point = [zeros[0][0],zeros[0][1]]
	max = zeros[0][2]
	for k in 0..zeros.length()-1 do
		if zeros[k][2] > max then
			max = zeros[k][2]
			point = [zeros[k][0],zeros[k][1]]
		end
	end
p zeros
p point
return point
end




