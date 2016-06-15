# $kawakami = ["1","%","2","3","%","4","5","%","9","A"]
require './kawakami.rb'
$nishimura = []
for var in $kawakami do
	if var != "%" then
		$nishimura.push(var)
	end
end
print ($nishimura)
