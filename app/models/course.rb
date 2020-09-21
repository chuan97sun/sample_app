class Course < ApplicationRecord
  has_many :reviews
  
  enum status: { opening: 0, started: 1, finished:2 }

  after_initialize do
    if self.new_record?
      self.status ||= :opening
    end
  end
end
