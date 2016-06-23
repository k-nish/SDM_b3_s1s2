require "./nishimura.rb"
require "./fujimura.rb"
require "./nakagawa.rb"
require "./kawakami.rb"
require "./shibasaki.rb"
#require "./toyoda.rb"
def toyoda(i,j,ai)
	#field2 = []
	#array = []
	field = Array.new($width){Array.new($width)}
	for o in 0..4
		for l in 0..4
			field[o][l] = $field[o][l]
		end
	end

	field2 = shibasaki(i,j,ai,field)

	array = kawakami(field2,ai)
	enemy = kawakami(field2,3-ai)
	toyoda_value = 1*array[0] + 2*array[1] + 3*array[2] + 10*array[3] + 10000*array[4] - 3*enemy[1] - 15*enemy[2] - 10*enemy[3] - 10*enemy[4]
return toyoda_value
end
