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
    title = project.fetch("title")
    id = project.fetch("id").to_i()
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

end
