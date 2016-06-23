#4文字並べを行うコード
require "./nishimura.rb"
require "./fujimura.rb"
require "./nakagawa.rb"
require "./kawakami.rb"
require "./shibasaki.rb"
require "./toyoda.rb"

puts '5×5マスの4目並べへようこそ。手を入力するときは半角スペースを間にいれて座標を代入しenterを押してください'
num = rand(2) + 1
$field = Array.new(5, Array.new(5,0))
$win = 0
# 最初の一手
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
		$field = shibasaki(array[0], array[1], $ai, $field)
		nakagawa()
	else
		puts '次の手を入力してください'
		array = input()
		isEnable($field, array[0], array[1])
		$field = shibasaki(array[0], array[1], $human, $field)
		nakagawa()
	end
	turn += 1
end

if $win == num
	print 'AIの勝ち!'
else
	print 'あなたの勝ち!'
end
