# == Schema Information
#
# Table name: nfes
#
#  id           :bigint           not null, primary key
#  dh_emi       :datetime
#  num_nf       :string
#  num_serie    :string
#  v_cofins     :decimal(10, 2)
#  v_icms       :decimal(10, 2)
#  v_ipi        :decimal(10, 2)
#  v_pis        :decimal(10, 2)
#  v_total      :decimal(10, 2)
#  v_trib       :decimal(10, 2)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  issuer_id    :bigint           not null
#  recipient_id :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_nfes_on_issuer_id     (issuer_id)
#  index_nfes_on_recipient_id  (recipient_id)
#  index_nfes_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (issuer_id => issuers.id)
#  fk_rails_...  (recipient_id => recipients.id)
#  fk_rails_...  (user_id => users.id)
#
class Nfe < ApplicationRecord
  self.table_name = 'nfes'

  has_one_attached :xml

  belongs_to :issuer
  belongs_to :recipient

  belongs_to :user

  has_many :products, dependent: :destroy

  after_destroy :destroy_dependents

  def self.ransackable_attributes(_auth_object = nil)
    %w[num_serie num_nf dh_emi v_icms v_ipi v_pis v_cofins v_total v_trib]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[issuer recipient]
  end

  DECIMAL_FIELDS = %w[
    v_icms
    v_ipi
    v_pis
    v_cofins
    v_total
    v_trib
  ].freeze

  DECIMAL_FIELDS.each do |field|
    ransacker field do
      Arel.sql("to_char(\"nfes\".\"#{field}\", '99999999.99')")
    end
  end

  private

  def destroy_dependents
    issuer.destroy
    recipient.destroy
  end
end
