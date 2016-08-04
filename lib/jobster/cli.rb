class Jobster::CLI
  @@jobs
  def self.jobs
    @@jobs
  end

  def self.run
    @@jobs = Jobster::Job.make_jobs(self.get_url)

    ################################# progress bar #####################################
    system 'clear'
    progress = ProgressBar.create(:format => "%p%% %b",:progress_mark  => "_",:remainder_mark => "\u{FF65}",:starting_at => 0)
    100.times { progress.increment; sleep 0.01 }
    ####################################################################################

    self.list_jobs
    self.menu
  end

  def self.get_url
    url_base = "http://api.indeed.com/ads/apisearch?publisher=1863007693750280&q="
    options_hash = {"1" => "", "2" => "&l=", "3" => "&radius=", "4" => "&jt=", "5" => "&sort="}
    filters = ["job title", "location", "mile-radius", "job type", "sorting"]

    # print options
    self.print_filters
    # get an option key
    option_key = gets.strip.downcase
    # act on option key
    while option_key != "" && ["1","2","3","4","5"].include?(option_key)
      puts "what will be the #{filters[filter_indexer(option_key)]}?".light_blue

      option_value = gets.strip.downcase

      puts "#{filters[filter_indexer(option_key)]} set to #{option_value}".light_blue
      puts "set another filter or hit *enter* to search\n"

      options_hash[option_key] += option_value
      option_key = gets.strip.downcase
    end
    if option_key == ""
      options_hash.each do |index, option|
        url_base += option
      end
      url_base += "&limit=25&v=2&format=json"
    else
      puts "#{'invalid input.'.red}. Try again\n\n"
      sleep(1.5)
      self.get_url
    end
  end

  def self.list_jobs
    #self.display_table(self.jobs)
    Table.display_as_table(self.jobs)
  end

  def self.menu
    self.print_options

    user_input = gets.strip.downcase
    job_index = option_indexer(user_input)

    if job_index.class == Fixnum
      # get job description
      job_key = self.jobs[job_index].jobkey
      json_url = "http://api.indeed.com/ads/apigetjobs?publisher=1863007693750280&jobkeys=#{job_key}&v=2&format=json"
      job = Jobster::Job.make_a_job(json_url)
      # display job description
      Table.display_as_summary(job)

      # ask  for and excute on further user actions
      self.print_actions

      user_input = gets.strip
      case user_input
      when "apply" 
        Launchy.open( job.url )
      when "another"
        self.menu
      when "restart"
        self.run
      when "quit"
        self.goodbye
      else 
        puts "#{'invalid input'.red}\n"
        self.menu
      end
    elsif user_input == 'restart'
      self.run
    elsif user_input == 'quit'
      self.goodbye
    else
      puts "#{'invalid input'.red}\n"
      self.menu
    end 
  end

  # helper methods
  def self.print_filters
    system 'clear'
    puts "\n\tWelcome to #{'Jobster'.yellow}#{'!'.blink} Your one-stop job search buddy\n\n"

    puts "| #{'To find jobs, enter numbers from the options below'.light_blue}"
    puts "| #{'to set their corresponding filters and then hit *enter* to search'.light_blue}"
    puts "|____________________________________________________________________"
    puts "| '1' to set job title\n"
    puts "| '2' to set location\n"
    puts "| '3' to set mile-radius\n"
    puts "| '4' to set job type: 'fulltime' or 'parttime'\n"
    puts "| '5' to sort: 'relevance' or 'date'\n\n"
  end

  def self.print_options
    puts "| #{'choose one of the actions below, to proceed'.light_blue}"
    puts "|_________________________________________________________\n|"
    puts "| '1-#{jobs.count}' to learn more about corresponding job\n"
    puts "| 'restart' to start over\n"
    puts "| 'quit' to exit\n\n"
  end

  def self.print_actions
    puts "| #{'choose one of the actions below, to proceed'.light_blue}"
    puts "|_________________________________________________________\n|"
    puts "| 'apply' to apply to this job\n"
    puts "| 'another' to learn about another job within this search\n"
    puts "| 'restart' to start over\n"
    puts "| 'quit' to exit\n\n"
  end

  def self.goodbye
    puts "\nSee you tomorrow for more jobs"
    puts "#{'Jobster'.yellow}#{'!'.blink} Your one-stop job-search buddy\n\n"
  end

  def self.option_indexer(input)
    valid_indexes = (1..jobs.count).to_a.map(&:to_s)
    if valid_indexes.include?(input)
      input.to_i - 1
    elsif ["exit", "apply"].include?(input)
      input
    else
      "invalid"
    end
  end

  def self.filter_indexer(input)
    index = input
    valid_keys = (1..5).to_a.map(&:to_s) << ""
    valid_keys.include?(input) ? index.to_i - 1 : nil
  end
end