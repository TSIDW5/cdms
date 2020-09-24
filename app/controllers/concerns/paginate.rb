module Paginate
  extend ActiveSupport::Concern

  private

  def paginate(entity_symbol, paginate_route)
    keyword_query_param = params[:search]&.[](:keyword)
    keyword_route_param = params[:keyword]
    has_query_param = !keyword_query_param.nil?

    if has_query_param
      redirect_to paginate_route.call(page: params[:page], keyword: keyword_query_param)
    else
      @keyword = keyword_route_param
      yield
    end
  end
end
