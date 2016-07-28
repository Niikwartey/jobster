class Jobster::CLI
  attr_reader :jobs
  

  def initialize
    # get jobs
    @jobs = Jobster::Job.json
  end

  def call
    puts "\n\n"
    progress = ProgressBar.create(
    :format => "%p%% %b",
    :progress_mark  => "_", 
    :remainder_mark => "\u{FF65}", 
    :starting_at    => 0)#(total, :color => "green")
    100.times { progress.increment; sleep 0.01 }
    puts "\n\n"

    list_jobs
    menu
  end

  def format(str)
    str_arr = str.split("<b>").join.split("</b>").join.split

    str_arr.each_with_index do |word, i|
      if i != 0 && i % 13 == 0
        str_arr[i] += "\n\t\t\t\t\t\t\t\t\t\t"
      end
    end
    
    str_arr.join(" ")
  end

  def list_jobs
    job_results = self.jobs["results"]
    job_results.each_with_index do |job, index| 
      job["".to_sym] = index + 1
      job["snippet"] = format(job["snippet"])
    end

    # displayjobs

    formatador = Formatador.new
    formatador.indent {
      formatador.display_line('two levels of indentation')
    }
    formatador.display_line('four level of indentation')
    formatador.display_table(job_results, ["".to_sym, "jobtitle", "formattedLocation", "snippet"])
  end

  def valid_input?(input)
    input == "exit" || (input.to_i < jobs["end"].to_i && input.to_i != 0)
  end

  def menu
    puts "Enter the index number of the job you would like more information on or type exit to enter:"
  
    index_input = gets.strip.downcase
    self.valid_input?(index_input)
    if job_index = index_input.to_i - 1
      job_key = jobs["results"][job_index]["jobkey"]
      job_url = "http://api.indeed.com/ads/apigetjobs?publisher=1863007693750280&jobkeys=#{job_key}&v=2&format=json"
      job_hash_string = HTTParty.get(job_url).to_s
      job_hash = JSON.parse(job_hash_string)
      job_snippet = job_hash["results"][0]
      puts job_snippet["snippet"]
      puts ""
      puts "Type the following number for further options."
      puts "1. to apply to this job."
      puts "2. to learn about another job within this search."
      puts "3. to exit."
      user_input = gets.strip
      case user_input
      when "1" 
        #go to url
      when "2"
        self.menu
      when "3"
        self.goodbye
      else 
        puts "invalid input"
        self.goodbye
      end
    elsif index_input == "exit"
      self.goodbye
    else 
    self.menu
    end 
  end

  def goodbye
    puts "See you tomorrow for more jobs"
  end
end