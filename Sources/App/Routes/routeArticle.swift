//
//  routeArticle.swift
//  App
//
//  Created by cjf on 2020/1/8.
//

import Vapor

public func routeArticle(_ router: Router) throws {
    
    let articleController = ArticleController()
    
    router.post("api", "article", use: articleController.create)
    router.delete("api", "article", Article.parameter, use: articleController.delete)
    router.get("api", "article", use: articleController.listAll)
    router.get("api", "article", Int.parameter, use: articleController.list)
    router.patch("api", "article", Article.parameter, use: articleController.update)
}

