import Foundation
import UIKit

final class AppTheme {
    
     enum FontSize : CGFloat {
        case M = 18.0
        case S = 14.0
    }
    
    //MARK: Font
    static func sanFranciscoFont(with size: FontSize = .M) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue)
    }
}
