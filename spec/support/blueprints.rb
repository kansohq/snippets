require 'machinist/active_record'

Snippets::Snippet.blueprint do
  key             { Faker::Lorem.word }
  value           { Faker::Lorem.sentence }
end
