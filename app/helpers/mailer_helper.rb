module MailerHelper
  EMAIL_FONT = "'Bricolage Grotesque', 'Trebuchet MS', 'Segoe UI', Helvetica, Arial, sans-serif".freeze
  TEXT_COLOR = "#3b3b3b".freeze
  BACKGROUND_COLOR = "#fffcf4".freeze
  PRIMARY_COLOR = "#ffb900".freeze
  MUTED_COLOR = "#8a867c".freeze

  def email_font = EMAIL_FONT

  def email_heading_style
    "margin:0 0 18px; font-family:#{EMAIL_FONT}; font-size:26px; line-height:1.15; font-weight:800; text-transform:uppercase; color:#{TEXT_COLOR};"
  end

  def email_text_style
    "margin:0 0 16px; font-family:#{EMAIL_FONT}; font-size:16px; line-height:1.6; color:#{TEXT_COLOR};"
  end

  def email_muted_text_style
    "margin:20px 0 0; font-family:#{EMAIL_FONT}; font-size:13px; line-height:1.5; color:#{MUTED_COLOR};"
  end

  def email_button_style
    "display:inline-block; font-family:#{EMAIL_FONT}; font-size:15px; font-weight:800; letter-spacing:0.5px; text-transform:uppercase; color:#{TEXT_COLOR}; background-color:#{PRIMARY_COLOR}; border:3px solid #{TEXT_COLOR}; padding:12px 28px; text-decoration:none;"
  end

  def email_code_style
    "display:inline-block; font-family:#{EMAIL_FONT}; font-size:30px; font-weight:800; letter-spacing:8px; color:#{TEXT_COLOR}; background-color:#{PRIMARY_COLOR}; border:3px solid #{TEXT_COLOR}; padding:14px 8px 14px 16px;"
  end
end
