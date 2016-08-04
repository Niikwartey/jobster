class Jobster::Job
  attr_accessor :jobtitle, :location, :description, :jobkey, :url

  @@all = []
  def self.all
    @@all
  end

  def initialize(job)
    @jobtitle = job["jobtitle"]
    @location = job["formattedLocation"]
    @description = job["snippet"]
    @jobkey = job["jobkey"]
    @url = job["url"]
  end

  def save
    self.class.all << self
  end
end