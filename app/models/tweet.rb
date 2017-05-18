class Tweet < ApplicationRecord
  belongs_to :user
  has_many :tweet_tags
  has_many :tags, through: :tweet_tags

  before_validation :link_check
  after_validation :apply_link


  validates :message, presence: true
  validates :message, length: {maximum: 140}

  private

  def link_check
    if self.message.include? "http://"
      arr = self.message.split
      index = arr.map { |x| x.include? "http://"}.index(true)
      self.link = arr[index]

      if arr [index].length > 23
        arr[index] = "#{arr[index][0..20]}..."
      end

      self.message = arr.join(" ")
    end
  end

  def apply_link
    arr = self.message.split
    index = arr.map { |x| x.include? "http://"}.index(true)
    if index != nil
      url = arr[index]
      arr[index] = "<a href='#{self.link}' target='_blank'>#{url}</a>"
      self.message = arr.join(" ")
    end

  end


end
