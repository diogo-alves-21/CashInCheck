# == Schema Information
#
# Table name: groups
#
#  id         :uuid             not null, primary key
#  name       :string(50)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Group, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
