require 'redis'

Rails.application.config.after_initialize do
  begin
    I18n.backend = I18n::Backend::Chain.new(
      I18n::Backend::KeyValue.new(Redis.current),
      I18n.backend
    )

    Snippets::Snippet.cache_all if Snippets::Snippet.table_exists?
  end
end
