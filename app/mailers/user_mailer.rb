class UserMailer < ApplicationMailer

   default :from => "localhost"

   def registration_confirmation(user)
      @user = user
      mail(:to => "<#{user.email}>", :subject => "Registration Confirmation")
   end

   def invitation_email(user, receiver)
      @user = user
      @receiver = receiver
      mail(:from => "<#{user.email}>", :to =>"<#{receiver}>", :subject=>"PhoneBook Invitation")
   end

end
