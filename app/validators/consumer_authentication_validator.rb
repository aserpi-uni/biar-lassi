# A Consumer must have an email address or a Facebook account.
class ConsumerAuthenticationValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:base] << I18n.t(:no_auth_methods) if record.provider.blank? && record.email.blank?
  end
end
