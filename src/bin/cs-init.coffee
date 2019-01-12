commander = require 'commander'
chalk = require 'chalk'
emoji = require 'node-emoji'
install = require '../scripts/install'

commander.parse process.argv
project_type = commander.args[0]

if not project_type
  console.log chalk.yellow " #{emoji.get 'thinking_face'} you need to specify a project type. like: 'cs init rails'."
  console.log chalk.cyan " #{emoji.get 'point_right'} use 'cs ls' to view all types?"
  process.exit 1

install project_type
