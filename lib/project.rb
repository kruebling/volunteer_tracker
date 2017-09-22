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
    title = project.fetch("title")
    id = project.fetch("id").to_i()
    projects.push(Project.new(:title => project['title'], :id => project['id'].to_i))
    end
    projects.sort_by {|project| project.title}
  end
  
end
