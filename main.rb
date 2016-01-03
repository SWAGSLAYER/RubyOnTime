require 'parser'
require 'parser_utils'

source_repos_file = ARGV[0]
if ARGV[1] == nil
  source_repos_path = ParserUtils::RepositoriesUtils::SOURCE_REPOSITORIES_PATH
else
  source_repos_path = ARGV[1]
end

src_repos = ParserUtils::get_source_repositories(source_repos_file)

ParserUtils::clone_source_repositories(src_repos, dir_path)

src_repos.each do |repo|
  case repo.language
  when 'C++'
    parse_result = Parser::parse_cpp("#{source_repos_path}/#{repo.name}")
  when 'Java'
    parse_result = Parser::parse_java("#{source_repos_path}/#{repo.name}")
  when 'Ruby'
    parse_result = Parser::parse_ruby("#{source_repos_dir_path}/#{repo.name}")
  end

  parse_result.to_json()
  parse_result.to_svg()
end
