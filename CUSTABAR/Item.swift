//
//  Item.swift
//  CUSTABAR
//
//  Created by Yudai Takahashi on 2021/06/04.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var Name : String?
    @objc dynamic var Size : String?
    @objc dynamic var Syrup : String?
}

