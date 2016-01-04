module Parser
	
	require 'json'

	class Result
    		attr_reader :words_hash, :marks_count

   		def initialize(words_hash, marks_count)
      			@words_hash = self.sort(words_hash)
      			@marks_count = marks_count
    		end

    		def to_json
    		
    			hash_format = { words: word_counts, marks: marks_count }
    			
    			case repo.language
  				when 'C++'
  					File.open("cpp.json", "w") do |f|
  						f.write(hash_format.to_json)
  					end
  				when 'Java'
   					File.open("java.json", "w") do |f|
  						f.write(hash_format.to_json)
  					end
  				when 'Ruby'
    			 		File.open("ruby.json", "w") do |f|
  						f.write(hash_format.to_json)
					end
  			end
    			#JSON.pretty_generate(hash_format)
      			puts "Vanessa's magic here"
    		end

    		def to_svg
      			puts "Pesho's magic here"
    		end

    		def sort(words_hash)
      			# Return the sorted hash here
      			words_hash
    		end

    	private :sort
  	end
end
