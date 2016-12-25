//
//  SignUpSceneTests.swift
//  Instagram
//
//  Created by CruzDiary on 25/12/2016.
//  Copyright © 2016 cruz. All rights reserved.
//

import XCTest

class SignUpSceneTests: UITestCase {
    func testUIElements() {
        XCTAssertEqual(app.textFields.count, 3, "email, userName, password should be exists")
        XCTAssertTrue(app.buttons["SignUpButton"].exists)
    }
    
    func testSignUp() {
        let emailTextField = app.textFields["EmailTextField"]
        emailTextField.tap()
        emailTextField.typeText("cruzdiary@gmail.com")
        
        let userNameField = app.textFields["UserNameTextField"]
        userNameField.tap()
        userNameField.typeText("cruz")
        
        let passwordField = app.textFields["PasswordTextField"]
        passwordField.tap()
        passwordField.typeText("password")
        
        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()
    }
}
