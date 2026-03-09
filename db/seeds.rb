# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# rubocop:disable Style/TopLevelMethodDefinition
def create_massive_text
  text = []
  20.times do
    text << Faker::Lorem.paragraphs(number: 20).join(' ')
  end
  text.map { |pr| "<p>#{pr}</p>" }.join
end
# rubocop:enable Style/TopLevelMethodDefinition

Admin.create!(email: "daniel@hyp.pt", password: "12345678")
Admin.create!(email: "sara@hyp.pt", password: "12345678")
Admin.create!(email: "mail@hyp.pt", password: "12345678")

Consent.create!(active: true, kind: Consent::TERMS, content: create_massive_text)
Consent.create!(active: true, kind: Consent::COOKIES, content: create_massive_text)
Consent.create!(active: true, kind: Consent::PRIVACY, content: create_massive_text)
