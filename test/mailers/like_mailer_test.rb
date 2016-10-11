require 'test_helper'

class LikeMailerTest < ActionMailer::TestCase
  test 'game liked' do
    recipient = 'johnbrown@example.com'
    default_from = LikeMailer.default_params[:from]
    mail_params = {
        name: 'Test Game',
        year: '1970',
        publisher: 'ABC Co.',
        likes: 3,
        liked_by: '127.0.0.1'
    }
    email = LikeMailer.game_liked_email(mail_params, recipient).deliver_now
    refute ActionMailer::Base.deliveries.empty?
    assert_equal [default_from], email.from
    assert_equal [recipient], email.to
    assert_equal "\"#{mail_params[:name]}\" liked!", email.subject
    not_in_body = ' not found in email body'
    assert email.body.parts.first.to_s.include?(mail_params[:name]), "#{mail_params[:name]}#{not_in_body}"
    assert email.body.parts.second.to_s.include?(mail_params[:name]), "#{mail_params[:name]}#{not_in_body}"
    assert email.body.parts.first.to_s.include?(mail_params[:year]), "#{mail_params[:year]}#{not_in_body}"
    assert email.body.parts.second.to_s.include?(mail_params[:year]), "#{mail_params[:year]}#{not_in_body}"
    assert email.body.parts.first.to_s.include?(mail_params[:publisher]), "#{mail_params[:publisher]}#{not_in_body}"
    assert email.body.parts.second.to_s.include?(mail_params[:publisher]), "#{mail_params[:publisher]}#{not_in_body}"
    assert email.body.parts.first.to_s.include?(mail_params[:liked_by]), "#{mail_params[:liked_by]}#{not_in_body}"
    assert email.body.parts.second.to_s.include?(mail_params[:liked_by]), "#{mail_params[:liked_by]}#{not_in_body}"
  end
end
