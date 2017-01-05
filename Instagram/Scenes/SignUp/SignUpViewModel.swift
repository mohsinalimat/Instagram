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

struct SignUpScene {
    struct ButtonViewModel {
        var backgroundColor: UIColor
    }
}

protocol SignUpViewModelType {
    var signUpButtonDidTap: PublishSubject<Void> { get }
    
    var presentButtonViewModel: Driver<SignUpScene.ButtonViewModel> { get }
}

extension SignUpViewModel: SignUpViewControllerOutput {}

class SignUpViewModel: SignUpViewModelType {
    
    // Mark: Input
    let signUpButtonDidTap = PublishSubject<Void>()
    
    var presentButtonViewModel: Driver<SignUpScene.ButtonViewModel>
    
    private let disposeBag = DisposeBag()
    
    init() {
        
        let emailValidation = Observable.from([true])
        let passwordValidation = Observable.from([false])
        let userNameValidation = Observable.from([true])
        
        self.presentButtonViewModel = Observable.combineLatest(emailValidation, passwordValidation, userNameValidation) {
            return $0.0 && $0.1 && $0.2
            }.map { SignUpScene.ButtonViewModel(backgroundColor: $0 ? .black : .gray) }
            .asDriver(onErrorDriveWith: .empty())
        
        self.signUpButtonDidTap.subscribe { (event) in
            print(event.element)
        }.addDisposableTo(disposeBag)
    }
}
