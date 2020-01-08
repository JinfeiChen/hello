//
//  Article.swift
//  App
//
//  Created by cjf on 2020/1/7.
//

import FluentMySQL
import Vapor

final class Article: MySQLModel {
    var id: Int?
    var title: String //标题
    var content: String //内容
    var url: String? //链接地址
    var author: String? //作者
    var copyFrom: String? //转载
    var hits: Int? //浏览数
    var createTime: Date? //创建日期
    var updateTime: Date? //修改日期
    var status: Int? //状态
    
    init(id: Int? = nil,
         title: String,
         content: String,
         url: String? = nil,
         author: String? = nil,
         copyFrom: String? = nil,
         hits: Int? = nil,
         createTime: Date? = nil,
         updateTime: Date? = nil,
         status: Int? = nil) {
        self.id = id
        self.title = title
        self.content = content
        self.url = url
        self.author = author
        self.copyFrom = copyFrom
        self.hits = hits
        self.createTime = createTime
        self.updateTime = updateTime
        self.status = status
    }
}
extension Article: Content {}
extension Article: Migration {}
extension Article: Parameter {}
