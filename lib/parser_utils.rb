require_relative 'parser_utils/repositories_utils'
require_relative 'parser_utils/repository'

module ParserUtils
  def self.get_source_repositories(file_path)
    RepositoriesUtils::parse_from_text_file(file_path)
  end

  def self.clone_source_repositories(dir_path)
    RepositoriesUtils::clone_all(dir_path)
  end
end
