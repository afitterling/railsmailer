require 'sinatra'
require 'fileutils'

class Github < Sinatra::Base
  post '/' do
    target_branch = ENV["DEPLOY_BRANCH"]
    repo_path     = ENV["REPO_PATH"]

    unless request.env["HTTP_X_GITHUB_EVENT"] == "push"
      return 204
    end

    json = JSON.parse(request.body.read)
    unless json["ref"] == "refs/heads/#{TARGET_BRANCH}"
      return 204
    end

    FileUtils.cd(repo_path)
    pid = Process.spawn("bin/rake deploy")
    Process.detach(pid)

    204
  end
end
