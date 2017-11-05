module Models
    class Build
       attr_reader :build_id, :app_id, :repo_url, :status, :finished
       attr_reader :commit_author, :commit_message, :branch, :build_number, :created_at, :started_at, :finished_at 

       def initialize(args)
         @build_id = args['_id']
         @app_id = args['app_id']
         @repo_url = args['repo_url']
         @status = args['build_status']
         @finished = args['finished']
         @commit_author = args['commit_info']['author']
         @commit_message = args['commit_info']['message']
         @branch = args['commit_info']['branch']
         @build_number = args['build_number']
         @created_at = args['created_at']
         @started_at = args['started_at']
         @finished_at = args['finished_at']
       end

       def dashboard_link
         "#{Builds::BUILD_CONFIG['buddyBuildDashboardBaseUrl']}/#{@app_id}/build/#{@build_id}"
       end

       def duration_in_seconds
         return if @finished == false

         minutes = (Time.parse(@finished_at) - Time.parse(@started_at))
         minutes.round
       end

       def to_hash
         {
           name: @branch,
           status: @status,
           link: dashboard_link,
           time: @started_at,
           duration: duration_in_seconds,
           author: @commit_author,
           commit_message: @commit_message,
         }
       end
    end
end
