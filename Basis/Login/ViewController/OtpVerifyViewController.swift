//
//  OtpVerifyViewController.swift
//  Basis
//
//  Created by Joyson P S on 09/06/22.
//

import UIKit

class OtpVerifyViewController: UIViewController {
    @IBOutlet weak var submitButton: BButton!
    @IBOutlet weak var invalidOtpError: UILabel!
    @IBOutlet weak var otpTextField: BTextField!
    let vm = EmailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
    }
    private func setUP(){
        self.otpTextField.delegate = self

    }
    private func bind(){
        self.vm.token.bind { t in
            DispatchQueue.main.async {
                let vc: OtpVerifyViewController = self.getViewController(in: StoryBoard.login.rawValue)
                self.push(viewController: vc)
            }
        }
    }
    
    @IBAction func submitAction(_ sender: Any) {
        self.vm.sendOtp(email: self.otpTextField.text ?? "")
    }
    private func validate(){
        if (self.otpTextField.text?.isValidEmail ?? false){
            self.submitButton.isEnabled = true
        }else{
            self.submitButton.isEnabled = false
        }
    }

}

extension OtpVerifyViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.validate()
    }
 
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.validate()
    }
}
