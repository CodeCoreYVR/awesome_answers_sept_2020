class AnswerMailer < ApplicationMailer

  def hello_world
    mail(
      to: 'brandon@codecore.ca', #email you want to send mail to
      subject: 'Hello, World from Awesome Answers', #subject line of the email
      from: 'info@awesome_answers.io'
    )
    # the mail method will look for a templete insode of app/views/MAILER_NAME/METHOD_NAME
  end
  # To send mail... inside of any controller you can invoke this method using
  # AnswerMailer.hello_world().deliver
  def notify_question_owner(answer)
    @answer = answer
    @question = answer.question
    @question_owner = @question.user
    mail(
      to: @question_owner.email,
      subject: "#{answer.user.first_name} answered your question!"
    )
    # look for a template called app/views/AnswerMailer/notify_question_owner
  end
end
