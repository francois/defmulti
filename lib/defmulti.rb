require "pp"

module Defmulti
  class MissingGuardClause < NotImplementedError
    def initialize(object, selector)
      super "#{object.inspect} received #{selector} but did not have a guard clause that matched and no else clause."
    end
  end

  private
  def defmulti(selector, *args)
    clauses = args.pop.to_a
    clauses = clauses.sort_by {|guard, _| guard.nil? ? 1 : 0}
    define_method(selector) do |*arguments|
      clauses.each do |guard, code|
        if guard then
          guard_value = instance_eval(&guard)
          next unless guard_value
        end

        # Have to break or else #each will continue to the end
        break code.respond_to?(:call) ? instance_eval(&code) : code
      end
    end
  end
end

class Module
  include Defmulti
end
