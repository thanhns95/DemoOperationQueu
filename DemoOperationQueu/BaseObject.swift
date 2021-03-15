//
//  BaseObject.swift
//  DemoOperationQueu
//
//  Created by Nguyễn Thành on 14/03/2021.
//  Copyright © 2021 TrungNguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class AlbumObject: Mappable {
    var albums: [AlbumBO]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        albums <- map["albums"]
    }
}

class AlbumBO: Mappable {
    var id: Int?
    var title: String?
    var total: String?
    
    init() {
    }
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        total <- map["total"]
    }
}

class PhotosObject: Mappable {
    var photos: [PhotosBO]?
    
    init() {
    }
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        photos <- map["photos"]
    }
}

class PhotosBO: Mappable {
    var albumId: Int?
    var id: Int?
    var title: String?
    var url: String?
    var thumbnailUrl: String?
    
    init() {
    }
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        albumId <- map["albumId"]
        url <- map["url"]
        thumbnailUrl <- map["thumbnailUrl"]
    }
}
