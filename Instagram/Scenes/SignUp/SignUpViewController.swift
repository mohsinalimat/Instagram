//
//  SignUpViewController.swift
//  Instagram
//
//  Created by CruzDiary on 25/12/2016.
//  Copyright © 2016 cruz. All rights reserved.
//

import UIKit

import SkyFloatingLabelTextField
import RxCocoa
import RxSwift

protocol SignUpViewControllerOutput {
    var signUpButtonDidTap: PublishSubject<Void> { get }
    var presentButtonViewModel: Driver<SignUpScene.ButtonViewModel> { get }
    var signedIn: Driver<Bool> { get }
}

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var userNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    var viewModel: SignUpViewControllerOutput!
    
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewModel = SignUpViewModel()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.selectedTitleColor = .black
        userNameTextField.selectedTitleColor = .black
        passwordTextField.selectedTitleColor = .black
        
        viewModel.presentButtonViewModel
            .drive(onNext: { [weak self] viewModel in
            guard let `self` = self else { return }
            self.signUpButton.backgroundColor = viewModel.backgroundColor
        }).addDisposableTo(disposeBag)
        
        viewModel.signedIn
            .drive(onNext: { [weak self] signedIn in
                guard let `self` = self else { return }
                self.performSegue(withIdentifier: ListFeedsScene.segue, sender: nil)
                
        }).addDisposableTo(disposeBag)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
