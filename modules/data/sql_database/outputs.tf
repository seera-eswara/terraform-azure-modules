output "id" {
  description = "The ID of the created SQL Database"
  value       = azurerm_mssql_database.sql_db.id
}

output "name" {
  description = "The name of the created SQL Database"
  value       = azurerm_mssql_database.sql_db.name
}

output "database_id" {
  description = "The database ID"
  value       = azurerm_mssql_database.sql_db.id
}

output "collation" {
  description = "The collation of the database"
  value       = azurerm_mssql_database.sql_db.collation
}
