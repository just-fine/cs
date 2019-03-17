chalk = require 'chalk'
emoji = require 'node-emoji'
resources = require '../scripts/resources'

count = 0
print_project = (name, repo_name) ->
  count = count + 1
  author = repo_name.split('/')[0]
  index = chalk.blueBright "#{count})"
  console.log " #{index} #{name}, author: #{author}"

do () ->
  projects = await resources.get_projects()
  print_project name, repo_name for name, repo_name of projects
  console.log chalk.green '\n use "cs init {template_name}" to install.'
