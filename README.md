This is a Todo App made with Crystal.

# Usage

##### Install PostgreSQL 9.4
##### Create a database in postgres called todo_crystal

##### If you're upgrading remove .deps.lock and .deps folder

```
export DATABASE_URL="postgres://..."
```

```
crystal deps
```

```
crystal db/pg_migrations.cr
```

```
crystal app/main.cr
```
