Rails.application.config.middleware.use OmniAuth::Builder do
    provider :github, ENV['GITHUB_API_KEY'], ENV['GITHUB_API_SECRET'], scope: "read:user, user:email"
end