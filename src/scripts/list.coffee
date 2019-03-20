ora = require 'ora'
chalk = require 'chalk'
resources = require '../scripts/resources'

count = 0
print_project = (name, repo_name) ->
  count = count + 1
  author = repo_name.split('/')[0]
  index = chalk.blueBright "#{count})"
  puts "#{index} #{name}, author: #{author}"

list = () ->
  wait = new ora
  wait.start('update projects, it may take some time..')
  projects = await resources.get_projects()
  wait.stop()
  wait.clear()
  print_project name, repo_name for name, repo_name of projects
  console.log chalk.green '\n use "cs init" to install.'

module.exports = list
