import Vapor
import Leaf

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    router.get("hello", String.parameter) { req -> String in
        let name = try req.parameters.next(String.self)
        return "Hello, \(name)!"
    }

//    struct testArticle: Content {
//        var title: String
//        var content: String
//    }
//    router.post(testArticle.self, at: "api/article") { req, article -> String in
//        return "Loaded article: \(article)"
//    }

    // Example of configuring a controller
//    let todoController = TodoController()
//    router.get("todos", use: todoController.index)
//    router.post("todos", use: todoController.create)
//    router.delete("todos", Todo.parameter, use: todoController.delete)
    
//    let userController = UserController()
//    router.get("users", use: userController.list)
//    router.post("users", use: userController.create)
//    router.patch("users", User.parameter, use: userController.update)
//    router.delete("users", User.parameter, use: userController.delete)

    router.get("helloLeaf") { req -> Future<View> in
        struct WelcomeContext: Encodable {
            var name: String
            var title: String
            var numbers: [Int]
            var now: Date
        }
        return try req.view().render("hello", WelcomeContext(name: "Leaf", title: "Number list:", numbers: [42, 9001, 55], now: Date()))
    }

    // 用户管理api
    try routeUser(router)
    
    // 文章管理api
    try routeArticle(router)
    
}
