desc 'Checking the dates of letters'
task :checking_dates => :environment do
  @letters = Letter.where("created_at < ?", 3.months.ago)
  @letters = @letters.where(:mail_status => ["new", "active"])
  @letters.find_each do |letter|
    letter.update_attributes!(:mail_status => "ended")
  end
end
