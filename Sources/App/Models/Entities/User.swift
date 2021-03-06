//import FluentPostgreSQL  // changed
import FluentMySQL
import Vapor
//final class User: PostgreSQLModel {
final class User: MySQLModel {
  var id: Int?
  var username: String
  init(id: Int? = nil, username: String) {
    self.id = id
    self.username = username
  }
}
extension User: Content {}
extension User: Migration {}
extension User: Parameter {}
