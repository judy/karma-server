# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  permalink  :string(255)     not null
#  created_at :datetime
#  updated_at :datetime
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @user = User.make
  end

  it "should create a new instance" do
  end
end