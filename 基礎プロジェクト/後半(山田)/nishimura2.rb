# 0である座標の評価値を取得し、配列zeroにいれる
# 配列zeroにある中で評価値が最大となる座標を取得する
def nishimura()
	zeros =[]
	for i in 0..4 do
		for j in 0..4 do
			if $field[i][j] == 0
				$value = toyoda(i,j,$enemy)
				zeros.push([i,j,$value])
			end
		end
	end

	point = [zeros[0][0],zeros[0][1]]
	value = zeros[0][2]
	for k in zeros do
		if zeors[k][2] > value
			point = [zeros[k][1],zeros[k][2]]
		end
	end

return point
end




