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

post('/projects') do
  title = params.fetch("title")
  project = Project.new({:title => title, :id => nil})
  project.save()
  @projects = Project.all()
  erb(:index)
end


get("/projects/:id") do
  @project = Project.find(params.fetch("id").to_i())
  erb(:project_info)
end


patch("/project/:id") do
  title = params.fetch('title')
  @project = Project.find(params.fetch("id").to_i())
  @project.update({:title => title})
  @projects = Project.all()
  erb(:index)
end

delete("/project/:id") do
  @project = Project.find(params.fetch("id").to_i())
  @project.delete
  @projects = Project.all()
  erb(:index)
end
