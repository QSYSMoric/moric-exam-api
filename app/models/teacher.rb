class Teacher < ApplicationRecord

  has_many :students, foreign_key: :teacher_id, class_name: 'Student', dependent: :destroy

  scope :by_ids, ->(ids) { where(id: ids) }

  has_many :super_structures,
           class_name: 'TeacherStructure',
           foreign_key: :super_id

  has_many :subordinate_structures, 
           class_name: 'TeacherStructure',
           foreign_key: :teacher_id
           
  has_many :supers,
           through: :subordinate_structures,
           source: :super

  has_many :subordinates,
           through: :super_structures,
           source: :teacher

  after_save :deactivate_students_if_old

  def show_name
    return '' if name.blank?
    if name.include?('老师')
      name
    else
      "#{name[0]}老师"
    end
  end

  def all_superiors
    supers = [];

    current_id = id

    loop do

      super_teacher = Teacher.joins(:supers)
        .where(teacher_structures:{ 
          teacher_id: current_id
        })
        .first

      if supers.any? { |t| t.id == super_teacher.id }
        break
      end

      break unless super_teacher

      supers << super_teacher

      current_id = super_teacher.id

    end

    supers

  end

  def self.like(keyword)
    where("name LIKE ?", "%#{keyword}%")
  end

  def self.age_count
    group(:age).count
  end

  def self.average_age

    average(:age).to_i

  end

  def self.teachers_by_age(age)
    data = where('age <= ?', age).order(age: :desc)
    { data: data, count: data.count }
  end

  def self.teachers_by_desc(keyWord)

    data = where.not(descriotion: [nil , ""]).where('descriotion LIKE ?', "%#{keyWord}%")

    data.map do |teacher| 
      "#{teacher.name}-#{teacher.age}"
    end

  end

  def self.mark_free_by_age(age)
    where(age: age).update_all(is_free: true)
  end

  def self.mark_free_by_ids(ids)
    where(id: Array(ids)).update_all(is_free: true)
  end

  def self.mark_free(ids)
    where(id: Array(ids)).update_all(is_free: true)
  end

  def self.mark_deletes(ids)
    where(id: Array(ids)).delete_all
  end

  def self.mark_destroy(ids)
    where(id: Array(ids)).destroy_all
  end

  def self.show_all
    where.not(name: [nil, '']).select(:name,:age,:descriotion)
  end

  def self.one_teacher_per_age
    all.group_by(&:age).map do |age, teachers|
      teachers.first
    end
  end
  
  def self.find_or_create_by_name(name)
    find_or_create_by(name: name)
  end

  def self.list_query(order_by: 'id', page:1, per_page:10)
    order(order_by)
      .offset((page - 1) * per_page)
      .limit(per_page)
  end

  private

  def deactivate_students_if_old
    if saved_change_to_age? && age.present? && age > 60
      Teacher.transaction do
        updated = students.update_all(active: true)
        if updated != students.count
          raise ActiveRecord::Rollback, "学生状态更新失败"
        end
      end
    end
  end

end
