require_relative 'result'

module Parser
  class LanguageParser
    def initialize()
      @words_hash = Hash.new(0)
      @marks_count = 0
      @total_lines_parsed = 0
    end

    def parse_repository(repo)
      traverse(repo.path)
      Result.new(repo, @words_hash, @marks_count, @total_lines_parsed)
    end

    private
    def parse_file(path)
      File.open(path).each_line do |line|
        parse_line(line)
        @total_lines_parsed += 1
      end
    end

    private
    def parse_line(line)
      line_words = line.downcase.scan(/\w+/)
      line_words.each do |word|
        @words_hash[word] += 1
      end

      @marks_count += line_words.scan(/[[:punct:]=`~$^+|<>]/).count
    end

    private
    def traverse(path)
      Dir.entries(path).each do |name|
        if name == '.' || name == '..'
          next
        end

        new_path = path + '/' + name
        if File.ftype(new_path) == 'directory'
          traverse(new_path)
        else
          parse_file(new_path)
        end
      end
    end
  end
end
