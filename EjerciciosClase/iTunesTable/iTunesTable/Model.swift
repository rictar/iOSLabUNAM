//
//  Model.swift
//  iTunesTable
//
//  Created by Ricardo Yepez on 01/09/18.
//  Copyright © 2018 Ricardo Yepez. All rights reserved.
//

import Foundation

struct Results: Codable{
    var resultCount:Int
    var results: [Tracks]
}

struct Tracks: Codable{
    var artistName: String
    var trackName:String
    var artworkUrl100:String
}
