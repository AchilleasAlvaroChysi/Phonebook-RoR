class UserMailer < ApplicationMailer

    default :from => "localhost"

     def registration_confirmation(user)
        @user = user
        mail(:to => "<#{user.email}>", :subject => "Registration Confirmation")
     end

end
