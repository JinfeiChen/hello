//
//  routeUser.swift
//  App
//
//  Created by cjf on 2020/1/8.
//

import Vapor

public func routeUser(_ router: Router) throws {
    
//    let userController = UserController()
    
    router.get("users", Int.parameter) { req -> String in
        let userID = try req.parameters.next(Int.self)
        return "requested user id #\(userID)"
    }
}
