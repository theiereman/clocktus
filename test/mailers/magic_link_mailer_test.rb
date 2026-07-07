require "test_helper"

class MagicLinkMailerTest < ActionMailer::TestCase
  test "sign_in_instructions is addressed to the user and carries the code" do
    user = users(:one)
    magic_link = user.magic_links.create!

    mail = MagicLinkMailer.sign_in_instructions(magic_link)

    assert_equal [ user.email_address ], mail.to
    assert_match magic_link.code, mail.subject
    assert_match magic_link.code, mail.body.encoded
  end

  test "sign_in_instructions is localized to the user's locale" do
    user = users(:one)
    user.update!(locale: "fr")

    mail = MagicLinkMailer.sign_in_instructions(user.magic_links.create!)

    assert_match "Votre code Clocktus est", mail.subject
    assert_match "Bonjour,", mail.body.encoded
  end
end
