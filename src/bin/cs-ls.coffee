chalk = require 'chalk'
yaml = require 'js-yaml'
emoji = require 'node-emoji'
configs = require '../scripts/configs.yml'

{ templates } = yaml.load configs

index = 0
print_project = (key, url) ->
  index = index + 1
  url = url.replace /\.zip/, ''
  index = chalk.blueBright "#{index})"
  version = chalk.cyan (url.split '/').reverse()[0]
  name = chalk.cyan.bold "#{key}"
  console.log " #{index} #{name}, version: #{version}"

print_project key, url for key, url of templates
