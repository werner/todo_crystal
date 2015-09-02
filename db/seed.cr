require "../main"

User.create("admin", "admin@admin.com", "password", "password") unless User.find_by_email("admin@admin.com")
User.create("jhon", "jhon@doe.com", "password", "password") unless User.find_by_email("jhon@doe.com")
