class Building < ActiveRecord::Base
  PIERRE = %w(
      2-rue-maurine-audin
      7-allee-de-paris
      5-allee-de-paris
      4-allee-de-paris
      5-rue-gisele-halimi
      6-allee-de-paris
      8-allee-de-paris
      10-rue-des-bateliers
    )
  ANABEL = %w(12-rue-jean-richepin)


  has_many :users
  has_many :messages
  has_many :channels

  def main_channel
    channels.where(channel_type: "main_group").last
  end
end
