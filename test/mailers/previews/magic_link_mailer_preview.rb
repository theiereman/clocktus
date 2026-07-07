# Preview all emails at http://localhost:3000/rails/mailers/magic_link_mailer
class MagicLinkMailerPreview < ActionMailer::Preview
  def sign_in_instructions
    magic_link = MagicLink.new(user: User.first, code: "AB12CD")
    MagicLinkMailer.sign_in_instructions(magic_link)
  end
end
