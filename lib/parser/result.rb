module Parser
  class Result
    attr_reader :words_hash, :marks_count

    def initialize(words_hash, marks_count)
      @words_hash = self.sort(words_hash)
      @marks_count = marks_count
    end

    def to_json
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
