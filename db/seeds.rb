begin
  ##### TEACHER #####
  3.times.each do |index|
    teacher = Teacher.new(code: index + 1)
    teacher.build_person(name: Faker::ProgrammingLanguage.creator, age: Random.rand(100))
    teacher.person.build_user(email: Faker::Internet.email, password: '12345678')
    teacher.save!
  end

  ##### STUDENT #####
  6.times.each do
    person = Person.new(name: Faker::Superhero.descriptor, age: Random.rand(100))
    person.build_user(email: Faker::Internet.email, password: '12345678')
    person.save!
  end

  ##### CATEGORY #####
  4.times.each do
    Category.create!(name: Faker::ProgrammingLanguage.name)
  end

  ##### COURSE ######
  7.times.each do
    course = Course.new(
      name: Faker::ProgrammingLanguage.name,
      start_date: Date.current + Random.rand(10),
      price: Random.rand(100),
      limit_subscriptions: Random.rand(11),
      category: Category.all.sample,
      teacher: Teacher.all.sample
    )
    course.photo.attach(io: File.open("ruby-on-rails.png"), filename: 'ruby-on-rails.jpg')
    course.save
  end

  ##### ADMINISTRATOR #####
  User.last.update!(email: 'rafaelbgioia@gmail.com', profile: :administrator)
end
