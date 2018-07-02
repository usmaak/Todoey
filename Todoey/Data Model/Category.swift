//
//  Category.swift
//  Todoey
//
//  Created by Scott Kilbourn on 6/30/18.
//  Copyright © 2018 Scott Kilbourn. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var dateCreated: Date?
    let items = List<Item>()
}
