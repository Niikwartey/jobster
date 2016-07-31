require 'pry'
require 'json'
require 'HTTParty'
require 'ruby-progressbar'
require 'command_line_reporter'
require 'launchy'
require 'colorize'

require_relative "./jobster/version"
require_relative "./jobster/job"
require_relative './jobster/cli'