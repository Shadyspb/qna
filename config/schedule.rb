set :chronic_options, hours24: true

every 1.day, at: '23:00' do
  runner "DigestDispatchJob.create"
end
