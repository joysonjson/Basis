//
//  Extension.swift
//  Basis
//
//  Created by Joyson P S on 09/06/22.
//

import Foundation
import UIKit

extension UIViewController {
    
//    func showIndicator(with status: String? = nil){
//        DispatchQueue.main.async{
//            let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
//            progressHUD.mode = .indeterminate
//            progressHUD.label.text = status
//        }
//
//    }
//    func hideIndicator(){
//        DispatchQueue.main.async{
//            MBProgressHUD.hide(for: self.view, animated: true)
//        }
//    }
 
    private func getStoryBoard(with name: String)->UIStoryboard {
        return UIStoryboard.init(name: name, bundle: Bundle.main)
    }
    func getViewController<T:UIViewController> (with title:String = "",in storyBoard: String) -> T {
        // getting a view controller
        let vc = String.init(describing: T.self)
        let myViewController = self.getStoryBoard(with: storyBoard).instantiateViewController(withIdentifier: vc)
        myViewController.title = title
        return myViewController as! T
    }
    
    func push(viewController:UIViewController) {
        guard let navigation = self.navigationController else {
            return
        }
        viewController.hidesBottomBarWhenPushed = true
        navigation.pushViewController(viewController, animated: true)
    }
    
    func presentAlertWithTitle(title: String, message: String, options: [AlertOptions], completion: @escaping (AlertOptions) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option.rawValue, style: .default, handler: { (action) in
                completion(options[index])
            }))
        }
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    func makeRootVc(vc: UIViewController){
        let navigationController = UINavigationController(rootViewController: vc)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}



public extension URL {
    /**
   adds query params to the url


     - parameter key: Key of the url param.
     - parameter value: value of the url param.
     - returns: URL.

     # Notes: #
     1. Parameters must be **String** type

     # Example #
    ```
     URL().queryItems(key, value: String(describing: val))
     ```
    */
    func queryItems(_ key: String, value: String?) -> URL {
        
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
        
        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        
        // Create query item
        let queryItem = URLQueryItem(name: key, value: value)
        
        // Append the new query item in the existing query items array
        queryItems.append(queryItem)
        
        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems
        
        // Returns the url from new url components
        return urlComponents.url!
    }
}


extension UITextField {
    /// Moves the caret to the correct position by removing the trailing whitespace
    func fixCaretPosition() {
        // Moving the caret to the correct position by removing the trailing whitespace
        // http://stackoverflow.com/questions/14220187/uitextfield-has-trailing-whitespace-after-securetextentry-toggle
        let beginning = beginningOfDocument
        selectedTextRange = textRange(from: beginning, to: beginning)
        let end = endOfDocument
        selectedTextRange = textRange(from: end, to: end)
    }
}
