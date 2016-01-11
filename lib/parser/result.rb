module Parser
  require_relative '../common/language_filemappings'
  require 'json'

  class Result
    attr_reader :words_hash, :marks_count

    def initialize(repo, words_hash, marks_count, lines_parsed)
      @repository = repo
      @words_hash = sort(words_hash)
      @marks_count = marks_count
      @lines_parsed = lines_parsed
    end

    def to_json
      hash_format = { words: @words_hash, marks: @marks_count }

      json_filename_mappings = LanguageFilemappings.get_json_filenames()
      File.open(json_filename_mappings[@repository.language], "w") do |f|
        f.write(JSON.pretty_generate(hash_format))
      end
    end

    def to_svg
			space_bars = 24
			new_space = -24
			highest_count = 0
			height = 0
			red = 255
			green = 0
			blue = 0
			counter = 0
			hash_size = (words_hash.size).to_f
			color = (1530/hash_size).to_f
			words_hash.each do |a,count|
				if count >= highest_count
					highest_count = count
				end
			end
			
      svg_filename_mappings = LanguageFilemappings.get_svg_filenames()
      File.open(svg_filename_mappings[@repository.language], "w") do |file|
				file.puts "<?xml version='1.0'?>"
				file.puts "<svg width='#{(hash_size+1)*space_bars}' height='700' style='background: white' xmlns='http://www.w3.org/2000/svg'>"
				file.puts "<rect width='#{(hash_size+1)*space_bars}' height='700' style='fill:rgb(0,0,0)' />"
				words_hash.each do |word,count|
					counter += 1
					if counter <= (hash_size)*1/6
						green += color
					elsif counter <= (hash_size)*2/6 and counter >= (hash_size)*1/6
						red -= color
					elsif counter <= (hash_size)*3/6 and counter >= (hash_size)*2/6
						blue += color
					elsif counter <= (hash_size)*4/6 and counter >= (hash_size)*3/6
						green -= color
					elsif counter <= (hash_size)*5/6 and counter >= (hash_size)*4/6
						red += color
					elsif counter >= (hash_size)*5/6
						blue -= color
					end
					new_space += space_bars
					height = (count*500/highest_count)
					word_color = "#{red.to_i},#{green.to_i},#{blue.to_i}"
					if height <= 1
						height = 1
					end
					file.puts "<rect x='#{new_space}' y='#{500-height}' width='#{space_bars}' height='#{height}' style='fill:rgb(#{word_color})' />"
					file.puts "<text transform='translate(#{new_space+5},510)rotate(90)' font-family='Arial' font-size='24px' style='fill:rgb(#{word_color})'> #{word} </text>"
				end
				height = (mark_count*500/highest_count)
				if height <= 1
					height = 1
				end
				file.puts "<rect x='#{hash_size*space_bars}' y='#{500-height}' width='#{space_bars}' height='#{height}' style='fill:rgb(255,255,255)' />"
				file.puts "<text transform='translate(#{hash_size*space_bars+5},510)rotate(90)' font-family='Arial' font-size='24px' style='fill:rgb(255,255,255)'> marks </text>"
				file.puts "</svg>"
      end
    end

    private
    def sort(words_hash)
      words_hash = words_hash.sort_by { |word, occurences| [-occurences, word] }
      words_hash.to_h
    end
  end
end
