require ('rubygems')
require ('bundler/setup')
require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require('pg')

DB = PG.connect({:dbname => "volunteer_tracker"})

get('/') do
  @projects = Project.all()
  erb(:index)
end

get('/volunteers') do
  @volunteers = Volunteer.all()
  erb(:volunteers)
end

post('/volunteers/:id') do
  @project = Project.find(params.fetch("id").to_i())
  project_id = @project.id
  name = params.fetch("name")
  volunteer = Volunteer.new({:name => name, :id => nil})
  volunteer.save()
  volunteer.update(@project)
  @volunteers = Volunteer.all()
  @projects = Project.all()
  erb(:project_info)
end

post('/project') do
  title = params.fetch("title")
  project = Project.new({:title => title, :id => nil})
  project.save()
  @volunteers = Volunteer.all()
  @projects = Project.all()
  erb(:index)
end

post("/project/:id") do
  @project = Project.find(params.fetch("id").to_i())
  project_id = @project.id
  name = params.fetch("name")

  @projects = Project.all()
  erb(:project_info)
end

get("/project/:id") do
  @project = Project.find(params.fetch("id").to_i())
  @volunteers = Volunteer.all()
  erb(:project_info)
end

get("/volunteers/:id") do
  @volunteer = Volunteer.find(params.fetch("id").to_i())
  erb(:volunteer_info)
end


patch("/project/:id") do
  title = params.fetch('title')
  @project = Project.find(params.fetch("id").to_i())
  @project.update({:title => title})
  @projects = Project.all()
  @volunteers = Volunteer.all()
  erb(:project_info)
end

delete("/project/:id") do
  @project = Project.find(params.fetch("id").to_i())
  @project.delete
  @projects = Project.all()
  @volunteers = Volunteer.all()
  erb(:index)
end


delete("/volunteer/:id") do
  @volunteer = Volunteer.find(params.fetch("id").to_i())
  @volunteer.delete
  @volunteers = Volunteer.all()
  @projects = Project.all()
  erb(:index)
end
