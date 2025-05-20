class Company < ApplicationRecord

  ## 公司下面的联系人
  has_many :contacts, dependent: :destroy

  ## 公司下的跟进任务
  has_many :tasks, dependent: :destroy

  ## 公司下的跟进人
  belongs_to :follow_person, class_name: 'User', optional: true

  ####### 
  # @description: 分页查询公司列表
  # @param page [Integer] 当前页码
  # @param per_page [Integer] 每页数量
  # @param company_name [String] 公司名称(可选)
  # @param follow_person_id [Integer] 跟进人ID(可选)
  # @return [Hash] 分页结果
  # 
  def self.list_query(page = 1, per_page = 10, company_name = nil, follow_person_id = nil)

    query = order(:id)
    
    # 添加条件过滤
    query = query.where(name: company_name) if company_name.present?

    query = query.where(follow_person_id: follow_person_id) if follow_person_id.present?
    
    # 计算总数
    total_count = query.count
    
    # 计算分页数据
    companies = query.offset((page - 1) * per_page).limit(per_page)
    
    dto = Hash.new

    {
      current_page: page,
      total_pages: (total_count.to_f / per_page).ceil,
      total_count: total_count,
      rows: companies,
      per_page: per_page
    }

    PageDto.new(page, total_count, per_page, companies)

  end

  ####### 
  # @description: 查询没有跟进任务的公司
  # @return {*}
  # 
  def self.companies_without_tasks

    sql = <<~SQL
      SELECT c.name
      FROM companies c
      LEFT JOIN tasks t ON c.id = t.company_id
      WHERE t.id IS NULL
      ORDER BY c.name ASC
    SQL

    ActiveRecord::Base.connection.exec_query(sql)
    
  end
    
end