//
//  PlayerViewController.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 28.06.2022.
//

import UIKit

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var openCloseArrow: UIImageView!
    
    // Color properties
    private let primaryColor = UIColor(
        red: 230/255,
        green: 63/255,
        blue: 143/255,
        alpha: 1
    )
    
    private let secondaryColor = UIColor(
        red: 114/255,
        green: 17/255,
        blue: 233/255,
        alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
    }
    
    func addVerticalGradientLayer(topColor: UIColor, bottomColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        view.layer.insertSublayer(gradient, at: 0)
    }
    
}
