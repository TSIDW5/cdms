module Asserts
  module ActiveLink
    def assert_active_link(options = {})
      assert_select "div.sidebar a[href='#{options[:href]}'].active"
    end
  end
end
