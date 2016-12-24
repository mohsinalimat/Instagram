//
//  SignUpRealmStore.swift
//  Instagram
//
//  Created by CruzDiary on 24/12/2016.
//  Copyright © 2016 cruz. All rights reserved.
//

import UIKit

import Realm

protocol SignUpAPI {
    func signUp(_ request: SignUp.Request)
}

class SignUpRealmStore: SignUpAPI {
    func signUp(_ request: SignUp.Request) {
        
    }
}
