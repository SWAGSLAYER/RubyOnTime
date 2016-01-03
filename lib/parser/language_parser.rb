require_relative 'result'

module Parser
  class LanguageParser
    def parse_directory()
      # Parse the passed directory recursively
      # for each file in directory
      #   for each line in file
      #     self.parse(line)
      parse(line)
    end

    def parse(line)
      puts "Called LanguageParser's parse"
    end
  end
end
