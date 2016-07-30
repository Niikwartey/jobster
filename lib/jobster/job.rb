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

    puts "| Type the following number and hit 'enter' your search keyword. Then type search to see the jobs.\n"
    puts "|_________________________________________________________\n|"
    puts "| '1' to set job title\n"
    puts "| '2' to set location\n"
    puts "| '3' to set mile-radius\n"
    puts "| '4' to sort (by priority 'relevance', 'date')\n"
    puts "| '5' to sort (by job type 'fulltime', 'parttime')\n\n"

    url_base = "http://api.indeed.com/ads/apisearch?publisher=1863007693750280&q="
    
    # you ask them initially for job title and location, if they accidentally typed in nothing, still give result
    options_hash = {"1" => "", "2" => "&l=", "3" => "&radius=", "4" => "&sort=", "5" => "&jt="}
    
    # get an option key
    option_key = gets.strip.downcase
    while option_key != "" && ["1","2","3","4","5"].include?(option_key)
      option_value = gets.strip.downcase
      options_hash[option_key] += option_value
      option_key = gets.strip.downcase
    end

    if option_key == ""
      options_hash.each do |index, option|
        url_base += option
      end
      self.url = url_base + "&limit=25&v=2&format=json"
    end
  end

end