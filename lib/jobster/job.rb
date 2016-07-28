class Jobster::Job
  attr_accessor :title, :location, :info, :url

  def self.result

    self.scrape_woot
  end

  def self.scrape_deals
    deals = []
    deals << self.scrape_woot
    deals
  end

  def self.scrape_woot

    # response = Net::HTTP.get_response("api.indeed.com","/ads/apisearch?publisher=1863007693750280&q=java&l=austin%2C+tx&sort=&radius=&st=&jt=&start=&limit=&fromage=&filter=&latlong=1&co=us&chnl=&userip=1.2.3.4&useragent=Mozilla/%2F4.0%28Firefox%29&v=2&format=json")
    # response.body
    json_stuff = HTTParty.get("http://api.indeed.com/ads/apisearch?publisher=1863007693750280&q=java&l=austin%2C+ny&sort=&radius=&st=&jt=&start=&limit=&fromage=&filter=&latlong=1&co=us&chnl=&userip=1.2.3.4&useragent=Mozilla/%2F4.0%28Firefox%29&v=2&format=json")
    # doc_hash = doc.css("p").text
  end

    #return instances of job searches
    # puts <<-DOC.gsub /^\s*/, ''
    # 1. Java Developer - NY
    # 2. PHP Developer - MA
    # DOC

  #   Jobster::IndeedAPI.new


  #   job_1 = self.new
  #   job_1.name = "Java Developer"
  #   job_1.location = "NY"
  #   job_1.info = "More Info"
  #   job_1.url = "www.indeed.com"

  #   job_2 = self.new
  #   job_2.name = "PHP Developer"
  #   job_2.location = "MA"
  #   job_2.info = "More Info"
  #   job_2.url = "www.indeed.com"

  #   [job_1, job_2]

  # end

end