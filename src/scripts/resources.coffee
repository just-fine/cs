fetch = require 'node-fetch'
projects_url = 'https://raw.githubusercontent.com/just-fine/cs/master/projects.json'


get_projects = () ->
  res = await fetch projects_url
  await res.json()

get_download_url = (template_type) ->
  projects = await get_projects()
  return no if not projects[template_type]
  "https://github.com/#{projects[template_type]}/archive/master.zip"

module.exports = {
  get_projects
  get_download_url
}
