//
//  Category.swift
//  Todoey
//
//  Created by Pavel Yurkov on 18.01.2018.
//  Copyright © 2018 Pavel Yurkov. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = "FFFFFF"
    let items = List<Item>()
}
