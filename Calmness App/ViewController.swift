//
//  ViewController.swift
//  Calmness App
//
//  Created by Ricky Erdiansyah on 13/05/19.
//  Copyright © 2019 Ricky Erdiansyah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var backgroundImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.originalImageView.image = [UIImageEffects, imageByApplyingLightEffectToImage: [UIImage imageNamed:@"yourImage.png"]]
        animateText()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
    func animateText(){
        textLbl.fadeInOut(duration: 1)
    }
    
}
extension UIView {
    func fadeInOut(duration: TimeInterval = 0.3){
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        }) {_ in
            UIView.animate(withDuration: duration, animations: {self.alpha = 1})
        }
    }
}
