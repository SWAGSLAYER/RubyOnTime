class LanguageFilemappings
  def self.get_json_filenames
    json_filenames = {
      "Ruby" => "ruby.json",
      "C++" => "cpp.json",
      "Java" => "java.json"
    }
  end

  def self.get_svg_filenames
    get_svg_filenames = {
      "Ruby" => "ruby.svg",
      "C++" => "cpp.svg",
      "Java" => "java.svg"
    }
  end
end
