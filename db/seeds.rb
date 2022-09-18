# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
['john', 'andrea', 'carl', 'mike', 'natalia', 'dylan', 'rusbel', 'andrew'].each do |user|
  User.create email: "#{user}@email.com", password: 'password'
end

p 'Users have been created'

['development', 'marketing', 'managment', 'research'].each do |name|
  Category.create name: name, description: '--'
end

p 'Categories have been created'

# Tasks seeding
owner = User.find_by(email: 'andrew@email.com')
[
  ['marketing', 'Facebook Ads', ['john:1', 'mike:2', 'natalia:random']],
  ['managment', 'Task control', ['john:1', 'mike:2', 'natalia:random']],
  ['research', 'New marketing desing', ['john:1', 'mike:2', 'natalia:random']],
  ['marketing', 'Google Ads', ['john:1', 'mike:2', 'natalia:random']],
  ['research', 'New software', ['john:1', 'mike:2', 'natalia:random']],
  ['managment', 'Update payment methods', ['john:1', 'mike:2', 'natalia:random']],
  ['development', 'Update User controller', ['john:1', 'mike:2', 'natalia:random']],
  ['managment', 'Close finished tasks', ['john:1', 'mike:2', 'natalia:random']],
  ['development', 'Update task UI', ['john:1', 'mike:2', 'natalia:random']],
  ['marketing', 'Unreal Ads', ['john:1', 'mike:2', 'natalia:random']],
  ['marketing', 'New Facebook Ad client', ['john:1', 'mike:2', 'natalia:random']],
  ['managment', 'New Google Ad Client', ['john:1', 'mike:2', 'natalia:random']],
  ['development', 'Update Category UI', ['john:1', 'mike:2', 'natalia:random']],
].each do |category, description, participant_set|

  participants = participant_set.map do |participant|
    user_name, raw_role = participant.split(':')
    role = raw_role == 'random' ? [1, 2].sample : raw_role

    Participant.new(
      user: User.find_by(email: "#{user_name}@email.com"),
      role: role.to_i
    )
  end

  Task.create!(
    category: Category.find_by(name: category),
    name: "Task ##{Task.count + 1}",
    description: description,
    due_date: Date.today + 15.days,
    owner: owner,
    participant_users: participants
  )

end

p 'Tasks have been created'
