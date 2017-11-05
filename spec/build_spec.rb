require 'spec_helper.rb'

describe 'Get BuddyBuild Info' do
  before(:each) do
    @mock_build_respose = {
        "_id"=>"59fca34951e78500023452345",
        "app_id"=>"598c2809221fec000123452346",
        "repo_url"=>"https://github.com/test/ios.git",
        "build_status"=>"failed",
        "finished"=>true,
        "commit_info"=>{"tags"=>[],
                        "branch"=>"appstore",
                        "commit_sha"=>"661cd20ebd16dc230ab9de4357d6653e4ebc345",
                        "author"=>"Esteban Lala",
                        "message"=>"This is a test",
                        "html_url"=>"https://github.com/661cd20ebd16dc230ab9de4357d6653e4ebc345"},
        "build_number"=>18061,
        "created_at"=>"2017-11-03T17:11:37.160Z",
        "started_at"=>"2017-11-03T17:11:42.849Z",
        "finished_at"=>"2017-11-03T17:15:25.799Z",
        "test_summary"=>{}
    }
    @build = Models::Build.new(@mock_build_respose)
  end

  it 'it initialize the build class succesfully' do
    expect(@build.build_id).to eq('59fca34951e78500023452345')
    expect(@build.app_id).to eq('598c2809221fec000123452346')
    expect(@build.repo_url).to eq('https://github.com/test/ios.git')
    expect(@build.status).to eq('failed')
    expect(@build.finished).to eq(true)
    expect(@build.commit_author).to eq('Esteban Lala')
    expect(@build.commit_message).to eq('This is a test')
    expect(@build.branch).to eq('appstore')
    expect(@build.build_number).to eq(18061)
    expect(@build.created_at).to eq('2017-11-03T17:11:37.160Z')
    expect(@build.started_at).to eq('2017-11-03T17:11:42.849Z')
    expect(@build.finished_at).to eq('2017-11-03T17:15:25.799Z')
  end

  it 'has dashboard link' do 
    expect(@build.dashboard_link).to include('59fca34951e78500023452345')
    expect(@build.dashboard_link).to include('598c2809221fec000123452346')
  end

  it 'has valid duration' do 
    expect(@build.duration_in_seconds).to eq(223) 
  end

  it 'exports to hash succesfully' do 
    expect(@build.to_hash[:name]).to eq('appstore')
    expect(@build.to_hash[:status]).to eq('failed')
    expect(@build.to_hash[:link]).to_not be_nil
    expect(@build.to_hash[:duration]).to eq(223)
    expect(@build.to_hash[:time]).to eq('2017-11-03T17:11:42.849Z')
    expect(@build.to_hash[:author]).to eq('Esteban Lala')
    expect(@build.to_hash[:commit_message]).to eq('This is a test')
  end
end
