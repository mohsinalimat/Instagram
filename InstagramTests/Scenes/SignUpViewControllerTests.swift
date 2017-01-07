//
//  SignUpViewControllerTests.swift
//  Instagram
//
//  Created by CruzDiary on 07/01/2017.
//  Copyright © 2017 cruz. All rights reserved.
//

import XCTest

import RxSwift
import RxCocoa
import Quick
import Nimble

@testable import Instagram
class SignUpViewControllerTests: QuickSpec {
    
    override func spec() {
        var sut: SignUpViewController!
        var window: UIWindow!
        
        beforeEach {
            window = UIWindow()
            let bundle = Bundle.main
            let storyboard = UIStoryboard(name: "SignUp", bundle: bundle)
            sut = storyboard.instantiateViewController(withIdentifier: SignUpScene.identifier) as! SignUpViewController
            
            window.addSubview(sut.view)
            RunLoop.current.run(until: Date())
        }
        
        afterEach {
            window = nil
        }
        
        describe("SignUpViewController") {
            context("when signUpButtonDidTap") {
                var outputSpy: SignUpViewModelTypeSpy!
                
                beforeEach {
                    outputSpy = SignUpViewModelTypeSpy()
                    sut.viewModel = outputSpy
                    sut.signUpButton.sendActions(for: .touchUpInside)
                }
                
                it("signUpButtonDidTap should be called") {
                    expect(outputSpy.isSignedUpDidTap).to(equal(true))
                }
            }
        }
    }
}

class SignUpViewModelTypeSpy: SignUpViewModelType {
    var emailChanged: Variable<String?>
    var userNameChanged: Variable<String?>
    var passwordChanged: Variable<String?>
    
    var signUpButtonDidTap: PublishSubject<Void> = PublishSubject<Void>()
    
    var presentButtonViewModel: Driver<SignUpScene.ButtonViewModel>
    var signedUp: Driver<Void>
    
    var isSignedUpDidTap: Bool = false
    
    init() {
        self.emailChanged = Variable("")
        self.userNameChanged = Variable("")
        self.passwordChanged = Variable("")
        
        self.presentButtonViewModel = Observable
            .from([SignUpScene.ButtonViewModel(backgroundColor: .black)])
            .asDriver(onErrorDriveWith: .empty())
        
        self.signedUp = Observable
            .from([()])
            .asDriver(onErrorDriveWith: .empty())
        
        signUpButtonDidTap.subscribe { (event) in
            self.isSignedUpDidTap = true
        }.addDisposableTo(DisposeBag())
    }
}
