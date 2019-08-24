//
//  JsonAPI.swift
//  mojimAPI
//
//  Created by Yolanda H. on 2019/8/15.
//  Copyright © 2019 Yolanda H. All rights reserved.
//

import Foundation

struct Item: Codable {
    var title: String
    var snippet: String
}

struct Mojim: Codable {
    var items: [Item]
}

struct Lyrics: Codable {
    var singer: String
    var song: String
    var lyric: String
    var sectionID: Int
    var rowID: Int
}

struct Group:Codable {
    var group:[Lyrics]
}


