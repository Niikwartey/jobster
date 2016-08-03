class Jobster::IndeedAPI
  
  def self.json(url)
    jobs = JSON.parse( HTTParty.get(url).body )
    jobs["results"].each { |job| job["snippet"] = self.format(job["snippet"]) }
    jobs["results"]
    # binding.pryquit
  end

  # helpers
  def self.format(str)
    str_arr = str.split("<b>").join.split("</b>").join.split
    str_arr.join(" ")
  end

end