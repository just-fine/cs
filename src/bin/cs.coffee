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

console.log args


if args._[0] and commands[args._[0]]
  do commands[args._[0]]

if args['--version']
  puts "v#{pkg.version}"

if args['--help']
  puts "#{chalk.cyan 'init'} <command> -- create a project"
  puts "#{chalk.cyan 'ls'}   <command> -- show all projects"
