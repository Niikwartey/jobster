require 'formatador'


class Jobster::CLI

  def call
    list_jobs
    menu
        total = 1000
    progress = ProgressBar.new(total, :color => "light_blue")
    1000.times do
      progress.increment
      end      
    goodbye
  end

  def list_jobs
    puts "All the jobs"
    puts <<-DOC.gsub /^\s*/, ''
    1. Java Developer - NY
    2. PHP Developer - NY
    DOC
  end

  def menu
    puts "Enter the number of the job you would like more information on or type exit to enter:"
    input = nil

    
    while input != "exit"
    input = gets.strip.downcase
    case input
      when "1"
        puts "More info on job 1"
      when "2"
        puts "More info on job 2"
      end
    end
  end

  def goodbye
    puts "See you tomorrow for more jobs"
  end

end