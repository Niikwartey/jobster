class Jobster::JobsRequest
  attr_accessor :url
  
  def initialize
    self.json_url
  end


  def json
    begin
      JSON.parse( HTTParty.get(self.url).to_s )
    rescue JSON::ParserError => e
      self.json
    end
  end

  def json_url
    puts "Welcome to Jobster! Your one stop command line job search buddy\n\n"

    puts "| To search for jobs, enter a numbers from the options below"
    puts "| to set their corresponding filters and then hit 'enter' to search\n"
    puts "|_________________________________________________________\n|"
    puts "| '1' to set job title\n"
    puts "| '2' to set location\n"
    puts "| '3' to set mile-radius\n"
    puts "| '4' to sort (by priority 'relevance', 'date')\n"
    puts "| '5' to sort (by job type 'fulltime', 'parttime')\n\n"

    url_base = "http://api.indeed.com/ads/apisearch?publisher=1863007693750280&q="
    
    # you ask them initially for job title and location, if they accidentally typed in nothing, still give result
    options = {"1" => "", "2" => "&l=", "3" => "&radius=", "4" => "&sort=", "5" => "&jt="}
    filters = ["job title", "location", "mile-radius", "priority", "job type"]
    
    # get an option key
    option_key = gets.strip.downcase
    while true
      if option_key == ""
        options.values.each { |option| url_base += option }
        self.url = url_base + "&limit=25&v=2&format=json"
        break
      else
        puts "what will be the #{filters[indexer(option_key)]}?".light_blue

        option_value = gets.strip.downcase
        options[option_key] += option_value

        puts "#{filters[indexer(option_key)]} set to #{option_value}".light_blue
        puts "set another filter or hit 'enter' to search\n"

        option_key = gets.strip.downcase
      end
    end
    
  end

  def indexer(input)
    index = input
    valid_keys = (1..5).to_a.map(&:to_s)
    if valid_keys.include?(input)
      index.to_i - 1
    else
      puts "invalid response ..Try again"
      self.json_url
    end
  end

end