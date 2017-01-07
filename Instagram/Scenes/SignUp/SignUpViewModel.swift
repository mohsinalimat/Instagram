//
//  SignUpViewModel.swift
//  Instagram
//
//  Created by CruzDiary on 25/12/2016.
//  Copyright © 2016 cruz. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import RxOptional

struct SignUpScene {
    static let identifier = "SignUpViewController"
    
    struct ButtonViewModel {
        var backgroundColor: UIColor
    }
}

protocol SignUpViewModelType {
    var emailChanged: Variable<String?> { get }
    var userNameChanged: Variable<String?> { get }
    var passwordChanged: Variable<String?> { get }
    
    //INPUT
    var signUpButtonDidTap: PublishSubject<Void> { get }
    
    //OUTPUT
    var presentButtonViewModel: Driver<SignUpScene.ButtonViewModel> { get }
    var signedUp: Driver<Void> { get }
}

class SignUpViewModel: SignUpViewModelType {
    
    let emailChanged: Variable<String?>
    let userNameChanged: Variable<String?>
    let passwordChanged: Variable<String?>
    
    //MARK: Input
    let signUpButtonDidTap = PublishSubject<Void>()
    
    //MARK: Output
    var presentButtonViewModel: Driver<SignUpScene.ButtonViewModel>
    
    var signedUp: Driver<Void>
    
    private let disposeBag = DisposeBag()
    
    init() {
        self.emailChanged = Variable("")
        self.userNameChanged = Variable("")
        self.passwordChanged = Variable("")
        
        let emailObservable = emailChanged.asDriver().filterNil().asObservable()
        let userNameObservable = userNameChanged.asDriver().filterNil().asObservable()
        let passwordObservable = passwordChanged.asDriver().filterNil().asObservable()
        
        let emailValidation = emailObservable.map { $0.isEmail }.asObservable()
        let userNameValidation = userNameObservable.map { $0.isUserName }.asObservable()
        let passwordValidation = passwordObservable.map { $0.isPassword }.asObservable()
        
        let validObservable = Observable.combineLatest(emailValidation, passwordValidation, userNameValidation) {
            return $0.0 && $0.1 && $0.2
            }.filter { $0 }
        
        self.presentButtonViewModel = validObservable.map { SignUpScene.ButtonViewModel(backgroundColor: $0 ? .black : .gray) }
            .asDriver(onErrorDriveWith: .empty())
        
        let signUpSuccessObservable = Observable.combineLatest(emailObservable, userNameObservable, passwordObservable, validObservable, resultSelector: { (email, userName, password, valid) -> SignUp.Request in
            return SignUp.Request(email: email, userName: userName, password: password)
        })
        
        self.signedUp = signUpButtonDidTap
                        .withLatestFrom(signUpSuccessObservable)
                        .flatMapLatest({ (request) -> Observable<Void> in
                            return SignUpRealmStore.shared.signUp(request)
                        })
                        .asDriver(onErrorDriveWith: .empty())
    }
}

extension String {
    var isEmail: Bool {
        get {
            return self.characters.count > 0
        }
    }
    
    var isUserName: Bool {
        get {
            return self.characters.count > 0
        }
    }
    
    var isPassword: Bool {
        get {
            return self.characters.count > 0
        }
    }
}
