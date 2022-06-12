//
//  OtpVerifyViewController.swift
//  Basis
//
//  Created by Joyson P S on 09/06/22.
//

import UIKit
import OTPFieldView

class OtpVerifyViewController: UIViewController {
    @IBOutlet weak var submitButton: BButton!
    @IBOutlet weak var invalidOtpError: UILabel!
    @IBOutlet weak var otpView: OTPFieldView!
    private var otp: String? = nil
    var vm: OTPVerificationViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
        self.setUP()
    }
    private func setUP(){
          self.otpView.fieldsCount = 6
          self.otpView.fieldBorderWidth = 2
          self.otpView.defaultBorderColor = UIColor(named: "green")!
          self.otpView.filledBorderColor = UIColor(named: "lightgreen")!
          self.otpView.cursorColor = UIColor(named: "green")!
          self.otpView.displayType = .underlinedBottom
          self.otpView.fieldSize = 50
          self.otpView.separatorSpace = 12
          self.otpView.shouldAllowIntermediateEditing = false
          self.otpView.delegate = self
          self.otpView.initializeUI()
    }
    private func bind(){
        self.vm.user.bind { t in
            DispatchQueue.main.async {
                self.presentAlertWithTitle(title: "Logged In", message: "You have sucessffully logged in", options: [.ok]) { _ in
                }
            }
        }
        self.vm.error.bind { error in
            DispatchQueue.main.async {
                self.presentAlertWithTitle(title: "Error", message:error ?? "Sorry! Not able to login" , options: [.ok]) { _ in
                }
            }
        }
        
    }
    
    @IBAction func submitAction(_ sender: Any) {
        self.vm.verifyUser()
    }
}

extension OtpVerifyViewController: OTPFieldViewDelegate {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        self.submitButton.isEnabled  = hasEntered
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        self.vm.verify.value?.verificationCode = otpString
        print("OTPString: \(otpString)")
    }
}
