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
require 'test_helper'

class NfeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
