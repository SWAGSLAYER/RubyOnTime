module Parser
  class RubyParser < LanguageParser
    def parse_directory(dir_path)
      super.parse_directory(dir_path)
    end

    def parse(line)
      puts "Called RubyParser's parse"
    end
  end
end
