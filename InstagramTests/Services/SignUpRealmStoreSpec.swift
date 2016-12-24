//
//  SignUpRealmStoreSpec.swift
//  Instagram
//
//  Created by CruzDiary on 24/12/2016.
//  Copyright © 2016 cruz. All rights reserved.
//

import XCTest

import RealmSwift
import Quick
import Nimble

@testable import Instagram

class SignUpRealmStoreSpec: QuickSpec {
    
    override func spec() {
        var sut: SignUpRealmStore!
        var realm: Realm!
        
        beforeEach {
            Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
            realm = try! Realm()
            sut = SignUpRealmStore()
        }
        
        describe("SignUpRealmStore") {
            var expectedNumberOfUsers: Int = 0
            
            beforeEach {
                expectedNumberOfUsers = realm.objects(RealmUser.self).count + 1
            }
            
            context("when signUp") {
                beforeEach {
                    sut.signUp(SignUp.Request(userName: "cruz", email: "cruzdiary@gmail.com", password: "password"))
                }
                
                it("numberOfUsers should be increased") {
                    let numberOfUsers = realm.objects(RealmUser.self).count
                    expect(numberOfUsers).to(equal(expectedNumberOfUsers))
                }
            }
        }
    }
}
