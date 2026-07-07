require "test_helper"

class ReminderMailerTest < ActionMailer::TestCase
  test "fill_reminder is addressed to the user" do
    user = users(:one)

    mail = ReminderMailer.fill_reminder(user)

    assert_equal [ user.email_address ], mail.to
  end

  test "fill_reminder is localized to the user's locale" do
    user = users(:one)
    user.update!(locale: "fr")

    mail = ReminderMailer.fill_reminder(user)

    assert_match "N'oubliez pas de remplir vos heures", mail.subject
    assert_match "Bonjour,", mail.body.encoded
  end
end
