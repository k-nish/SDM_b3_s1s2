
def kawakami(field,color)
	dir = [[1,1],[1,0],[1,-1],[0,1],[0,-1],[-1,1],[-1,0],[-1,-1]]
	result = [0,0,0,0,0]
	for i in 0..4
		for j in 0..4
			for k in 0..7
				if (i+dir[k][0])*(i+dir[k][0]-4)<=0 && (j+dir[k][1])*(j+dir[k][1]-4)<=0 then #1つ先が範囲内か
					if field[i][j] == color && field[i+dir[k][0]][j+dir[k][1]] == 0 then #1つ先が空白なら端になる
						if (i-dir[k][0])*(i-dir[k][0]-4)<=0 && (j-dir[k][1])*(j-dir[k][1]-4)<=0 then
							if field[i-dir[k][0]][j-dir[k][1]] == field[i][j] then #1つ戻ると同色か
								if (i-2*dir[k][0])*(i-2*dir[k][0]-4)<=0 && (j-2*dir[k][1])*(j-2*dir[k][1]-4)<=0 then
									if field[i-2*dir[k][0]][j-2*dir[k][1]] == field[i][j] then
										if (i-3*dir[k][0])*(i-3*dir[k][0]-4)<=0 && (j-3*dir[k][1])*(j-3*dir[k][1]-4)<=0 then
											if field[i-3*dir[k][0]][j-3*dir[k][1]] == field[i][j] then
												#if (i-4*dir[k][0])*(i-4*dir[k][0]-4)<=0 && (j-4*dir[k][1])*(j-4*dir[k][1]-4)<=0 then
												#	if field[i-4*dir[k][0]][j-4*dir[k][1]] == field[i][j] then
														result[4] += 1 #4連鎖1端
												#	end
												#end

											elsif field[i-3*dir[k][0]][j-3*dir[k][1]] != 0
												result[2] += 1 #3連鎖1端
											else
												result[3] += 1 #3連鎖0端
											end
										else
											result[2] += 1 #3連鎖1端
										end
									elsif field[i-2*dir[k][0]][j-2*dir[k][1]] != 0
										result[0] += 1 #2連鎖1端
									else
										result[1] += 1 #2連鎖0端
									end
								else
									result[0] += 1 #2連鎖1端
								end
							end
						end
					end
				end
			end
		end
	end

	result[1] = result[1]/2
	result[3] = result[3]/2

	for i in 0..4
		for j in 0..4
			for k in 0..7
				if (i+dir[k][0])*(i+dir[k][0]-4)<=0 && (j+dir[k][1])*(j+dir[k][1]-4)<=0 then #1つ先が範囲内か
					if field[i][j] == color && field[i+dir[k][0]][j+dir[k][1]] != 0 && field[i+dir[k][0]][j+dir[k][1]] != color  then #1つ先が空白なら端になる
						if (i-dir[k][0])*(i-dir[k][0]-4)<=0 && (j-dir[k][1])*(j-dir[k][1]-4)<=0 then
							if field[i-dir[k][0]][j-dir[k][1]] == field[i][j] then #1つ戻ると同色か
								if (i-2*dir[k][0])*(i-2*dir[k][0]-4)<=0 && (j-2*dir[k][1])*(j-2*dir[k][1]-4)<=0 then
									if field[i-2*dir[k][0]][j-2*dir[k][1]] == field[i][j] then
										if (i-3*dir[k][0])*(i-3*dir[k][0]-4)<=0 && (j-3*dir[k][1])*(j-3*dir[k][1]-4)<=0 then
											if field[i-3*dir[k][0]][j-3*dir[k][1]] == field[i][j] then
												result[4] += 1 #4連鎖2端
											end
										end
									end
								end
							end
						end
					end
				else
					if field[i][j] == color then
						if (i-dir[k][0])*(i-dir[k][0]-4)<=0 && (j-dir[k][1])*(j-dir[k][1]-4)<=0 then
							if field[i-dir[k][0]][j-dir[k][1]] == field[i][j] then #1つ戻ると同色か
								if (i-2*dir[k][0])*(i-2*dir[k][0]-4)<=0 && (j-2*dir[k][1])*(j-2*dir[k][1]-4)<=0 then
									if field[i-2*dir[k][0]][j-2*dir[k][1]] == field[i][j] then
										if (i-3*dir[k][0])*(i-3*dir[k][0]-4)<=0 && (j-3*dir[k][1])*(j-3*dir[k][1]-4)<=0 then
											if field[i-3*dir[k][0]][j-3*dir[k][1]] == field[i][j] then
												result[4] += 1 #4連鎖2端
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	result[4] = result[4]/2
	return result

end

def isEnable(field,x,y)
	if field[x][y]==0 then
		return true
	else
		return false
	end
end

def input()
	ip = STDIN.gets
	result = Array.new(2,0)
	result[0] = ip[0].to_i
	result[1] = ip[2].to_i
	
	p ip
	p result
	return result
end

def decidecolor()
	ip = STDIN.gets
	ip.to_i
	return ip
end

=begin
a = [
[0,0,0,1,2],
[0,2,1,1,2],
[1,1,1,2,0],
[1,2,2,1,0],
[0,1,1,2,2]]
print(kawakami(a,1))
p a
=end
