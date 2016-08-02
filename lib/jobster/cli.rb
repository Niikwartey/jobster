class Jobster::CLI
  include CommandLineReporter
  attr_reader :jobs

  def initialize
    # get jobs
    jobsrequest = Jobster::JobsRequest.new
    @jobs = jobsrequest.json
  end

  def call
    system 'clear'

    progress = ProgressBar.create(:format => "%p%% %b",:progress_mark  => "_",:remainder_mark => "\u{FF65}",:starting_at => 0)
    100.times { progress.increment; sleep 0.01 }

    list_jobs
    menu
  end

  def list_jobs
    job_results = self.jobs["results"]
    job_results.each { |job| job["snippet"] = format(job["snippet"]) }

    self.display_table 
  end

  def menu
    puts "| #{'choose one of the actions below, to proceed'.light_blue}"
    puts "|_________________________________________________________\n|"
    puts "| '1-#{jobs["results"].count}' to learn more about corresponding job\n"
    puts "| 'restart' to start over\n"
    puts "| 'quit' to exit\n\n"

    user_input = gets.strip.downcase
    job_index = indexer(user_input)
    if job_index.class == Fixnum
      # get job description
      job_key = jobs["results"][job_index]["jobkey"]
      job_url = "http://api.indeed.com/ads/apigetjobs?publisher=1863007693750280&jobkeys=#{job_key}&v=2&format=json"
      
      job_json = self.get_json( job_url )

      job_hash = job_json["results"][0]
      
      # display job description
      self.display_summary(job_hash)
      # ask  for and excute on further user actions
      puts "| #{'choose one of the actions below, to proceed'.light_blue}"
      puts "|_________________________________________________________\n|"
      puts "| 'apply' to apply to this job\n"
      puts "| 'another' to learn about another job within this search\n"
      puts "| 'restart' to start over\n"
      puts "| 'quit' to exit\n\n"

      user_input = gets.strip
      case user_input
      when "apply" 
        Launchy.open( job_json["results"][0]["url"] )
      when "another"
        self.menu
      when "restart"
        self.class.new.call
      when "quit"
        self.goodbye
      else 
        puts "#{'invalid input'.red}\n"
        self.menu
      end
    elsif user_input == 'restart'
      self.class.new.call
    elsif user_input == 'quit'
      self.goodbye
    else
      puts "#{'invalid input'.red}\n"
      self.menu
    end 
  end

  # helper methods

  def format(str)
    str_arr = str.split("<b>").join.split("</b>").join.split
    str_arr.join(" ")
  end

  def indexer(input)
    valid_indexes = (1..jobs["results"].count).to_a.map(&:to_s)
    if valid_indexes.include?(input)
      input.to_i - 1
    elsif ["exit", "apply"].include?(input)
      input
    else
      "invalid"
    end
  end


  def get_json(url)
    JSON.parse( HTTParty.get( url ).body )
  end

  def display_table
    job_results = self.jobs['results']

    vertical_spacing 2
    table :border => true do
      row :color => 'light_blue' do
        column '', :width => 2
        column 'Position', :width => 35, :bold => true
        column 'Location', :width => 25, :align => 'center'
        column 'Job description', :width => 70
      end

      job_results.each_with_index do |job, index|
        row :color => 'white' do
          column index + 1
          column job["jobtitle"], :color => 'yellow'
          column job["formattedLocation"]
          column job["snippet"]
        end
      end
    end
    vertical_spacing 2
  end

  def display_summary(job)
    vertical_spacing 2
    table :border => false do
      row do
        column '', :width => 6
        column job["jobtitle"],  :width => 30, :bold => true, :color => 'yellow'
        column job["snippet"], :width => 80, :padding => 2
      end
    end
    vertical_spacing 2
  end

  def goodbye
    puts "\nSee you tomorrow for more jobs"
    puts "#{'Jobster'.yellow}#{'!'.blink} Your one-stop job-search buddy\n\n"
  end

end