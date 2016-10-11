class LikeMailer < ApplicationMailer
  default from: 'likes@myapp.com'

  def game_liked_email(data, to='rohanthewiz@gmail.com')
    return unless data.is_a?(Hash) && data.any?
    @game = data
    @recipient = to
    mail(to: @recipient, subject: "\"#{@game[:name]}\" liked!")
  end
end
