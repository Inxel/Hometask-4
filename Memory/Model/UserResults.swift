//
//  Score.swift
//  Memory
//
//  Created by Tyoma Zagoskin on 15/04/2019.
//  Copyright © 2019 Тёма Загоскин. All rights reserved.
//

import Foundation
import RealmSwift

class UserResults: Object {
    @objc dynamic var score: String?
    @objc dynamic var date = Date()
    @objc dynamic var gameTime: String?
}
