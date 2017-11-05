module Builds
  BUILD_CONFIG = JSON.parse(File.read('config/builds.json'))
  DASHBOARD_TITLE = BUILD_CONFIG['dashboardTitle']
  BRANCH_LIST = BUILD_CONFIG['branches']
end
