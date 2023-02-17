require 'faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Clean up the DB

Appointment.destroy_all
Checkin.destroy_all
Availability.destroy_all
Cleaner.destroy_all

# Create 20 Cleaners
experience = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
age = [23, 32, 33, 25, 46, 36, 24, 26, 20, 30, 29, 42, 36, 27]

cleaners = []

20.times do
  cleaner = Cleaner.new
  cleaner.name = Faker::Name.first_name
  cleaner.email = Faker::Internet.safe_email(name: cleaner.name)
  cleaner.password = Faker::Internet.password
  cleaner.experience = experience.sample
  cleaner.description = "Meet #{cleaner.name}, our #{'experienced and ' if cleaner.experience.to_i > 4}friendly cleaner. With over #{cleaner.experience} years of experience, #{cleaner.name} is an expert in providing top-quality cleaning services. With his positive and cheerful personality, #{cleaner.name} always goes the extra mile to make his clients happy. Book #{cleaner.name} today and enjoy a clean and tidy home, without any stress or hassle!"
  cleaners << cleaner
  p cleaner if cleaner.save
end

start_date = Date.current

(start_date..start_date + 1.months).each do |date|
  cleaners.each do |cleaner|
    availability = Availability.new(
      cleaner:,
      start_time: date.to_time.change(hour: 9),
      end_time: date.to_time.change(hour: 17)
    )
    p availability if availability.save
  end
end
