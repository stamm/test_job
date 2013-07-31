require 'spec_helper'

describe User do
  it '#add_balance' do
    user = create :user
    expect { user.add_balance 100 }.to change { user.balance }.from(0).to(100)
  end
end
