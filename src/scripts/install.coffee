fs = require 'fs'
ora = require 'ora'
path = require 'path'
execa = require 'execa'
chalk = require 'chalk'
yaml = require 'js-yaml'
emoji = require 'node-emoji'
inquirer = require 'inquirer'
download = require 'download-git-repo'
configs = require './configs.yml'
base = do process.cwd

promps = [
  {
    type: 'input'
    name: 'project_name'
    message: 'project name:'
    validate: (txt) ->
      return false if not txt
      is_exist = fs.existsSync path.join base, txt
      return true if not is_exist
      console.log chalk.yellow "\n #{emoji.get 'bug'} this folder already exists"
      return false
  }
]

find_link = (type) ->
  { templates } = yaml.load configs
  url = templates[type]
  return "direct:#{url}" if url

  console.log chalk.yellow " #{emoji.get 'scream_cat'} not project of type #{type} was found."
  console.log chalk.cyan " #{emoji.get 'point_right'} use 'cs ls' to view all types?"
  process.exit 1


print_success = (type, name) ->
  to = path.join base, name, 'package.json'
  try
    execa.shellSync "cd #{name} && rm -rf .netlify .travis.yml .github now.json"
    if fs.existsSync to
      pkg = JSON.parse fs.readFileSync to, 'utf-8'
      pkg = Object.assign {}, pkg, {
        name, version: '0.0.1',
      }
      fs.writeFileSync to, JSON.stringify pkg, '', '\t'
  catch err

  console.log ''
  console.log chalk.cyan " #{emoji.get '+1'} #{type} project has been successfully installed."
  console.log chalk.cyan " #{emoji.get 'coffee'} enjoy coffee."
  process.exit 1

install = (type) ->
  url = find_link type
  try
    answer = await inquirer.prompt promps
    to = path.join base, answer.project_name
    wait = new ora
    wait.start "download #{type} template, it may take some time..."
    download url, to, { clone: false }, (err) ->
      if not err
        do wait.clear
        print_success type, answer.project_name
        process.exit 1
      wait.fail err
      process.exit 1
      
  catch err
    console.log err
    process.exit 1

module.exports = install
