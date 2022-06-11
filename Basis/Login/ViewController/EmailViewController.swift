//
//  EmailViewController.swift
//  Basis
//
//  Created by Joyson P S on 09/06/22.
//

import UIKit

class EmailViewController: UIViewController {
    @IBOutlet weak var submitButton: BButton!
    @IBOutlet weak var invalidEmailError: UILabel!
    @IBOutlet weak var emailTextField: BTextField!
    let vm = EmailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
        self.setUP()
    }
    private func setUP(){
        self.emailTextField.delegate = self
    }
    private func bind(){
        self.vm.token.bind { t in
            DispatchQueue.main.async {
                if (t?.isLogin ?? false){
                    let vc: OtpVerifyViewController = self.getViewController(in: StoryBoard.login.rawValue)
                    let vm = OTPVerificationViewModel()
                    vm.verify.value = VerifyUser(email: self.emailTextField.text ?? "", token: t?.token, verificationCode: "")
                        vc.vm = vm
                    self.push(viewController: vc)
                }else{
                    self.presentAlertWithTitle(title: "Alert", message: "Please sign up to login", options: [.ok]) { _ in
                    }
                }
              
            }
        }
    }
    
    @IBAction func submitAction(_ sender: Any) {
        self.vm.sendOtp(email: self.emailTextField.text ?? "")        
    }
    private func validate(){
        if (self.emailTextField.text?.isValidEmail ?? false){
            self.submitButton.isEnabled = true
        }else{
            self.submitButton.isEnabled = false
        }
    }

}


extension EmailViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.validate()
    }
 
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.validate()
    }
}
