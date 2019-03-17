fetch = require 'node-fetch'
yaml = require 'js-yaml'
projects_url = 'https://raw.githubusercontent.com/just-fine/cs/master/projects.yml'


get_projects = () ->
  res = await fetch projects_url
  text = await res.text()
  projects = (yaml.load text).projects
  projects

get_download_url = (template_type) ->
  projects = await get_projects()
  return no if not projects[template_type]
  "https://github.com/#{projects[template_type]}/archive/master.zip"

module.exports = {
  get_projects
  get_download_url
}
