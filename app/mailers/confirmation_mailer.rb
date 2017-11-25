class ConfirmationMailer < ApplicationMailer
    
      default from: "emailparapruebas01@gmail.com"
      layout 'mailer'
    
      def verification_send(user)
    #  @company=company
        @user=user
        mail(to: user.email, subject:"Verificacion")
        #@parameters[:companymail]
      end

      def user_activated(user)
        @user=user
        mail(to: user.email, subject:"Account Confirmated!")
      end
    
    end
    