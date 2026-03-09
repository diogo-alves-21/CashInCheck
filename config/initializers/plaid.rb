NORDIGEN_CONFIG = {
  secret_id:  ENV.fetch('NORDIGEN_SECRET_ID'),
  secret_key: ENV.fetch('NORDIGEN_SECRET_KEY')
}

NordigenClient = Nordigen::NordigenClient.new(
  secret_id:  NORDIGEN_CONFIG[:secret_id],
  secret_key: NORDIGEN_CONFIG[:secret_key]
)
