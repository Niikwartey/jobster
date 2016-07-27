require 'formatador'
require 'ruby-progressbar'


class Jobster::CLI

  def call

    # total    = 10
    # progress = Formatador::ProgressBar.new(total, :color => "green")
    # 10.times do
    #   progress.increment; sleep 0.01
    # end

    total    = 10
    progress = ProgressBar.new#(total, :color => "green")
    10.times do
      progress.increment; sleep 0.01
    end



    list_jobs
    menu
    goodbye
  end

  def list_jobs
    puts "All the jobs"
    puts <<-DOC.gsub /^\s*/, ''
    1. Java Developer - NY
    2. PHP Developer - NY
    DOC
    table_data = [
      {:title => "Java Backend Developer", :location => "New York", :short_desc => "whvfvzc xvjzx whvfbjkvhjdkb dvxk zxgjkv zxvjz xvgzkxhjv xvjzx whvfbjkvhjdkb dvxk zxgjkv zxvjz xvgzkxhjv gzhjkx vgjzc gxvzxjvzc xvjzx"},
      {:title => "Senior Fullstack Engineer", :location => "San Francisco", :short_desc => "whvfbjkvhjdkb dvxk zxgjkv zxvjz xvgzkxhjv gzhjkx vgjzc gxvzxjvzc xvjzx"}, 
      {:title => "Junior Frontend Developer", :location => "Los Angeles", :short_desc => "whvfbjkvhjdkb dvxk zxgjkv zxvjz xvgzkxhjv gzhjkx vgjzc gxvzxjvzc xvjzx"}
    ]
    table_data.each_with_index {|hash, index| hash["".to_sym] = index + 1}
    Formatador.display_table(table_data, ["".to_sym, :title, :location, :short_desc])

    @jobs = Jobster::job.result
  end

  def menu
    table_data = [
      {:title => "Java Backend Developer", :location => "New York", :short_desc => "whvfbjkvhjdkb dvxk zxgjkv zxvjzjkvhjdkb dvxk zxgjkv zxvjz xvgzkxhjv gzhjkx vgjzc gxvzxjvzc xvjzx whvfbjkvhjdkb dvxk zxgjkv zxvjz xvgzkxhjv gzhjkx vgjzc gxvzxjvzc xvjzx whvfbjkvhjdkb dvxk zxgjkv zxvjz xvgzkxhjv gzhjkx vgjzc gxvzxjvzc xvjzx"},
      {:title => "Senior Fullstack Engineer", :location => "San Francisco", :short_desc => "whvfbjkvhjdkb dvxk zxgjkv zxvjz xvgzkxhjv gzhjkx vgjzc gxvzxjvzc xvjzx"}, 
      {:title => "Junior Frontend Developer", :location => "Los Angeles", :short_desc => "whvfbjkvhjdkb dvxk zxgjkv zxvjz xvgzkxhjv gzhjkx vgjzc gxvzxjvzc xvjzx"}
    ]

    puts "Enter the number of the job you would like more information on or type exit to enter:"
    input = gets.strip.downcase

    
    until input == "exit"
      iindex = input.to_i - 1
      table_data[i][:short_desc]
    end
       
    #  end input != "exit"
    # input = gets.strip.downcase
    # case input
    #   when "1"
    #     puts "More info on job 1"
    #   when "2"
    #     puts "More info on job 2"
    #   end
    # end

  end

  def goodbye
    puts "See you tomorrow for more jobs"
  end
end