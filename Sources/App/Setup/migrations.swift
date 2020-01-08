//
//  migrations.swift
//  App
//
//  Created by cjf on 2020/1/8.
//

import Foundation
import Vapor
import FluentMySQL

extension MigrationConfig {
    
    mutating func setupModels() {
        
        add(model: User.self, database: .mysql)
        
        add(model: Article.self, database: .mysql)
    }
}
