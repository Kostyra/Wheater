

import UIKit

struct Palette {
    static var labelDinamecColor: UIColor = {
        return UIColor { resolt in
            if resolt.userInterfaceStyle == .light {
                return UIColor.black
            } else {
                return UIColor.cyan
            }
        }
    }()
    
    static var viewDinamecColor: UIColor = {
        return UIColor { resolt in
            if resolt.userInterfaceStyle == .light {
                return UIColor.white
            } else {
                return UIColor.gray
            }
        }
    }()
}
