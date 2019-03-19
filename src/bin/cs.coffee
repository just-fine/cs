arg = require 'arg'
pkg = require '../../package.json'
install = require '../scripts/install'
list = require '../scripts/list'

args = arg({
  '--help': Boolean,
  '--version': Boolean,
  '-h': '--help'
})

if args._[0] is 'init'
  do install

if args._[0] is 'ls'
  do list

#commander
#  .version pkg.version, '-v, --version'
#  .command('init', 'init a project').alias('i')
#  .command('ls', 'show all project type').alias('l')
#  .usage '<command> [options]'
#  .parse(process.argv)

