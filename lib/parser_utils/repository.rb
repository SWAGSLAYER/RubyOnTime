require 'uri'

module ParserUtils
  class Repository
    attr_reader :url, :name, :owner, :language

    # TODO: Fix overloading here
    def initialize(url, name, owner, language)
      @url = url
      @name = name
      @owner = owner
      @language = language
    end

    def from_url(url)
      @url = url
      @name = URI(url).path.split('/').last
      @owner = URI(url).path.split('/')[-2]
      @language = get_repo_language(url)
    end

    private
    def get_repo_language(name, owner)
      uri = URI("https://api.github.com/repos/#{owner}/#{repo_name}/languages");
      http_client = Net::HTTP.new(uri.host, uri.port)
      http_client.use_ssl = true
      http_client.verify_mode = OpenSSL::SSL::VERIFY_NONE # MITM but who cares

      response = http_client.get(uri.request_uri)
      languages_hash = JSON.parse(response)
      languages_hash.keys[0]
    end
  end
end
