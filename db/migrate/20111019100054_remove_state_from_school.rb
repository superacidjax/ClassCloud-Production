class RemoveStateFromSchool < ActiveRecord::Migration
  def self.up
    add_column :users,:state_id,:integer
    remove_column :schools,:state
    file = File.new("#{Rails.root}/doc/list_of_universities_in_us")
    schools = []
    current_state = nil

    while(line = file.gets)
      if line.include?('*')
        current_state = line.split('*').last.strip
        next
      elsif line.blank?
        #        user = User.new(universities)
        schools = []
        next
      end

      state = State.find_or_create_by_name(:name => current_state)
      school = School.new
      school.name = line
      school.state_id = state.id
      school.save
    end
  end

  def self.down
  end
end
