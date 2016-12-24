//
//  SignUpRealmStore.swift
//  Instagram
//
//  Created by CruzDiary on 24/12/2016.
//  Copyright © 2016 cruz. All rights reserved.
//

import UIKit

import RealmSwift

protocol SignUpAPI {
    func signUp(_ request: SignUp.Request)
}

class SignUpRealmStore: SignUpAPI {
    
    func signUp(_ request: SignUp.Request) {
        let realm = try! Realm()
        
        let newUser = RealmUser()
        newUser.userName = request.userName
        newUser.password = request.password
        newUser.email = request.email
        
        try! realm.write {
            realm.add(newUser)
        }
    }
}
