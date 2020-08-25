class Admins::BaseController < ActionController::Base
  layout 'layouts/admins/application'

  def custom_paginate_renderer
    Class.new(WillPaginate::ActionView::LinkRenderer) do
      def container_attributes
        {class: "pagination"}
      end

      def page_number(page)
        if page == current_page
          "<li class=\"page-item active\">"+link(page, page, class: 'page-link', rel: rel_value(page))+"</li>"
        else
          "<li class=\"page-item\">"+link(page, page, class: 'page-link', rel: rel_value(page))+"</li>"
        end
      end

      def previous_page
        num = @collection.current_page > 1 && @collection.current_page - 1
        previous_or_next_page(num, '<li class="page-item"><i class="page-link">Anterior</i></li>')
      end

      def next_page
        num = @collection.current_page < total_pages && @collection.current_page + 1
        previous_or_next_page(num, '<li class="page-item"><i class="page-link">Próximo</i></li>')
      end

      def previous_or_next_page(page, text)
        if page
          "<li class=\"waves-effect\">"+link(text, page)+"</li>"
        else
          "<li class=\"waves-effect\">"+text+"</li>"
        end
      end
    end
  end
end
