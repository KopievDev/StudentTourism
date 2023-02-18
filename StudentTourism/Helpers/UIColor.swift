//
//  UIColor.swift
//  Festa
//
//  Created by Ivan Kopiev on 04.10.2022.
//

import UIKit

extension UIColor {
    static let fDarkGray = UIColor(named: "fDarkGray")!
    static let fGray = UIColor(named: "fGray")!
    static let fGrayscale = UIColor(named: "fGrayscale")!
    static let fTextGray = UIColor(named: "fTextGray")!
    static let fMiddleGray = UIColor(named: "fMiddleGray")!
    static let fRed = UIColor(named: "fRed")!
    static let fBackGray = UIColor(named: "fBackGray")!
    static let fBDgray = UIColor(named: "fBDgray")!
    static let fGreen = UIColor(named: "fGreen")!
    static let fBackground = UIColor(named: "fBackground")!
    static let fChooseGray = UIColor(named: "fChooseGray")!
    static let fBlue = UIColor(named: "fBlue")!
	static let fBluishBlack = UIColor(named: "fBluishBlack")!
	static let fOrange = UIColor(named: "fOrange")!
	static let fLightPurple = UIColor(named: "fLightPurple")!
	static let fGreyishBlue = UIColor(named: "fGreyishBlue")!
	static let fCloudLilac = UIColor(named: "fCloudLilac")!
	static let fFuchsia = UIColor(named: "fFuchsia")!
	static let fDustyBlue = UIColor(named: "fDustyBlue")!
	static let fBluishGrey = UIColor(named: "fBluishGrey")!
	static let fCloudBlue = UIColor(named: "fCloudBlue")!
    static let fBackSecondary = UIColor(named: "fBackSecondary")!
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat((hexNumber & 0x0000ff)) / 255
                    a = 1

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
	
    convenience init(int: Int) {
        var a = CGFloat((int >> 24) & 0xff) / 255
        a = a == 0 ? 1:a
        let r = CGFloat((int >> 16) & 0xff) / 255
        let g = CGFloat((int >> 08) & 0xff) / 255
        let b = CGFloat((int >> 00) & 0xff) / 255
        self.init(red: r, green: g, blue: b, alpha: a)
    }
	
	func getRgbaFromColour() -> (r: CGFloat, b: CGFloat, g: CGFloat, a: CGFloat) {
		var r: CGFloat = 0.0
		var g: CGFloat = 0.0
		var b: CGFloat = 0.0
		var a: CGFloat = 0.0
		
		self.getRed(&r, green: &g, blue: &b, alpha: &a)
		
		return (r: r, b: b, g: g, a: a)
	}
	
	func getHexStringFromColour() -> String {
		let rgba = self.getRgbaFromColour()
		
		let rr = (Int)(rgba.r * 255) << 16
		let gg = (Int)(rgba.g * 255) << 8
		let bb = (Int)(rgba.b * 255) << 0
		
		let rgb = rr | gg | bb
		
		return String(format: "%06X", rgb)
	}
	
	func getHueFromColour() -> CGFloat {
		var hue: CGFloat = 0
		var s: CGFloat = 0
		var b: CGFloat = 0
		var a: CGFloat = 0
		
		self.getHue(&hue, saturation: &s, brightness: &b, alpha: &a)
		
		return hue
	}
	
	func getColourComponentsFromColour() -> (h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat) {
		var hue: CGFloat = 0
		var saturation: CGFloat = 0
		var brightness: CGFloat = 0
		var alpha: CGFloat = 0
		
		self.getHue(
			&hue,
			saturation: &saturation,
			brightness: &brightness,
			alpha: &alpha
		)
		return (h: hue, s: saturation, b: brightness, a: alpha)
	}
    
    var hex: Int {
        var red:CGFloat = 0
        var blue:CGFloat = 0
        var green:CGFloat = 0
        var alpha:CGFloat = 0
        
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let rgb = (Int32(255.0*(alpha)) & 0xff) << 24 | ((Int32)(red*(255.0))  & 0xff) << 16 | ((Int32)(green*(255.0)) & 0xff) << 8 | ((Int32)(blue*(255.0)) & 0xff) << 0
        return Int(rgb)
    }
}
