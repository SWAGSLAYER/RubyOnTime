module Parser
  class CPPParser < LanguageParser
    def parse_directory(dir_path)
      super.parse_directory(dir_path)
    end

    def parse(line)
      puts "Called CPPParser's parse"
    end
  end
end
