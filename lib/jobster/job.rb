class Jobster::Job
  attr_accessor :jobtitle, :location, :description, :jobkey, :url

  @@all = []
  def self.all
    @@all
  end

  def self.make_jobs(url)
    jobs = Jobster::IndeedAPI.json(url)

    jobs.each do |job|
      self.new(job["jobtitle"], job["formattedLocation"], job["snippet"], job["jobkey"], job["url"]).save
    end

    self.all
  end

  def self.make_a_job(url)
    job = Jobster::IndeedAPI.json(url)[0]

    self.new(job["jobtitle"], job["formattedLocation"], job["snippet"], job["jobkey"], job["url"])
  end

  def initialize(jobtitle, location, description, jobkey, url)
    @jobtitle = jobtitle
    @location = location
    @description = description
    @jobkey = jobkey
    @url = url
  end

  def save
    self.class.all << self
  end
end