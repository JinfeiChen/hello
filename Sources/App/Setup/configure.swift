//import FluentSQLite
//import FluentPostgreSQL
import FluentMySQL
import Vapor
import Leaf

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    //修改运行端口
    let serverConfig = NIOServerConfig.default(hostname: "127.0.0.1", port: 9090)
    services.register(serverConfig)
    
    //使路由可以渲染需要的Leaf模板
    try services.register(LeafProvider())
    //If your application supports multiple view renderers, you may need to specify that you would like to use Leaf.
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)
    
    // Register providers first
//    try services.register(FluentSQLiteProvider())
//    try services.register(FluentPostgreSQLProvider())
    try services.register(FluentMySQLProvider())  // changed

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure a SQLite database
//    let sqlite = try SQLiteDatabase(storage: .memory)

    // Register the configured SQLite database to the database config.
//    var databases = DatabasesConfig()
//    databases.add(database: sqlite, as: .sqlite)
//    services.register(databases)
//    let postgresqlConfig = PostgreSQLDatabaseConfig(
//      hostname: "127.0.0.1",
//      port: 5432,
//      username: "cjf",
//      database: "mycooldb",
//      password: nil
//    )
//    services.register(postgresqlConfig)
    let mysqlConfig = MySQLDatabaseConfig(
      hostname: "127.0.0.1",
      port: 3306,
      username: "root",
      password: "123456789",
      database: "mycooldb",
      transport: MySQLTransportConfig.unverifiedTLS
    )
//    services.register(mysqlConfig)
    let mysql = MySQLDatabase(config: mysqlConfig)
    var databases = DatabasesConfig()
    databases.add(database: mysql, as: .mysql)
    services.register(databases)

    // Configure migrations
    var migrations = MigrationConfig()
//    migrations.add(model: Todo.self, database: .sqlite)
//    migrations.add(model: User.self, database: .psql)
//    migrations.add(model: User.self, database: .mysql)
//    migrations.add(model: Article.self, database: .mysql)
    migrations.setupModels()
    services.register(migrations)
}
