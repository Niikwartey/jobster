require 'formatador'
require 'ruby-progressbar'


class Jobster::CLI

  def call

    # total    = 10
    # progress = Formatador::ProgressBar.new(total, :color => "green")
    # 10.times do
    #   progress.increment; sleep 0.01
    # end

    progress = ProgressBar.create( 
     # :format => "%a %b\u{15E7}%i %p%% %t",
     #:format => "%b\u{15E7}%i %p%%",
     :format => "%p%% %b",
     :progress_mark  => "_", 
     :remainder_mark => "\u{FF65}", 
     :starting_at    => 0)#(total, :color => "green")
    100.times { progress.increment; sleep 0.01 }
    puts "\n\n"

    list_jobs
    menu
    goodbye
  end

  def list_jobs
    table_data = [
      {:title => "Java Backend Developer", :location => "New York", :short_desc => "whvfvzc xvjzx whvfbjkvhjdkb dvxk zxgjkv zxvjz xvgzkxhjv xvjzx whvfbjkvhjdkb dvxk zxgjkv zxvjz xvgzkxhjv gzhjkx vgjzc gxvzxjvzc xvjzx"},
      {:title => "Senior Fullstack Engineer", :location => "San Francisco", :short_desc => "whvfbjkvhjdkb dvxk zxgjkv zxvjz xvgzkxhjv gzhjkx vgjzc gxvzxjvzc xvjzx"}, 
      {:title => "Junior Frontend Developer", :location => "Los Angeles", :short_desc => "whvfbjkvhjdkb dvxk zxgjkv zxvjz xvgzkxhjv gzhjkx vgjzc gxvzxjvzc xvjzx"}
    ]
    table_data.each_with_index {|hash, index| hash["".to_sym] = index + 1}
    Formatador.display_table(table_data, ["".to_sym, :title, :location, :short_desc])
    puts "\n\n"
    #@jobs = Jobster::job.result
  end

  def menu
    table_data = [
      {:title => "Java Backend Developer", :location => "New York", :short_desc => "whvfbjkvhjdkb dvxk zxgjkv zxvjzjkvhjdkb dvxk zxgjkv zxvjz xvgzkxhjv gzhjkx vgjzc gxvzxjvzc xvjzx whvfbjkvhjdkb dvxk zxgjkv zxvjz xvgzkxhjv gzhjkx vgjzc gxvzxjvzc xvjzx whvfbjkvhjdkb dvxk zxgjkv zxvjz xvgzkxhjv gzhjkx vgjzc gxvzxjvzc xvjzx"},
      {:title => "Senior Fullstack Engineer", :location => "San Francisco", :short_desc => "whvfbjkvhjdkb dvxk zxgjkv zxvjz xvgzkxhjv gzhjkx vgjzc gxvzxjvzc xvjzx"}, 
      {:title => "Junior Frontend Developer", :location => "Los Angeles", :short_desc => "whvfbjkvhjdkb dvxk zxgjkv zxvjz xvgzkxhjv gzhjkx vgjzc gxvzxjvzc xvjzx"}
    ]

    puts "Enter the number of the job you would like more information on or type exit to enter:"
    # input = gets.strip

    # unless input.downcase == "exit"
    #   index = input.to_i - 1
    #   puts table_data[index][:short_desc]
    #   menu
    # end
  end

  def goodbye
    puts "See you tomorrow for more jobs"
  end
end