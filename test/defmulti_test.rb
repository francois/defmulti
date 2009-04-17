require "test_helper"

class Account
  attr_accessor :balance

  def initialize(balance)
    @balance = balance
  end
end

D "#defmulti with simple, mutually exclusive, guards" do
  class AccountWithBalanceType < Account
    defmulti :balance_type,
      lambda {self.balance  < 0}  => lambda {:negative},
      lambda {self.balance  > 0}  => lambda {:positive},
      lambda {self.balance.zero?} => lambda {:nil}
  end

  T { AccountWithBalanceType.new(  0).balance_type == :nil      }
  T { AccountWithBalanceType.new( 50).balance_type == :positive }
  T { AccountWithBalanceType.new(-50).balance_type == :negative }
end

D "#defmulti with else clause" do
  class AccountWithElse < Account
    defmulti :balance_type,
      lambda {self.balance < 0} => lambda {:negative},
      nil                       => lambda {:positive}
  end

  T { AccountWithElse.new( 0).balance_type == :positive }
  T { AccountWithElse.new(-1).balance_type == :negative }
end

D "#defmulti raises MissingGuardClause when no else and no guards match" do
  class AccountWithoutElse < Account
    defmulti :balance_type,
      lambda { self.balance < 0 } => lambda { :negative }
  end

  E(Defmulti::MissingGuardClause) { AccountWithoutElse.new(0).balance_type }
end

D "#defmulti with simple return values" do
  class AccountWithSimpleReturnValues < Account
    defmulti :balance_type,
      lambda { self.balance < 0 } => :negative,
      nil                         => :positive
  end

  T { AccountWithSimpleReturnValues.new( 1).balance_type == :positive }
  T { AccountWithSimpleReturnValues.new(-1).balance_type == :negative }
end
