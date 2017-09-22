class Project
  attr_reader(:title, :id)

  def initialize(attr)
    @title = attr[:title]
    @id = attr[:id]
  end

  def self.all
  returned_projects = DB.exec("SELECT * FROM projects;")
  projects = []
  returned_projects.each() do |project|
    projects.push(Project.new(:title => project['title'], :id => project['id'].to_i))
    end
    projects.sort_by {|project| project.title}
  end

  def self.find(id)
    found_project = DB.exec("SELECT * FROM projects WHERE id = #{id};")[0]
    Project.new({:title => found_project['title'], :id => found_project['id'].to_i})
  end

  def save
   result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
   @id = result.first().fetch("id").to_i()
  end

  def ==(another_project)
    self.title().==(another_project.title()).&(self.id().==(another_project.id()))
  end

  def update(attributes)
    @title = attributes.fetch(:title, @title)
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{self.id()};")
  end

  def volunteers
    projects_volunteers = []
    results = DB.exec("SELECT id FROM volunteers WHERE project_id = #{self.id()};")
    results.each() do |result|
      volunteer_id = result.fetch("volunteer_id").to_i()
      volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{volunteer_id};")
      name = volunteer.first().fetch("name")
      projects_volunteers.push(Volunteer.new({:name => name, :id => volunteer_id}))
    end
    projects_volunteers
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{self.id()};")
  end

end
