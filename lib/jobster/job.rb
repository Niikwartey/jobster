class Jobster::Job
  attr_accessor :title, :location, :info, :url

  def self.json
    JSON.parse(self.http_json)
  end

  def self.http_json
    puts "Welcome to Jobster! Your one stop command line job search buddy. Type the following number and enter your search keyword. Then type search to see the jobs."
    puts "1. Job Title"
    puts "2. Location"
    puts "3. Miles within Location (radius)"
    puts "4. Sort by (relevance, date)"
    puts "5. Job type (fulltime, parttime, contract, internship, temporary)."

    url_base = "http://api.indeed.com/ads/apisearch?publisher=1863007693750280&q="
    
    # you ask them initially for job title and location, if they accidentally typed in nothing, still give result
    options_hash = {"1" => "", "2" => "&l=", "3" => "&radius=", "4" => "&sort=", "5" => "&jt="}
    
    # get an option key
    option_key = gets.strip.downcase
    while option_key != "search" && ["1","2","3","4","5"].include?(option_key)
      option_value = gets.strip.downcase
      options_hash[option_key] += option_value
      option_key = gets.strip.downcase
    end

    if option_key == "search"
      options_hash.each do |index, option|
        url_base += option
      end
      json_url = url_base + "&v=2&format=json"

      HTTParty.get(json_url).to_s
    end
    
  end

end