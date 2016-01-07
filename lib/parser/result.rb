module Parser
  require '../common/language_filemappings'
  require 'json'

  class Result
    attr_reader :words_hash, :marks_count

    def initialize(repo, words_hash, marks_count, lines_parsed)
      @repository = repo
      @words_hash = self.sort(words_hash)
      @marks_count = marks_count
      @lines_parsed = lines_parsed
    end

    def to_json
      hash_format = { words: word_counts, marks: marks_count }

      json_filename_mappings = LanguageFilemappings.get_json_filenames()
      File.open(json_filename_mappings[@repository.language]), "w") do |f|
        f.write(hash_format.to_json)
      end
    end

    def to_svg
      svg_filename_mappings = LanguageFilemappings.get_svg_filenames()
      # File.open(svg_filename_mappings[@repository.language]), "w") do |f|
        # Pesho's magic here
      # end
    end

		private
    def sort(words_hash)
      # Return the sorted hash here
      @words_hash = @words_hash.sort_by { |word, occurences| [-occurences, word] }
      @words_hash.to_h
    end
  end
end
