require 'machinist/active_record'

Snippets::Snippet.blueprint do
  key             { "test.#{rand(100)}" }
  value           { "test" }
end
