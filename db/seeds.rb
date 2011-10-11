# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
AssignmentCategory.create([{:name => "Homework"}, {:name => "Essay"}, {:name => "Journal"}, {:name => "Problem Set"}, {:name => "Project"}])
user = User.new( #:city                 => City.first,
  :first_name           => 'admin',
  :last_name            => 'admin',
  :admin                => 1,
  :email                => 'admin_brian@classcloud.me',
  :password   => 'password',
  :password_confirmation  => 'password'
)
user.skip_confirmation!
user.save!
user.admin = true
user.save!