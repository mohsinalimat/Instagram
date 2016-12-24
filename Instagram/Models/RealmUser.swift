//
//  RealmUser.swift
//  Instagram
//
//  Created by CruzDiary on 24/12/2016.
//  Copyright © 2016 cruz. All rights reserved.
//

import UIKit

import RealmSwift

class RealmUser: Object {
    dynamic var userName = ""
    dynamic var email = ""
    dynamic var password = ""
}
