require_relative 'parser/language_parser'
require_relative 'parser/cpp_parser'
require_relative 'parser/java_parser'
require_relative 'parser/ruby_parser'
require_relative 'parser/result'

module Parser
  def self.parse_cpp(repo)
    CPPParser.new.parse_repository(repo)
  end

  def self.parse_java(repo)
    JavaParser.new.parse_repository(repo)
  end

  def self.parse_ruby(repo)
    RubyParser.new.parse_repository(repo)
  end
end
