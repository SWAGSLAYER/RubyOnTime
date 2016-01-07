module Parser
  class RubyParser < LanguageParser
    def parse_repository(repo)
      super.parse_directory(repo.path)
    end
  end
end
