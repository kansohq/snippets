require 'redis'

Rails.application.config.after_initialize do
  begin
    Redis.current.ping

    I18n.backend = I18n::Backend::Chain.new(
      I18n::Backend::KeyValue.new(Redis.current),
      I18n.backend
    )

    Snippets::Snippet.cache_all if Snippets::Snippet.table_exists?

  rescue Redis::CannotConnectError => ex
    unless Rails.env.development? || Rails.env.test? ||
           (ENV['REDIS_URL'].nil? && ENV['REDIS_PROVIDER'].nil?)
      raise ex
    end
  end
end
