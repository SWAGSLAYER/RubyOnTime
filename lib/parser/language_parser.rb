module Parser
  #encoding: UTF-8
  require_relative 'result'
  require_relative '../common/print_views'
  require 'filemagic'

  class LanguageParser
    IGNORED_FILES = ['.', '..', '.git']

    def initialize()
      @words_hash = Hash.new(0)
      @marks_count = 0
      @total_lines_parsed = 0
    end

    def parse_repository(repo)
      print_parsed_repo_progress(repo)
      traverse(repo.path)
      print_parsed_repo_done(repo)
      Result.new(repo, @words_hash, @marks_count, @total_lines_parsed)
    end

    private
    def parse_file(path)
      print_parsed_file_progress(path)
      IO.foreach(path, mode: "r", encoding: "ISO-8859-1") do |line|
        parse_line(line.encode("utf-8", replace: nil))
        @total_lines_parsed += 1
      end
      print_parsed_file_done()
    end

    private
    def parse_line(line)
      @marks_count += line.scan(/[[:punct:]=`~$^+|<>]/).count
      line_words = line.downcase.scan(/\w+/)
      line_words.each do |word|
        @words_hash[word] += 1
      end
    end

    private
    def traverse(path)
      Dir.entries(path).each do |name|
        if IGNORED_FILES.include?(name)
          next
        end

        new_path = path + '/' + name
        if File.ftype(new_path) == 'directory'
          traverse(new_path)
        else
          if is_textfile?(new_path)
            parse_file(new_path)
          end
        end
      end
    end

    private
    def is_textfile?(filename)
      begin
        fm = FileMagic.new(FileMagic::MAGIC_MIME)
        fm.file(filename) =~ /^text\//
      ensure
        fm.close
      end
    end
  end
end
