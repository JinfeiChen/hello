//
//  ArticleController.swift
//  App
//
//  Created by cjf on 2020/1/7.
//

import Vapor
import FluentMySQL

final class ArticleController {
    
//    func list(_ req: Request) throws -> Future<[Article]> {
//        return Article.query(on: req).all()
//    }
    
    func listAll(_ req: Request) throws -> Future<Response> {
        return Article.query(on: req).all().flatMap { (list) in
            return try ResponseJSON<[Article]>(data: list).encode(for: req)
        }
    }
    
    func list(_ req: Request) throws -> Future<Response> {
        let articleId = try req.parameters.next(Int.self)
        return Article.query(on: req).filter(\.id == articleId).all().flatMap { (list) in
            guard list.count != 0 else {
                return try ResponseJSON<Empty>(status: .error,
                                               message: "Not found article with id: \(articleId)!").encode(for: req)
            }
            return try ResponseJSON<Article>(data: list.first).encode(for: req)
        }
    }

//    func create(_ req: Request) throws -> Future<Article> {
//        return try req.content.decode(Article.self).flatMap { article in
//            return article.save(on: req)
//        }
//    }
    
    func create(_ req: Request) throws -> Future<Response> {
        return try req.content.decode(Article.self).flatMap { article in
            return article.save(on: req).flatMap { (newArticle) in
                return try ResponseJSON<Article>(status: .ok,
                                                 message: "Create success!", data: newArticle).encode(for: req)
            }
        }
    }
    
//    func delete(_ req: Request) throws -> Future<HTTPStatus> {
//        return try req.parameters.next(Article.self).flatMap { article in
//            return article.delete(on: req)
//        }.transform(to: .ok)
//    }
    
    func delete(_ req: Request) throws -> Future<Response> {
        return try req.parameters.next(Article.self).flatMap { article in
            return article.delete(on: req).flatMap { (res) in
                return try ResponseJSON<Empty>(status: .ok,
                                               message: "Delete success!").encode(for: req)
            }
        }
    }
    
//    func update(_ req: Request) throws -> Future<Article> {
//      return try req.parameters.next(Article.self).flatMap { article in
//        return try req.content.decode(Article.self).flatMap { newArticle in
//          article.title = newArticle.title
//          return article.save(on: req)
//        }
//      }
//    }
    
    func update(_ req: Request) throws -> Future<Response> {
      return try req.parameters.next(Article.self).flatMap { article in
        return try req.content.decode(Article.self).flatMap { newArticle in
            article.title = newArticle.title
            article.content = newArticle.content
            article.author = newArticle.author
            article.copyFrom = newArticle.copyFrom
            article.url = newArticle.url
            return article.save(on: req).flatMap { (res) in
                return try ResponseJSON<Article>(status: .ok,
                                                 message: "Update Success!",
                                                 data: newArticle).encode(for: req)
            }
        }
      }
    }
}


