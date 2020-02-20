# Seeds
User.where(email: 'marcos@marcos.com').first_or_create!(
  name: 'marcos',
  email: 'marcos@marcos.com',
  password: '123',
  password_confirmation: '123'
)

User.where(email: 'himama@himama.com').first_or_create!(
  name: 'HiMama',
  email: 'himama@himama.com',
  password: '123',
  password_confirmation: '123'
)
