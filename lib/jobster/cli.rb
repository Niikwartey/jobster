class Jobster::CLI
  # attr_reader :jobs
  

  def jobs
    @jobs = Jobster::Job.result
  end

  def call
    

    
    # Formatador.display_line("+++++++++++I'm working+++++++++")
    # total = 100
    # progress = Formatador::ProgressBar.new(total, :color => "gray")
    # 1000.times do
    #   progress.increment
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
    # get jobs
    #jobs = Jobster::Job.result
  

    # show jobs
    puts "All the jobs"
    
    jobs["results"].each_with_index {|hash, index| hash["".to_sym] = index + 1}
    Formatador.display_table(jobs["results"], ["".to_sym, "jobtitle", "formattedLocation", "snippet"])


    

    # jobs_hash["results"].each do |result|
    #   jobs_arr << result
    #   puts result["jobtitle"]
    # end

  end

  def menu
    # table_data = [
    #   {:title => "Java Backend Developer", :location => "New York", :short_desc => "whvfbjkvhjdkb dvxk zxgjkv zxvjzjkvhjdkb dvxk zxgjkv zxvjz xvgzkxhjv gzhjkx vgjzc gxvzxjvzc xvjzx whvfbjkvhjdkb dvxk zxgjkv zxvjz xvgzkxhjv gzhjkx vgjzc gxvzxjvzc xvjzx whvfbjkvhjdkb dvxk zxgjkv zxvjz xvgzkxhjv gzhjkx vgjzc gxvzxjvzc xvjzx"},
    #   {:title => "Senior Fullstack Engineer", :location => "San Francisco", :short_desc => "whvfbjkvhjdkb dvxk zxgjkv zxvjz xvgzkxhjv gzhjkx vgjzc gxvzxjvzc xvjzx"}, 
    #   {:title => "Junior Frontend Developer", :location => "Los Angeles", :short_desc => "whvfbjkvhjdkb dvxk zxgjkv zxvjz xvgzkxhjv gzhjkx vgjzc gxvzxjvzc xvjzx"}
    # ]

    # puts "Enter the number of the job you would like more information on or type exit to enter:"
    # input = gets.strip.downcase

    
    # until input == "exit"
    #   index = input.to_i - 1
    #   table_data[i][:short_desc]
    # end
    input = nil
    while input != "exit"
      puts "Enter the number of the job you would like more information on or type exit to enter:"
      input = gets.strip.downcase
      if input.to_i > 0
        puts jobs[input.to_i - 1]
      elsif input == "list"
        list_jobs
      else
        puts "Not sure what you want, type list or exit"
      end
    end

  end

  def goodbye
    puts "See you tomorrow for more jobs"
  end
end