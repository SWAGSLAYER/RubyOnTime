require 'uri'
require 'net/http'
require 'openssl'

module ParserUtils
  class Repository
    attr_accessor :url, :name, :owner, :language, :path

    def initialize(url, name, owner, language)
      @url = url.strip
      @name = name
      @owner = owner
      @language = language
    end

    def self.from_url(url)
      url = url.strip
      name = URI.parse(url).path.split('/').last
      owner = URI.parse(url).path.split('/')[-2]
      language = get_repo_language(name, owner)
      Repository.new(url, name, owner, language)
    end

    def self.get_repo_language(name, owner)
      uri = URI("https://api.github.com/repos/#{owner}/#{name}/languages");
      http_client = Net::HTTP.new(uri.host, uri.port)
      http_client.use_ssl = true
      http_client.verify_mode = OpenSSL::SSL::VERIFY_NONE # MITM but who cares

      response = http_client.get(uri.request_uri)
      languages_hash = JSON.parse(response.body)
      languages_hash.keys[0]
    end
  end
end
