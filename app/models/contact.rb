class Contact < MailForm::Base
  attribute :name,      validate: true
  attribute :email,     validate: /\A([\w.%+\-]+)@([\w\-]+\.)+(\w{2,})\z/i
  attribute :message,   validate: true
  attribute :phone,     validate: true

  def headers
    {
      to: "you@email.com", # change this to be the email you want sent to
      subject: "CleanersApp Contact Form",
      from: "admin@cleanersapp.com",  # change this to be the email it is coming from
      reply_to: %("#{name}" <#{email}>)
    }
  end
end
