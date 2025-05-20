# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# AppUser.create([
#   { name: '张三', mobile: '13800138000' },
#   { name: '李四', mobile: '13800138001' },
#   { name: '王五', mobile: '13800138002' },
#   { name: '赵六', mobile: '13800138003' },
#   { name: '钱七', mobile: '13800138004' },
# ])

# SubFirm.create([
#   { firm_name: '公司A', registered_capital: 1000000.00, address: '地址A', active: true, firm_property: 1 },
#   { firm_name: '公司B', registered_capital: 2000000.00, address: '地址B', active: true, firm_property: 2 }, 
#   { firm_name: '公司C', registered_capital: 3000000.00, address: '地址C', active: false, firm_property: 1 }
# ])

# Teacher.create([
#   { name: 'hung', age: 20, descriotion: 'ruby/js/ ...' },
#   { name: 'chen', age: 20, descriotion: 'ruby/js/vue ...' },
#   { name: 'yuan', age: 25, descriotion: 'ruby/go ...' },
#   { name: 'zeng', age: 26, descriotion: 'ruby/js ...' },
#   { name: 'lu', age: 27, descriotion: 'ruby/go ...' },
#   { name: 'ma', age: 24, descriotion: 'java ...' }
# ])

Student.create([
  { name: '小明', age: 10, teacher_id: 11 },
  { name: 'a', age: 12, teacher_id: 11 },
  { name: 'b', age: 15, teacher_id: 11 },
  { name: 'c', age: 21, teacher_id: 11 },
  { name: 'd', age: 20, teacher_id: 11 },
  { name: 'e', age: 19, teacher_id: 11 },
  { name: 'f', age: 18, teacher_id: 11 },
  { name: 'h', age: 22, teacher_id: 11 },
  { name: 'g', age: 23, teacher_id: 11 },
])