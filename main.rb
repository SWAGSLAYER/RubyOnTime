require 'parser'
require 'parser_utils'

STATISTICS_FILENAME = 'repositories.csv'

source_repos_file = ARGV[0]
if ARGV[1] == nil
  source_repos_path = ParserUtils::RepositoriesUtils::SOURCE_REPOSITORIES_PATH
else
  source_repos_path = ARGV[1]
end

src_repos = ParserUtils::get_source_repositories(source_repos_file)

ParserUtils::clone_source_repositories(src_repos, source_repos_path)

parse_results = []
src_repos.each do |repo|
  case repo.language
  when 'C++'
    result = Parser::parse_cpp(repo)
  when 'Java'
    result = Parser::parse_java(repo)
  when 'Ruby'
    result = Parser::parse_ruby(repo)
  end

  result.to_json()
  result.to_svg()
  parse_results.push(result)
end

# July's stuff :)
# RepositoriesUtils::get_statistics(STATISTICS_FILENAME, src_repos, parse_results)
