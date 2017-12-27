# Two products with same name and enterprise can't exist simultaneously.
class ProductUniquenessValidator < ActiveModel::Validator
  def validate(record)
    found = Product.find_by(enterprise: record.enterprise, model: record.model)
    record.errors[:model] << I18n.t(:already_used) if !found.nil? && record != found
  end
end
