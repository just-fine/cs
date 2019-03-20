arg = require 'arg'
chalk = require 'chalk'
pkg = require '../../package.json'
install = require '../scripts/install'
list = require '../scripts/list'
logo = chalk.blue ' > '
global.puts = (args...) ->
  console.log logo, args...

commands = {
  init: install
  i: install
  list: list
  ls: list
}

args = arg {
  '--help': Boolean
  '-h': '--help'
  '--version': Boolean
  '-v': '--version'
}

helper = () ->
  puts "#{chalk.cyan 'init'} <command> -- create a project"
  puts "#{chalk.cyan 'ls'}   <command> -- show all projects"

do () ->
  if args._[0] and commands[args._[0]]
    return do commands[args._[0]]

  if args['--version']
    return puts "v#{pkg.version}"

  if args['--help']
    return do helper

  do helper



