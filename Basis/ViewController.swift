//
//  ViewController.swift
//  Basis
//
//  Created by Joyson P S on 08/06/22.
//

import UIKit

class SplashViewController: UIViewController {
    private var logoImage: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        img.image = UIImage(named: "logoimage")
        return img
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logoImage)
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.logoImage.center = self.view.center
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.animate()
        }
        
    }
 
    
    private func animate(){
        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.width * 3
            let diffX = size - self.view.frame.size.width
            let diffY =  self.view.frame.size.height - size

            self.logoImage.frame = CGRect(x: -(diffX/2), y: diffY/2, width: size, height: size)
        }, completion: nil)
        UIView.animate(withDuration: 1.5) {
            self.logoImage.alpha = 0

        } completion: { done in
            if (done){
                DispatchQueue.main.asyncAfter(deadline: .now()+0.4) {
                    let vc: EmailViewController = self.getViewController(in: StoryBoard.login.rawValue)
                    self.makeRootVc(vc: vc)
                }
            }
            
        }

    }

}

