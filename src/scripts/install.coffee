fs = require 'fs'
ora = require 'ora'
path = require 'path'
chalk = require 'chalk'
inquirer = require 'inquirer'
download = require 'download-git-repo'
{ execSync } = require 'child_process'
resources = require '../scripts/resources'
base = process.cwd()

make_choices = (projects) ->
  { name, value: name } for name, repo_name of projects

make_promps = (projects) -> [
  {
    choices: make_choices projects
    type: 'list'
    name: 'project_type'
    message: 'what do you need to create?'
  }
  {
    type: 'input'
    name: 'project_name'
    message: 'your project name?'
    validate: (txt) ->
      return no if not txt
      is_exist = fs.existsSync path.join base, txt
      return yes if not is_exist
      console.log chalk.yellow "\n > this folder already exists"
      return no
  }
]

find_link = (type) ->
  url = await resources.get_download_url(type)
  return "direct:#{url}" if url

  puts chalk.yellow "not project of type #{type} was found."
  puts chalk.cyan "use 'cs ls' to view all types?"
  process.exit 1


print_success = (type, name) ->
  to = path.join base, name, 'package.json'
  try
    execSync "cd #{name} && rm -rf .netlify .travis.yml .github now.json"
    if fs.existsSync to
      pkg = JSON.parse fs.readFileSync to, 'utf-8'
      pkg = Object.assign {}, pkg, {
        name, version: '0.0.1',
      }
      fs.writeFileSync to, JSON.stringify pkg, '', '\t'
  catch err

  console.log ''
  puts chalk.cyan "#{type} project has been successfully installed."
  puts chalk.cyan "enjoy coffee."
  process.exit 1

install = () ->
  try
    # get project templates
    wait = new ora
    wait.start('update projects, it may take some time..')
    projects = await resources.get_projects()
    wait.stop()
    wait.clear()

    # get user inputs
    { project_name, project_type } = await inquirer.prompt make_promps projects
    to = path.join base, project_name

    # download project
    wait = new ora
    wait.start "download #{project_type} template, it may take some time..."
    url = await find_link project_type
    download url, to, { clone: off }, (err) ->
      if err?
        wait.fail err
        process.exit 1
      wait.stop()
      wait.clear()
      print_success project_type, project_name
      process.exit 0

  catch err
    console.log err
    process.exit 1

module.exports = install
