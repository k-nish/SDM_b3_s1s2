#4文字並べを行うコード
require "./nishimura.rb"
require "./fujimura.rb"
require "./nakagawa.rb"
require "./kawakami.rb"
require "./shibasaki.rb"
require "./toyoda.rb"

puts '5×5マスの4目並べへようこそ。手を入力するときは半角スペースを間にいれて座標を代入しenterを押してください'
num = 1 #rand(2) + 1
$width = 5
$field = Array.new($width){Array.new($width){0}}
$win = 0

# 最初の一手
nakagawa()
if num == 2
	$human = 1
	$ai = 2
	puts 'あなたが先手です。最初の手を入力してください'
	array = input()
	isEnable($field, array[0], array[1])
	$field = shibasaki(array[0],array[1], 1, $field)
	nakagawa()
else
	$human = 2
	$ai = 1
	puts 'AIが先手です。'
end

turn = num
while fujimura() == false
	if turn %2 == num
		array = nishimura()
		isEnable($field, array[0], array[1])
=begin
		field = Array.new(5,Array.new(5))
		for o in 0..4
			for l in 0..4
				field[o][l] = $field[o][l]
			end
		end
=end
		$field = shibasaki(array[0], array[1], $ai, $field)
		#p $field
		nakagawa()
	else
		puts '次の手を入力してください'
		array = input()
		isEnable($field, array[0], array[1])
		$field = shibasaki(array[0], array[1], $human, $field)
		#p $field
		nakagawa()
	end
	turn += 1
end

if $win == num
	print 'AIの勝ち!'
elsif $win == 0
	print '引き分け!'
else
	print 'あなたの勝ち!'
end
