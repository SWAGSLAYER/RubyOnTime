require_relative 'repository'
require 'uri'
require 'json'

module ParserUtils
  class RepositoriesUtils
    SOURCE_REPOSITORIES_PATH = "data/repositories"

    def self.parse_from_text_file(file_path)
      if !File.exists?(file_path)
        raise ArgumentError, "Cannot parse source repos from non existing file!"
      end

      repositories = []
      File.open(file_path).each_line do |repo_url|
        current_repo = Repository.new.from_url(repo_url)
        repositories.push(current_repo)
      end
      repositories
    end

    def self.clone_all(source_repos, dir_path = SOURCE_REPOSITORIES_PATH)
      if !self.git_installed()
        STDERR.puts "git is required to clone repositories"
        raise ArgumentError
      end

      source_repos.each do |repo|
        shell_cmd = "git clone #{repo.url} #{dir_path}/#{repo.name}"
        puts "Cloning #{repo.url} into #{dir_path}/#{repo.name}..."
        if system(shell_cmd)
          print "OK"
        else
          print "failed"
        end
      end
    end

    private
    def git_installed()
      stdop = system("git")
      result = $?
        exit_code = result.exitstatus
      return !exit_code.eql?(127)
    end
  end
end
