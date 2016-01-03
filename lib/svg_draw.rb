my_hash = Hash.new

my_hash["word"] = 2000
my_hash["coolqw"] = 1900
my_hash["coowql"] = 1850
my_hash["cowewol"] = 1800
my_hash["cosadasol"] = 1743
my_hash["ew"] = 1700
my_hash["newwe"] = 1666
my_hash["new"] = 1666
my_hash["ship"] = 1500
my_hash["well"] = 1500
my_hash["okey"] = 1500
my_hash["qweqw"] = 1444
my_hash["cooedl"] = 1432
my_hash["cowqol"] = 1400
my_hash["coosl"] = 1355
my_hash["sure"] = 1300
my_hash["ehasdaaetads"] = 1230
my_hash["kk"] = 900
my_hash["kke"] = 900
my_hash["yesbo"] = 666
my_hash["53"] = 534
my_hash["asq"] = 503
my_hash["aswq"] = 503
my_hash["asesq"] = 503
my_hash["zxcas"] = 485
my_hash["hdasd"] = 450
my_hash["w"] = 320
my_hash["eve"] = 160
my_hash["flash"] = 100
my_hash["cool"] = 30
my_hash["cooel"] = 30
my_hash["coowl"] = 30
my_hash["shit"] = 1

SPACE_BETWEEN_BARS = 24
new_space = -24
highest_count = 0
height = 0
red = 255
green = 0
blue = 0
counter = 0
color = 1530/my_hash.size
my_hash.each do |a,count|
	if count >= highest_count
		highest_count = count
	end
end

File.open("Graphic.svg", "w") do |file|
  file.puts "<?xml version='1.0'?>"
  file.puts "<svg width='#{my_hash.size*SPACE_BETWEEN_BARS}' height='700' style='background: white' xmlns='http://www.w3.org/2000/svg'>"
	file.puts "<rect width='#{my_hash.size*SPACE_BETWEEN_BARS}' height='700' style='fill:rgb(0,0,0)' />"
	my_hash.each do |word,count|
		counter += 1
		if counter <= (my_hash.size)*1/6
			green += color
		elsif counter <= (my_hash.size)*2/6 and counter >= (my_hash.size)*1/6
			red -= color
		elsif counter <= (my_hash.size)*3/6 and counter >= (my_hash.size)*2/6
			blue += color
		elsif counter <= (my_hash.size)*4/6 and counter >= (my_hash.size)*3/6
			green -= color
		elsif counter <= (my_hash.size)*5/6 and counter >= (my_hash.size)*4/6
			red += color
		elsif counter >= (my_hash.size)*5/6
			blue -= color
		end
		new_space += SPACE_BETWEEN_BARS
		height = (count*500/highest_count)
		word_color = "#{red},#{green},#{blue}"
		if height <= 1
			height = 1
		end
		file.puts "<rect x='#{new_space}' y='#{500-height}' width='#{SPACE_BETWEEN_BARS}' height='#{height}' style='fill:rgb(#{word_color})' />"
		file.puts "<text transform='translate(#{new_space+5},510)rotate(90)' font-family='Arial' font-size='24px' style='fill:rgb(#{word_color})'> #{word} </text>"
	end
	file.puts "</svg>"
end
