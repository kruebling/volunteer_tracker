class Volunteer
  attr_reader(:name, :id, :project_id)

  def initialize(attr)
    @name = attr[:name]
    @id = attr[:id]
    @project_id = attr[:project_id]
  end

  def self.all
  returned_volunteers = DB.exec("SELECT * FROM volunteers;")
  volunteers = []
  returned_volunteers.each() do |vol|
    volunteers.push(Volunteer.new(:name => vol['name'], :id => vol['id'].to_i, :project_id => vol['project_id'].to_i))
    end
    volunteers.sort_by {|volunteer| volunteer.name}
  end

  def self.find(id)
    found_volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id};")[0]
    Volunteer.new({:name => found_volunteer['name'], :id => found_volunteer['id'].to_i, :project_id => found_volunteer['project_id'].to_i})
  end

  def save
   result = DB.exec("INSERT INTO volunteers (name) VALUES ('#{@name}') RETURNING id;")
   @id = result.first().fetch("id").to_i()
  end

  def ==(another_volunteer)
    self.name().==(another_volunteer.name()).&(self.id().==(another_volunteer.id()))
  end

  def update(attributes)
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE volunteers SET name = '#{@name}' WHERE id = #{self.id()};")
  end

  # def volunteers
  #   volunteers_volunteers = []
  #   results = DB.exec("SELECT volunteer_id FROM volunteers WHERE volunteer_id = #{self.id()};")
  #   results.each() do |result|
  #     volunteer_id = result.fetch("volunteer_id").to_i()
  #     volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{volunteer_id};")
  #     name = volunteer.first().fetch("name")
  #     volunteers_volunteers.push(Volunteer.new({:name => name, :id => volunteer_id}))
  #   end
  #   volunteers_volunteers
  # end

  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{self.id()};")
  end

end
