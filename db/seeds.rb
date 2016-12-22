admin = User.create!(email: 'admin@admin.ad', password: 'adminadmin', first_name: 'Admin', last_name: 'Admin', role: 'admin')

visit_types = [
  {
    title: 'Trimming claws',
    duration: 15,
    price: 20,
    color: 'Red'
  },
  {
    title: 'Vaccination',
    duration: 20,
    price: 50,
    color: 'Black'
  },
  {
    title: 'Medical advice',
    duration: 60,
    price: 150,
    color: 'Gold'
  }
]

VisitType.create!(visit_types)
