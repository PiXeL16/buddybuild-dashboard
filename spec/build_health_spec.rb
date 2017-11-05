require 'spec_helper.rb'
require_job 'build_health.rb'

describe 'get build build health data' do
  before(:each) do
    @buddy_build_response = [
      {"_id"=>"59fde74bdf87510001", "app_id"=>"12341234", "repo_url"=>"https://github.com/asdf/ios.git", "build_status"=>"success", "finished"=>true, "commit_info"=>{"tags"=>[], "commit_sha"=>"234", "branch"=>"master", "author"=>"Lalo Landas", "message"=>"This is a test", "html_url"=>""}, "build_number"=>2434, "created_at"=>"2017-11-04T16:14:03.411Z", "started_at"=>"2017-11-04T16:14:04.935Z", "finished_at"=>"2017-11-04T16:18:49.505Z", "test_summary"=>{"tests_count"=>1316, "tests_passed"=>1316, "code_coverage_percentage"=>0}, "links"=>{"download"=>[], "install"=>[]}, "scheme_name"=>"Unit Tests"}
    ]
    stub_request(:get, 'https://api.buddybuild.com/v1/apps/12341234/builds?branch=master&limit=20').
         to_return(:status => 200, :body => @buddy_build_response.to_json, :headers => {})
  end

  it 'should get build info from buddybuild api' do
    build_health = get_buddy_build_health('master')
    expect(WebMock.a_request(:get, 'https://api.buddybuild.com/v1/apps/12341234/builds?branch=master&limit=20')).to have_been_made
  end

  it 'should return the build health' do
    so_so = [{"result" => 1}, {"result" => 0}]
    stub_request(:get, 'https://api.buddybuild.com/v1/apps/12341234/builds?branch=master&limit=20').
         to_return(:status => 200, :body => @buddy_build_response.to_json, :headers => {})
    build_health = get_buddy_build_health('master')
    expect(build_health[:health]).to eq(100)
  end
end
