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
    progress = ProgressBar.create(
    :format => "%p%% %b",
    :progress_mark  => "_", 
    :remainder_mark => "\u{FF65}", 
    :starting_at    => 0)#(total, :color => "green")
    100.times { progress.increment; sleep 0.01 }

    list_jobs
    menu
  end

  def format(str)
    str_arr = str.split("<b>").join.split("</b>").join.split
    str_arr.join(" ")
  end

  def list_jobs
    job_results = self.jobs["results"]
    job_results.each { |job| job["snippet"] = format(job["snippet"]) }

    self.display_table
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

  def menu
    puts "Enter the index number of the job you would like more information on or type 'exit' to exit:"
  
    user_input = gets.strip.downcase
    job_index = indexer(user_input)

    if job_index.class == Fixnum
      # get job description
      job_key = jobs["results"][job_index]["jobkey"]
      job_url = "http://api.indeed.com/ads/apigetjobs?publisher=1863007693750280&jobkeys=#{job_key}&v=2&format=json"
      
      begin
        json_string = HTTParty.get(job_url).to_s
        job_json = JSON.parse( json_string )
      rescue JSON::ParserError => e
        json_string = HTTParty.get(job_url).to_s
        job_json = JSON.parse( json_string )
      end

      job_hash = job_json["results"][0]
      
      # display job description
      self.display_summary(job_hash)
      # ask  for and excute on further user actions
      puts "| #{'For further actions, enter a number from the options below'.light_blue}"
      puts "|_________________________________________________________\n|"
      puts "| '1' to apply to this job\n"
      puts "| '2' to learn about another job within this search\n"
      puts "| '3' to exit\n\n"

      user_input = gets.strip
      case user_input
      when "1" 
        Launchy.open( job_json["results"][0]["url"] )
      when "2"
        self.menu
      when "3"
        self.goodbye
      else 
        puts "#{'invalid input'.red}\n"
        self.goodbye
      end
    elsif job_index == "exit"
      self.goodbye
    else
      puts "#{'invalid input'.red}\n"
      self.menu
    end 
  end

  def display_table
    job_results = self.jobs['results']

    vertical_spacing 2
    table :border => true do
      row :color => 'light_blue' do
        column '', :width => 2
        column 'Position', :width => 35, :bold => true
        column 'Location', :width => 25, :align => 'center'
        column 'Job description', :width => 80
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
    puts "\n\nSee you tomorrow for more jobs\n\n"
  end

end

 # job_results.each_with_index do |job, index|
      #   row do
      #     column index + 1
      #     column job["jobtitle"]
      #     column job["formattedLocation"]
      #     column job["snippet"]
      #   end
      # end


