class UserSession < Sequel::Model
  plugin :uuid

  many_to_one :user

  def validate
    super
    validates_presence :uuid, message: I18n.t(:blank, scope: 'model.errors.user_session.uuid')
  end
end
