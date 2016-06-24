//
//  Player.swift
//  Ratings
//
//  Created by Akshay Bhandary on 6/23/16.
//  Copyright © 2016 Akshay Bhandary. All rights reserved.
//

import Foundation

struct Player {
    var name: String?
    var game: String?
    var rating: Int
    
    init(name: String?, game: String?, rating: Int) {
        self.name = name
        self.game = game
        self.rating = rating
    }
}