# e(i, j)‚©‚ç(a, b)•ûŒü‚Éwinner‚Æ“¯‚¶‹Ê‚ª•À‚ñ‚Å‚¢‚ê‚Îtrue‚ğ•Ô‚·B
def winnerIs(i, j, a, b, winner)
	result = false
	if ($field[i][j] != 0) then
		row = true
		for k in 1..3
			row = row && ($field[i][j] == $field[i+k*a][j+k*b])
		end
		if row then
			if winner == 0 then
				winner = $field[i][j]
				result = true
			else
				if  winner == $field[i][j] then
					result = true
				else
					print("Error occured.\n")
				end
			end
		end
	end
	if winner != 0 then
		$win = winner
	end
	return result
end

def fujimura()
	gameEnd = false

	winner = 0
	
	gameEnd = gameEnd ||  winnerIs(0,0,1,0,winner)
	gameEnd = gameEnd ||  winnerIs(0,0,1,1,winner)
	gameEnd = gameEnd ||  winnerIs(0,0,0,1,winner)
	
	gameEnd = gameEnd ||  winnerIs(0,4,1,0,winner)
	gameEnd = gameEnd ||  winnerIs(0,4,1,-1,winner)
	gameEnd = gameEnd ||  winnerIs(0,4,0,-1,winner)
	
	gameEnd = gameEnd ||  winnerIs(4,4,-1,0,winner)
	gameEnd = gameEnd ||  winnerIs(4,4,-1,-1,winner)
	gameEnd = gameEnd ||  winnerIs(4,4,0,-1,winner)
	
	gameEnd = gameEnd ||  winnerIs(4,0,-1,0,winner)
	gameEnd = gameEnd ||  winnerIs(4,0,-1,1,winner)
	gameEnd = gameEnd ||  winnerIs(4,0,0,1,winner)
	
	for i in 1..3
		for j in 0..1
			gameEnd = gameEnd ||  winnerIs(i,j,0,1,winner)
			gameEnd = gameEnd ||  winnerIs(j,i,1,0,winner)
		end
	end
	
	for i in 0..1
		gameEnd = gameEnd ||  winnerIs(i,1-i,1,1,winner)
		gameEnd = gameEnd ||  winnerIs(i,3+i,1,-1,winner)
	end
	boo = true
	for i in 0..$width - 1
		for j in 0..$width - 1
			boo = boo && $field[i][j] != 0
		end
	end
	gameEnd = gameEnd || boo
	return gameEnd

end
