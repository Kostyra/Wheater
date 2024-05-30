

import UIKit

struct Palette {
    

        
    static var viewDinamecColor1: UIColor = {
        return UIColor { _ in
            if UserDefaults.standard.bool(forKey: "isDarkThemeEnabled") {
                return UIColor.gray
            } else {
                return UIColor.white
            }
        }
    }()
    
    
    
    static var labelDinamecColor1: UIColor = {
        return UIColor { _ in
            if UserDefaults.standard.bool(forKey: "isDarkThemeEnabled")  {
                return UIColor.cyan
            } else {
                return UIColor.black
            }
        }
    }()
    
        static var viewDinamecColor: UIColor {
            return UserDefaults.standard.bool(forKey: "isDarkThemeEnabled") ? .gray : .white
        }
        
        static var labelDinamecColor: UIColor {
            return UserDefaults.standard.bool(forKey: "isDarkThemeEnabled") ? .cyan : .black
        }
    static var labelDinamecColorUI: UIColor {
        return UserDefaults.standard.bool(forKey: "isDarkThemeEnabled") ? .darkGray : .lightGray
    }
    static var labelDinamecTemp: Float {
        return UserDefaults.standard.bool(forKey: "isDarkThemeEnabled") ? 32 : 0
    }
    
    }

    

