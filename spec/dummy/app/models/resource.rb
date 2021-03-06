class Resource < ActiveRecord::Base
  
  attr_accessible :frequency, :name, :url, :checked_at

  validates_presence_of :url, :frequency

  scope :expired, where("checked_at IS NULL OR TIMESTAMPDIFF(MINUTE, checked_at, '#{DateTime.now.utc}') > frequency")
  scope :uptodated, where("TIMESTAMPDIFF(MINUTE, checked_at, '#{DateTime.now.utc}') <= frequency")

  def read
    if self.checked_at.nil? || (DateTime.now.to_i - DateTime.parse(self.checked_at.utc.to_s).to_i)/60 > self.frequency
      reader = FeedReader::Reader.new self.url
      news = reader.filter Keyword.includables_list
    end
    news
  end

  def read_and_update
    items = read
    items.each do |item|
      Post.create :title => item[0], :description => item[1], :image_url => item[2], :url => item[3]
    end
    update_attributes( :checked_at => DateTime.now )
    items
  end

end
