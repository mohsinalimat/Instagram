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
    static let identifier = "SignUpViewController"
    
    struct ButtonViewModel {
        var backgroundColor: UIColor
    }
}

protocol SignUpViewModelType {
    var signUpButtonDidTap: PublishSubject<Void> { get }
    var presentButtonViewModel: Driver<SignUpScene.ButtonViewModel> { get }
    var signedUp: Driver<Bool> { get }
}

extension SignUpViewModel: SignUpViewControllerOutput {}

class SignUpViewModel: SignUpViewModelType {
    
    //MARK: Input
    let signUpButtonDidTap = PublishSubject<Void>()
    
    //MARK: Output
    var presentButtonViewModel: Driver<SignUpScene.ButtonViewModel>
    
    var signedUp: Driver<Bool>
    
    private let disposeBag = DisposeBag()
    
    init() {
        let emailValidation = Observable.from([true])
        let passwordValidation = Observable.from([true])
        let userNameValidation = Observable.from([true])
        
        let validObservable = Observable.combineLatest(emailValidation, passwordValidation, userNameValidation) {
            return $0.0 && $0.1 && $0.2
            }.filter { $0 }
        
        self.presentButtonViewModel = validObservable.map { SignUpScene.ButtonViewModel(backgroundColor: $0 ? .black : .gray) }
            .asDriver(onErrorDriveWith: .empty())
        
        self.signUpButtonDidTap.subscribe { (event) in
            
        }.addDisposableTo(disposeBag)
        
        self.signedUp = signUpButtonDidTap
            .withLatestFrom(validObservable)
            .asDriver(onErrorDriveWith: .empty())
    }
}
