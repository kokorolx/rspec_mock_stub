require 'rest-client'
require 'pry-byebug'

class GithubRequest
  def self.fetch_github(url:)
    rs = RestClient.get(url)
    raise "InternalError" if rs.code > 200
    rs
  end
end
