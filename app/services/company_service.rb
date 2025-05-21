module CompanyService 

  ####### 
  # @description: 分页查询公司
  # @return {*}
  # 
  def self.list_query(page = 1 , per_page = 10 , company_name = nil, follow_person_id = nil)

    Company.list_query( page, per_page)

  end

  ####### 
  # @description: 创建公司
  # @return {*}
  # 
  def self.create_compony(params)

    user = User.find(params[:follow_person_id])
      
    com = Company.create(params)

    com.as_json(include: { follow_person: { only: [:id, :name] } })

  end

  ####### 
  # @description: 修改公司信息
  # @return {*}
  # 
  def self.set_compony(company_id, params)

    company = Company.find(company_id)

    company.name = params[:name]

    company.phone = params[:phone]
    
    company.address = params[:address]
    
    company.post_code = params[:post_code]

    company.follow_person_id = params[:follow_person_id]

    company.save

    company

  end

  
  ####### 
  # @description: 获取公司详情
  # @return {*}
  # 
  def self.get_compony(company_id)

    company = Company
        .includes(
          :contacts,
          :follow_person
        )
        .includes(tasks: [:contact, :follow_person])
        .find(company_id)

    company.as_json(
      include: {
        contacts: {
          methods: [:masked_phones],
          except: [:phones]
        },
        tasks: {
           contact: { },
           follow_person: { only: [:id, :name] }
        },
        follow_person: {
          only: [:id, :name]
        }
      }
    )

  end

  ####### 
  # @description: 添加联系人
  # @return {*}
  # 
  def self.add_compony_contact(company_id, params)

    company = Company.find(company_id)

    contact = Contact.create(params)

    company.contacts.push(contact)

    contact

  end

  ####### 
  # @description: 删除联系人
  # @return {*}
  # 
  def self.delete_compony_contact(contact_id)

    contact = Contact.find(contact_id)

    contact.destroy!

  end

  ####### 
  # @description: 删除公司
  # @return {*}
  # 
  def self.delete_compony(company_id)

    Company.transaction do

      Task.where(company_id: company_id).delete_all

      Contact.where(company_id: company_id).delete_all

      Company.delete(company_id)

    end
  
  end

  ####### 
  # @description: 创建跟进记录
  # @return {*}
  # 
  def self.add_task(company_id, params)

    company = Company.find(company_id)

    task = Task.create(params)

    company.tasks.push(task)

    task

  end
  
  ####### 
  # @description: 修改跟进记录
  # @return {*}
  # 
  def self.set_task(task_id, params)

    p task_id,params

    task = Task.find(task_id)

    p task
    
    task_form = params.slice(:time, :stage, :user_id, :state, :contact_id, :remark, :contact_information)
    
    task.update!(task_form)

    task

  end

  ####### 
  # @description: 删除跟进记录
  # @return {*}
  # 
  def self.delete_task(task_id)

    p task_id

    task = Task.find(task_id)

    task.destroy!

  end

  ####### 
  # @description: 获取公司下面的跟进记录
  # @return {*}
  # 
  def self.get_tasks(company_id)

    tasks = Task.where(company_id: company_id)

    tasks

  end

  ####### 
  # @description: 更新跟进记录状态
  # @return {*}
  # 
  def self.set_task_stats(task_ids)

    tasks = Task.where(id: Array(task_ids))

    tasks.update_all(state: 1)

    if updated != students.count
        raise "状态更新失败"
    end

  end

end