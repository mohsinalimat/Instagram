//
//  SignUpRealmStore.swift
//  Instagram
//
//  Created by CruzDiary on 24/12/2016.
//  Copyright © 2016 cruz. All rights reserved.
//

import UIKit

import RxSwift
import RealmSwift

protocol SignUpAPI {
    func signUp(_ request: SignUp.Request) -> Observable<Void>
}

class SignUpRealmStore: SignUpAPI {
    static let shared = SignUpRealmStore()
    
    func signUp(_ request: SignUp.Request) -> Observable<Void> {
        return Observable.create({ (observer) -> Disposable in
            
            let newUser = RealmUser()
            newUser.email = request.email
            newUser.userName = request.userName
            newUser.password = request.password
            
            do {
                let realm = try Realm()
                if realm.object(ofType: RealmUser.self, forPrimaryKey: newUser.email) == nil {
                    try realm.write {
                        realm.add(newUser)
                        observer.onNext(())
                    }
                } else {
                    throw NSError(domain: "Can't set primary key property 'email' to existing value '\(newUser.email)'", code: 406, userInfo: [:])
                }
            } catch let error as NSError {
                print(error)
                observer.onError(error)
            }
            
            
            return Disposables.create {
                
            }
        })
    }
}
