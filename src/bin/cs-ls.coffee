chalk = require 'chalk'
yaml = require 'js-yaml'
emoji = require 'node-emoji'
configs = require '../scripts/configs.yml'

{ templates } = yaml.load configs

count = 0
print_project = (key, url) ->
  count = count + 1
  url = url.replace /\.zip/, ''
  index = chalk.blueBright "#{count})"
  version = chalk.cyan (url.split '/').reverse()[0]
  name = chalk.cyan.bold "#{key}"
  console.log " #{index} #{name}, version: #{version}"

print_project key, url for key, url of templates
