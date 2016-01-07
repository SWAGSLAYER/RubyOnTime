module Parser
	require './result'
	
  class LanguageParser
    def initialize()
      @words_hash = {}
      @marks_count = 0
      @total_lines_parsed = 0
    end

    def parse_repository(repo)
      Dir.glob(repo + '/**/*.{rb,cpp,cc,java}') do |file|
      	parse_file(file)
      end
      Result.new(repo, @words_hash, @marks_count, @total_lines_parsed)
    end

    private
    def parse_file(path)
      File.open(path, 'r').each do |line|
        parse_line(line)
        @total_lines_parsed += 1
      end
    end

		private
		def parse_line(line)
			@marks_count += line.scan(/[[:punct:]=`~$^+|<>]/).count
			line = line.downcase.scan(/[\w]+/)
					
			line.each do |word|
				if @words_hash.key?(word)
					@words_hash[word] += 1 
				else
					@words_hash[word] = 1
				end
			end
		end
  end
end
