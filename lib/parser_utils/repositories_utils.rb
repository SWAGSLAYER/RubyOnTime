require_relative 'repository'
require_relative '../common/string_extensions'
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
        current_repo = Repository.from_url(repo_url)
        repositories.push(current_repo)
      end
      repositories
    end

    def self.clone_all(source_repos, dir_path = SOURCE_REPOSITORIES_PATH)
      if !git_installed?
        STDERR.puts "git is required to clone repositories"
        raise ArgumentError
      end

      source_repos.each do |repo|
        potential_path = "#{dir_path}/#{repo.name}"
        print "Cloning #{repo.url} into #{potential_path}..."
        if Dir.exists?(potential_path)
          print "[" + "exists; skipping".yellow + "]"
        else
          shell_cmd = "git clone #{repo.url.strip} #{dir_path}/#{repo.name} -q"

          if system(shell_cmd)
            print "[" + "ok".green + "]"
          else
            print "[" + "failed".red + "]"
          end
        end
        repo.path = potential_path
        puts
      end
    end

    def self.git_installed?
      stdop = system("git > /dev/null")
      result = $?
        exit_code = result.exitstatus
      return !exit_code.eql?(127)
    end

    # July's method
    def self.get_statistics(filename, src_repos, parse_results)
      # Store in an array first since disk I/O is slower to sort in place
      csv_rows = []
      src_repos.each_with_index do |repo, i|
        current_repo_result = parse_results[i]
        csv_rows[i].push([repo.url, current_repo_result.total_lines_parsed,
                          current_repo_result.words_hash.size])
      end

      # Sort csv_rows by words desc
      # Write to CSV
    end
  end
end
