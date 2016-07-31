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
    system 'clear'
    puts "\n\tWelcome to #{'Jobster'.yellow}#{'!'.blink} Your one stop command line job search buddy\n\n"

    puts "| #{'To search for jobs, enter numbers from the options below'.light_blue}"
    puts "| #{'to set their corresponding filters and then hit *enter* to search'.light_blue}"
    puts "|____________________________________________________________________"
    puts "| '1' to set job title\n"
    puts "| '2' to set location\n"
    puts "| '3' to set mile-radius\n"
    puts "| '4' to set job type: 'fulltime' or 'parttime'\n"
    puts "| '5' to sort: 'relevance' or 'date'\n\n"

    url_base = "http://api.indeed.com/ads/apisearch?publisher=1863007693750280&q="
    
    # you ask them initially for job title and location, if they accidentally typed in nothing, still give result
    options = {"1" => "", "2" => "&l=", "3" => "&radius=", "4" => "&jt=", "5" => "&sort="}
    filters = ["job title", "location", "mile-radius", "job type", "sorting"]
    
    # get an option key
    option_key = gets.strip.downcase
    while true
      if option_key == ""
        options.values.each { |option| url_base += option }
        self.url = url_base + "&limit=25&v=2&format=json"
        break
      elsif indexer(option_key)
        puts "what will be the #{filters[indexer(option_key)]}?".light_blue

        option_value = gets.strip.downcase
        options[option_key] += option_value

        puts "#{filters[indexer(option_key)]} set to #{option_value}".light_blue
        puts "set another filter or hit *enter* to search\n"

        option_key = gets.strip.downcase

      else
        puts "#{'invalid input.'.red} Try again\n\n"
        self.json_url
      end
    end
    
  end

  def indexer(input)
    index = input
    valid_keys = (1..5).to_a.map(&:to_s)
    valid_keys.include?(input) ? index.to_i - 1 : nil
  end

end