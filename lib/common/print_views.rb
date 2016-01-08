require_relative 'string_extensions'

def print_parsed_file_progress(path)
  print "Parsing file #{path}..."
end

def print_parsed_file_done
  print "[" + "ok".green + "]"
  puts
end

def print_parsed_repo_progress(repo)
  puts "Parsing repository #{repo.path}..."
end

def print_parsed_repo_done(repo)
  puts "Parsing repository #{repo.path}...[" + "done".green + "]"
end
