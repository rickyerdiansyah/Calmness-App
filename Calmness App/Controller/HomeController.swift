//
//  HomeController.swift
//  Calmness App
//
//  Created by Ricky Erdiansyah on 13/05/19.
//  Copyright © 2019 Ricky Erdiansyah. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation // Audio Visual
import MediaPlayer

class HomeController: UIViewController {

    var circle = UIView()
    var circleArray = [UIView()]
    var isAddCircle = false
    var audioPlayer = AVAudioPlayer()
    var isPlaying = false
    var shapeLayer = CAShapeLayer()
    
    @IBOutlet weak var item1: UIImageView!
    @IBOutlet weak var item2: UIImageView!
    @IBOutlet weak var item3: UIImageView!
    @IBOutlet weak var item4: UIImageView!
    
    
    @IBAction func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "unwindToViewController", sender: self)
    }
    
    @IBAction func doubleTap(_ sender: UITapGestureRecognizer) {
        if sender.numberOfTapsRequired == 2{
            //isAddCircle = true
            addCircle(pos: sender.location(in: view))
        }
    }
    
    @IBAction func longPress(_ sender: UILongPressGestureRecognizer) {
        for index in 0...circleArray.count-1{
            circleArray[index].removeFromSuperview()
        }
        //view.subviews.forEach() { $0.removeFromSuperview() }
        /*for subview in view.subviews {
            subview.removeFromSuperview()
        }*/
    }
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var playOutlet: UIButton!
    @IBAction func playBtn(_ sender: UIButton) {
        if isPlaying == false{
            audioPlayer.play()
            audioPlayer.numberOfLoops = -1
            isPlaying = true
            playOutlet.setTitle("Pause", for: .normal)
        }else if isPlaying == true{
            audioPlayer.pause()
            isPlaying = false
            playOutlet.setTitle("Play", for: .normal)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSound()
        
        item1.center = CGPoint(x: 100, y: 100)
        
        item2.layer.cornerRadius = 75
        item3.layer.cornerRadius = 75
        
        item1.motionEffect(minX: 20, maxX: 20, minY: 80, maxY: 80)
        item2.motionEffect(minX: -120, maxX: 520, minY: -100, maxY: 620)
        item3.motionEffect(minX: -120, maxX: 420, minY: -300, maxY: 620)
        item4.motionEffect(minX: -120, maxX: 520, minY: -50, maxY: 100)
        
        //addPetal(pos: CGPoint(x: view.frame.size.width/2, y: view.frame.size.width/2))
        // -50, 200 = tengah
        //addCircle(pos: CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2))
        /*addCircle(pos: CGPoint(x: 100, y: 200))
        addCircle(pos: CGPoint(x: 315, y: 200))
        
        addCircle(pos: CGPoint(x: 100, y: 500))
        addCircle(pos: CGPoint(x: 315, y: 500))
        
        addCircle(pos: CGPoint(x: 100, y: 800))
        addCircle(pos: CGPoint(x: 315, y: 800))*/
        
        bgImage.motionEffect(minX: -120, maxX: 120, minY: -120, maxY: 120)
        
        
        // mediaPlayer()
        /*playOutlet.layer.borderColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        playOutlet.layer.borderWidth = 1
        playOutlet.layer.cornerRadius = 10
         */
        // imageItem.layer.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*if isAddCircle == true{
            for touch in touches{
                let location = touch.location(in: view)
                addCircle(pos: location)
            }
        }*/
        
    }
    
    
    
    func addPetal(pos: CGPoint){
        let width: CGFloat = 520
        let height: CGFloat = 520
        
        shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRect(x: view.frame.size.width/2, y: view.frame.size.height/2, width: width, height: height)
        //shapeLayer.frame = CGRect(x: -50, y: 200, width: width, height: height)
        
        let path = CGMutablePath()
        stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 6).forEach {
            angle in
            var transform  = CGAffineTransform(rotationAngle: angle).concatenating(CGAffineTransform(translationX: width / 2, y: height / 2))
            
            let petal = CGPath(ellipseIn: CGRect(x: -20, y: 0, width: 40, height: 100), transform: &transform)
            path.addPath(petal)
        }
        
        shapeLayer.path = path
        shapeLayer.position = pos
        shapeLayer.strokeColor = UIColor.white.cgColor
        //shapeLayer.fillColor = UIColor.yellow.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.fillRule = CAShapeLayerFillRule.evenOdd
        view.layer.addSublayer(shapeLayer)
        self.rotation()
    }
    
    func addCircle(pos: CGPoint){
        circle = UIView(frame: CGRect(x: view.frame.size.width/4, y: view.frame.size.height/4, width: 150, height: 150))
        circle.layer.backgroundColor = UIColor.clear.cgColor
        circle.layer.cornerRadius = 75
        circle.layer.borderColor = UIColor.white.cgColor
        circle.layer.borderWidth = 1.0
        //circle.layer.shadowColor = UIColor.red.cgColor
        //circle.layer.shadowOffset = CGSize.zero
        //circle.layer.shadowOpacity = 0.5
        //circle.layer.shadowPath = circle.self
        //circle.layer.shadowRadius = 30
        //circle.layer.position = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
        circle.layer.position = pos
        circleArray.append(circle)
        view.addSubview(circle)
    }
    
    func addRippleEffect(to referenceView: UIView) {
        /*! Creates a circular path around the view*/
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: referenceView.bounds.size.width, height: referenceView.bounds.size.height))
        /*! Position where the shape layer should be */
        let shapePosition = CGPoint(x: referenceView.bounds.size.width / 2.0, y: referenceView.bounds.size.height / 2.0)
        let rippleShape = CAShapeLayer()
        rippleShape.bounds = CGRect(x: 0, y: 0, width: referenceView.bounds.size.width, height: referenceView.bounds.size.height)
        rippleShape.path = path.cgPath
        rippleShape.fillColor = UIColor.clear.cgColor
        rippleShape.strokeColor = UIColor.yellow.cgColor
        rippleShape.lineWidth = 4
        rippleShape.position = shapePosition
        rippleShape.opacity = 0
        
        /*! Add the ripple layer as the sublayer of the reference view */
        referenceView.layer.addSublayer(rippleShape)
        /*! Create scale animation of the ripples */
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        scaleAnim.toValue = NSValue(caTransform3D: CATransform3DMakeScale(2, 2, 1))
        /*! Create animation for opacity of the ripples */
        let opacityAnim = CABasicAnimation(keyPath: "opacity")
        opacityAnim.fromValue = 1
        opacityAnim.toValue = nil
        /*! Group the opacity and scale animations */
        let animation = CAAnimationGroup()
        animation.animations = [scaleAnim, opacityAnim]
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.duration = CFTimeInterval(0.7)
        animation.repeatCount = 25
        animation.isRemovedOnCompletion = true
        rippleShape.add(animation, forKey: "rippleEffect")
    }
    
    func rotation(duration: CFTimeInterval = 5) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = Float.infinity
        //self.layer.add(rotateAnimation, forKey: nil)
        shapeLayer.add(rotateAnimation, forKey: nil)
    }
    
    func motion(){
        let min = CGFloat(-120)
        let max = CGFloat(120)
        
        let xMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.x", type: .tiltAlongHorizontalAxis)
        //let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = min
        xMotion.maximumRelativeValue = max
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.y", type: .tiltAlongVerticalAxis)
        //let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongHorizontalAxis)
        yMotion.minimumRelativeValue = min
        yMotion.maximumRelativeValue = max
        
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [xMotion,yMotion]
        bgImage.addMotionEffect(motionEffectGroup)
//        kotak1.addMotionEffect(motionEffectGroup)
//        kotak2.addMotionEffect(motionEffectGroup)
//        kotak3.addMotionEffect(motionEffectGroup)
    }
    
    func addSound(){
        let sound = Bundle.main.path(forResource: "rain", ofType: "m4a")
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        }catch{
            print(error)
        }
    }
  
    /*func mediaPlayer(){
        let myMediaPlayer = MPMusicPlayerController.applicationQueuePlayer
        
        myMediaPlayer.setQueue(with: MPMediaQuery.songs())
        
        myMediaPlayer.play()
    }*/

}
extension UIView {
    
    
    func gradientColor(){
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.cyan.cgColor , UIColor.white.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.frame = self.bounds
        self.layer.addSublayer(gradient)
    }
    
    func motionEffect(minX: CGFloat, maxX: CGFloat, minY: CGFloat, maxY: CGFloat){
        //let min = CGFloat(-120)
        //let max = CGFloat(120)
        
        let xMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.x", type: .tiltAlongHorizontalAxis)
        //let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = minX
        xMotion.maximumRelativeValue = maxX
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.y", type: .tiltAlongVerticalAxis)
        //let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongHorizontalAxis)
        yMotion.minimumRelativeValue = minY
        yMotion.maximumRelativeValue = maxX
        
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [xMotion,yMotion]
        self.addMotionEffect(motionEffectGroup)
        //bgImage.addMotionEffect(motionEffectGroup)
        //        kotak1.addMotionEffect(motionEffectGroup)
        //        kotak2.addMotionEffect(motionEffectGroup)
        //        kotak3.addMotionEffect(motionEffectGroup)
    }
    
}
