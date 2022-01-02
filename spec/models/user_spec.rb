require 'spec_helper'
require 'rails_helper'

describe User do

  it "can be valid" do
    user_dic = {:first_name => 'John',
                :last_name => 'Smith',
                :email => 'a@a.com',
                :password => "12345",
                :session_token => ""
    }
    user = User.new(user_dic)
    expect(user).to be_valid
  end
  it "is not valid without a first name" do
    user_dic = {:last_name => 'Smith',
                :email => 'a@a.com',
                :password => "12345",
                :session_token => ""
    }
    user = User.new(user_dic)
    expect(user).to_not be_valid
  end

  it "is not valid without a last name" do
    user_dic = {:first_name => 'John',
                :email => 'a@a.com',
                :password => "12345",
                :session_token => ""
    }
    user = User.new(user_dic)
    expect(user).to_not be_valid
  end

  it "is not valid without an email" do
    user_dic = {:first_name => 'John',
                :last_name => 'Smith',
                :password => "12345",
                :session_token => ""
    }
    user = User.new(user_dic)
    expect(user).to_not be_valid
  end

  it "is not valid without an valid email" do
    user_dic = {:first_name => 'John',
                :last_name => 'Smith',
                :email => 'a',
                :password => "12345",
                :session_token => ""
    }
    user = User.new(user_dic)
    expect(user).to_not be_valid
  end

  it "is not valid without an unique email" do
    user_dic = {:first_name => 'John',
                :last_name => 'Smith',
                :email => 'inco@gnito.com',
                :password => "12345",
                :session_token => ""
    }
    user = User.new(user_dic)
    expect(user).to_not be_valid
  end


  it "creates session token on save" do
    user_dic = {:first_name => 'John',
                :last_name => 'Smith',
                :email => 'a@a.com',
                :password => "12345"
    }
    user = User.new(user_dic)
    user.save!
    expect(user.session_token).to be_truthy
  end

  it "creates password on save" do
    user_dic = {:first_name => 'John',
                :last_name => 'Smith',
                :email => 'a@a.com'
    }
    user = User.new(user_dic)
    user.save!
    expect(user.password).to be_truthy
  end

end
