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
            try! realm.write {
                realm.deleteAll()
            }
            sut = SignUpRealmStore()
        }
        
        describe("SignUpRealmStore") {
            var expectedNumberOfUsers: Int = 0
            
            beforeEach {
                expectedNumberOfUsers = realm.objects(RealmUser.self).count + 1
            }
            
            context("when signUp") {
                beforeEach {
                    sut.signUp(SignUp.Request(email: "cruzdiary@gmail.com", userName: "cruz", password: "password"))
                }
                
                it("numberOfUsers should be increased") {
                    expect(realm.objects(RealmUser.self).count).to(equal(expectedNumberOfUsers))
                }
                
                context("when signUp using same Email") {
                    beforeEach {
                        sut.signUp(SignUp.Request(email: "cruzdiary@gmail.com", userName: "cruz", password: "password"))
                    }
                    
                    it("numberOfUsers should be not changed") {
                        expect(realm.objects(RealmUser.self).count).to(equal(expectedNumberOfUsers))
                    }
                }
            }
        }
    }
}
