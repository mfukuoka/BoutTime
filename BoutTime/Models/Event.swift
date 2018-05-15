//
//  Event.swift
//  BoutTime
//
//  Created by thechemist on 5/9/18.
//  Copyright © 2018 mfukuoka. All rights reserved.
//

import Foundation


class Event {
    var year: Int
    var description: String
    var url: String
    init(year: Int, description: String, url: String) {
        self.year = year
        self.description = description
        self.url = url
    }
}
