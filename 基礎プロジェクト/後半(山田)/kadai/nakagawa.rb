def nakagawa()
	width=$width
	hight=$width
	print("  ")# 0 1 2 3 4\n")
	for i in 0..(width-1) do
		print(" ",i)
	end
	print("\n")
	for i in 0..(width-1) do
		print(i," |")
		for j in 0..(hight-1) do
			if $field[i][j]	==1 then
				print("O|")
			elsif $field[i][j]==2 then
				print("X|")
			else
				print("\s|")
			end
		end
		print("\n")
	end
end
