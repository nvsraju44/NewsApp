import Foundation
import UIKit

protocol AlertView {
    func presentAlert(title: String?, message: String?, defaultButtonTitle: String?, completion: (() -> Void)?)
}

extension AlertView where Self: UIViewController {
    func presentAlert(title: String? = nil, message: String?, defaultButtonTitle: String? = "OK", completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: defaultButtonTitle, style: .default, handler: { (action) in
            completion?()
        }))
        present(alertController, animated: true, completion: nil)
    }
}
