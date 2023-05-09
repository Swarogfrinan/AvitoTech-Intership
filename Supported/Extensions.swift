import Foundation
import  UIKit

//MARK: - UIColor
extension UIColor {
    static let cellBackground = #colorLiteral(red: 0.9724746346, green: 0.9725909829, blue: 0.9724350572, alpha: 1)
    static let grayLight = #colorLiteral(red: 0.9294129014, green: 0.9238880277, blue: 0.93366009, alpha: 1)
    static let mainBlue = #colorLiteral(red: 0, green: 0.6784313725, blue: 1, alpha: 1)
    static let disableBlue = #colorLiteral(red: 0.8938408494, green: 0.9622785449, blue: 1, alpha: 1)
}


//MARK: - UIButton
extension UIButton {
    static func animateHandleButton(sender: UIButton, complition: @escaping () -> ()) {
        UIView.animate(withDuration: 0.1,
                        animations: {
                        sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                        complition()
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = CGAffineTransform.identity
            }
        })
    }
    
}

