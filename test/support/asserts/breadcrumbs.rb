module Asserts
  module Breadcrumbs
    def assert_breadcrumbs(*paths)
      paths.each_with_index do |path, index|
        child = index + 1
        css_selector = "ol.breadcrumb li:nth-child(#{child})"
        css_selector += " a[href='#{path[:link]}']" if path[:link]

        assert_select css_selector, path[:text]
      end
    end
  end
end
