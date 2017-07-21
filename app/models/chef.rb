class Chef < ApplicationRecord
  #has_many :recipes
  
  before_save { self.email = email.downcase }
  
  validates :name, length: { minimum: 5, maximum: 40 }
  
  VALID_EMAIL_REGEXP = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i; 
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEXP }, 
                    uniqueness: { case_sensitive: false }
end