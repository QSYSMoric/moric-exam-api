module ResponseHelper
  # 成功响应 (200)
  def success_response(data = nil, message: 'success', meta: nil)
    status 200
    {
      code: 200,
      message: message,
      data: data,
      meta: meta
    }.compact
  end

  # 错误响应
  def error_response(message, code = 400)
    present :code, code
    present :message, message
  end

  # 分页响应
  def paginated_response(paginated_data, serializer: nil)
    data = serializer ? 
      ActiveModelSerializers::SerializableResource.new(paginated_data, each_serializer: serializer).as_json :
      paginated_data

    success_response(
      data,
      meta: {
        pagination: {
          current_page: paginated_data.current_page,
          total_pages: paginated_data.total_pages,
          total_count: paginated_data.total_count,
          per_page: paginated_data.limit_value
        }
      }
    )
  end
end