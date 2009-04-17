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
    guards_and_clauses = clauses.inject(Hash.new) do |memo, (guard, code)|
      suffix = [guard.inspect, code.inspect, rand.to_s.sub(".", "")].join("_")
      guard_method_name = "defmulti_guard_#{suffix}"
      code_method_name  = "defmulti_code_#{suffix}"

      if guard then
        define_method(guard_method_name, &guard)
      else
        guard_method_name << "_true"
        define_method(guard_method_name) { true }
      end

      if code.respond_to?(:call) then
        define_method(code_method_name, &code)
      else
        define_method(code_method_name) do
          code
        end
      end

      memo[guard_method_name] = code_method_name
      memo
    end

    define_method(selector) do |*arguments|
      code_to_run = guards_and_clauses.detect do |guard, code|
        break code if send(guard, *arguments)
      end

      if code_to_run then
        send(code_to_run, *arguments)
      else
        raise MissingGuardClause.new(self, selector)
      end
    end
  end
end

class Module
  include Defmulti
end
