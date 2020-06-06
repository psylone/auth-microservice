class User < Sequel::Model
  plugin :association_dependencies
  plugin :secure_password, include_validations: false

  NAME_FORMAT = %r{\A\w+\z}

  one_to_many :sessions, class: :UserSession

  add_association_dependencies sessions: :delete

  def validate
    super

    validates_presence :name, message: I18n.t(:blank, scope: 'model.errors.user.name')
    validates_format(NAME_FORMAT, :name, message: I18n.t(:format, scope: 'model.errors.user.name'))

    validates_presence :email, message: I18n.t(:blank, scope: 'model.errors.user.email')

    validates_presence :password, message: I18n.t(:blank, scope: 'model.errors.user.password') if new?
  end
end
