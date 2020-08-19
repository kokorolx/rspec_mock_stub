require 'rspec'
require 'webmock/rspec'
require_relative '../github_request.rb'
WebMock.disable_net_connect!(allow_localhost: true)


describe GithubRequest do
  before(:each) do
    @url = "https://api.github.com/users/octocat/orgs"
  end

  context 'Simplest stub' do
    it 'instance URL' do
      stub_request(:any, @url).to_raise(StandardError)
      expect {
        rs = RestClient.get(@url)
      }.to raise_error(StandardError)
    end
  end

  describe 'Using GithubRequest'
    it 'status 200' do
      stub_request(:any, @url).
        to_return(status: 200)
      expect {
        GithubRequest.fetch_github(url: @url)
      }.not_to raise_error(StandardError)
    end

    context 'Status not 200' do
      [201, 300, 400, 500].each do |status|
        it "Status #{status}" do
          stub_request(:any, @url).
            to_return(status: status)
          expect {
            GithubRequest.fetch_github(url: @url)
          }.to raise_error(StandardError)
        end
      end
    end
  end
