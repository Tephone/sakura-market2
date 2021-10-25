class NotificationMailer < ApplicationMailer
  def comment_notification(comment)
    @comment = comment
    mail to: comment.user.email, subject: 'あなたの日記にコメントがつきました'
  end

  def like_notification(like)
    @like = like
    mail to: like.user.email, subject: 'あなたの日記にgood!がつきました'
  end
end
