class Table
  extend CommandLineReporter

  def self.display_as_table(jobs)
    vertical_spacing 2
    table :border => true do
      row :color => 'light_blue' do
        column '', :width => 2
        column 'Position', :width => 35, :bold => true
        column 'Location', :width => 25, :align => 'center'
        column 'Job description', :width => 70
      end

      jobs.each_with_index do |job, index|
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

  def self.display_as_summary(job)
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
  
end

#Table.new().run