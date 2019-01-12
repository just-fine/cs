commander = require 'commander'
notifier = require 'update-notifier'
pkg = require '../../package.json'

notifier { pkg, updateCheckInterval: 1 }
  .notify { isGlobal: true }


commander
  .version pkg.version, '-v, --version'
  .command('init', 'init a project').alias('i')
  .command('ls', 'show all project type').alias('l')
  .usage '<command> [options]'
  .parse(process.argv)

