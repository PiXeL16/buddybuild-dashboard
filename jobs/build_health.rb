require_relative '../models/build'

def get_url(url, headerAuthorization = nil)
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)
  if uri.scheme == 'https'
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end

  request = Net::HTTP::Get.new(uri.request_uri)

  request['Authorization'] = headerAuthorization if headerAuthorization != nil

  response = http.request(request)
  JSON.parse(response.body)
end

def calculate_health(successful_count, count)
  (successful_count / count.to_f * 100).round
end

def get_buddy_build_health(branch)
  url = "#{Builds::BUILD_CONFIG['buddyBuildApiBaseUrl']}/v1/apps/#{Builds::BUILD_CONFIG['buddyBuildAppID']}/builds?branch=#{branch}&limit=20"
  if ENV['BUDDY_BUILD_AUTHORIZATION'] != nil then
    header_auth = [ ENV['BUDDY_BUILD_AUTHORIZATION'] ]
  end

  build_info = get_url(url, header_auth)

  results = build_info
  successful_count = results.count { |result| result['build_status'] == 'success' }
  latest_build = Models::Build.new(results[0])

  health = { health: calculate_health(successful_count, results.count) }

  latest_build.to_hash.merge(health)

end

SCHEDULER.every '15s' do
  Builds::BRANCH_LIST.each do |branch|
    send_event(branch, get_buddy_build_health(branch))
  end
end
