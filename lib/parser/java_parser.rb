module Parser
  class JavaParser < LanguageParser
    def parse_directory(dir_path)
      super.parse_directory(dir_path)
    end

    def parse(line)
      puts "Called JavaParser's parse"
    end
  end
end
