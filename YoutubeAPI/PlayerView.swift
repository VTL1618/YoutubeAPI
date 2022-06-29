//
//  PlayerView.swift
//  YoutubeAPI
//
//  Created by Vitaly Zubenko on 28.06.2022.
//

import UIKit

class PlayerView: UIViewController {
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let transfer = sender.translation(in: view)
        
        // не разрешаем юзер тянуть вверх
        guard transfer.y >= 0 else { return }
        
        // устанавливаем x на 0, так как мы не хотим чтобы юзер мог двигать рамку в стороны! Только ровно вверх или вниз!
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + transfer.y)
        
        if sender.state == .ended {
            let dragVelosity = sender.velocity(in: view)
            if dragVelosity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // возвращаем обратно к изначальной позиции view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
}
