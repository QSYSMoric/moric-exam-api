class PageDto 

  attr_accessor  :current_page,:total_pages,:total_count,:rows,:per_page

  def initialize(page, total_count, per_page , rows)

    @current_page = page

    @total_pages = (total_count.to_f / per_page).ceil

    @total_count = total_count

    @rows = rows

    @per_page = per_page

  end

end