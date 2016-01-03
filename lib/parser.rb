require_relative 'parser/language_parser'
require_relative 'parser/cpp_parser'
require_relative 'parser/java_parser'
require_relative 'parser/ruby_parser'
require_relative 'parser/result'

module Parser
  def self.parse_cpp(dir_path)
    CPPParser.new.parse_directory(dir_path)
  end

  def self.parse_java(dir_path)
    JavaParser.new.parse_directory(dir_path)
  end

  def self.parse_ruby(dir_path)
    RubyParser.new.parse_directory(dir_path)
  end
end
