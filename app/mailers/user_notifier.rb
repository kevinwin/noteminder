class UserNotifier < ActionMailer::Base
  add_template_helper(MailerHelper)
  default :from => 'noteminders@gmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thanks for signing up for NoteMinders' )
  end

   # send a note created email to the user, pass in the user object that   contains the user's email address
  def note_created_email(note)
    @note = note
    @deck = note.deck
    @user = note.deck.user
    mail( :to => @user.email,
    :subject => 'You just created a NoteMinder!' )
  end

  def noteminder(note_id)
    @note = Note.find(note_id)
    @deck = note.deck
    @user = note.deck.user
    mail(:to => @user.email, :subject => "A Noteminder for '#{@deck.title}'")
  end
end

