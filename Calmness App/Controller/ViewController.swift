//
//  ViewController.swift
//  Calmness App
//
//  Created by Ricky Erdiansyah on 13/05/19.
//  Copyright © 2019 Ricky Erdiansyah. All rights reserved.
//

import UIKit
import CoreGraphics
import CoreMotion
import QuartzCore
import AVFoundation
import SpriteKit

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var circles = [UIView()]
    var shapeLayer = CAShapeLayer()
    var circlePath = UIBezierPath()
    var lineCurve = UIBezierPath()
    var curvePath = UIBezierPath()
    var curveLayer = CAShapeLayer()
    var plugged: UIDevice.BatteryState{
        return UIDevice.current.batteryState
    }
    
    var audioPlayer: AVAudioPlayer!
    let soundArray = ["rain", "forest", "morning", "night"]
    let particleArray = ["MyRain.sks", "MyFireflies.sks"]
    
    let spriteNode = SKView()
    var spriteScene = SKScene()
    
    var hour: Int = 0
    var minute: Int = 0
    var circleCurve = UIView()
    
    var isHide = true
    var isClicked = false
    var selectedSound: String = ""
    var selectedParticle: String = ""
    
    @IBOutlet weak var sunImg: UIImageView!
    @IBOutlet weak var moonImg: UIImageView!
    
    @IBAction func effectBtn(_ sender: UIButton) {
        //audioPlayer.numberOfLoops = -1
        selectedSound = soundArray[sender.tag]
        selectedParticle = particleArray[sender.tag]
        
        addParticle()
        playSound()
    }
    
    @IBAction func doubleTap(_ sender: UITapGestureRecognizer) {
        
    }
    
    /*@IBAction func rainBtn(_ sender: UIButton) {
        selectedSound = soundArray[sender.tag-1]
        playSound()
        if isClicked == false{
            removeFromParent()
            isClicked = true
        }
        addParticle(effectName: "MyRain.sks")
    }*/
    
    
    @IBAction func unwindToViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer) {
         //performSegue(withIdentifier: "nextPage", sender: self)
    }
   
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var enterBtn: UIButton!
    @IBOutlet weak var halfCircle: UIImageView!
    
    @IBAction func enterAction(_ sender: UIButton) {
        //performSegue(withIdentifier: "nextPage", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLapse()
        backgroundImg.gradientLayer()
        //audioPlayer.numberOfLoops = -1
        //playSound()
        //addParticle(effectName: "MyRain.sks")
        //backgroundImg.gradientLayer()
        //backgroundImg.gradientLayer(red: 0, green: 130, blue: 255, alpha: 1.0)
        /*
        //circle2(pos: CGPoint(x: 90, y: 120))
        //circle2(pos: CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2))
        //addCurve(pos: CGPoint(x: 500, y: 500))
        //clock()
        
        //parallax()
        //createCircle(pos: CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2))
        //createCurve(pos: CGPoint(x: 500, y: 500))
        //enterBtn.bounce()
        //sunImg.sunMoonRotation()
         */
        sunImg.layer.shadowColor = UIColor.black.cgColor
        sunImg.layer.shadowOffset = CGSize(width: 4, height: 4)
        sunImg.layer.shadowRadius = 5.0
        sunImg.layer.shadowOpacity = 1.0
        sunImg.layer.masksToBounds = false
        sunImg.rotationImg(img: halfCircle)
        moonImg.rotationImg(img: halfCircle)
        // sun and moon position = start: x:334, y:790 | end: x:334, y:130
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*for touch in touches {
            let circleCenter = touch.location(in: view)
            
            createCircle(pos: circleCenter)
        }*/
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*for touch in touches {
         let circleCenter = touch.location(in: view)
         createCircle(pos: circleCenter)
         }*/
        
            //let location = touch.location(in: spriteNode)
        spriteNode.removeFromSuperview()
        if hour >= 7 && hour < 18{
            selectedSound = "morning"
            playSound()
        }
        
        if hour < 7 && hour > 18{
            selectedSound = "night"
            playSound()
        }
            //spriteScene.removeFromParent()
        
    }
    
    
    func addParticle(){
        //spriteNode.frame = view.bounds
        spriteNode.frame = backgroundImg.bounds
        spriteNode.backgroundColor = .clear
        view.addSubview(spriteNode)
        
        //spriteScene = SKScene(size: view.bounds.size)
        spriteScene = SKScene(size: backgroundImg.bounds.size)
        spriteScene.scaleMode = .aspectFit
        spriteScene.backgroundColor = .clear
        spriteScene.isUserInteractionEnabled = true
        //let particle = SKEmitterNode(fileNamed: "MyRain.sks")
        let particle = SKEmitterNode(fileNamed: selectedParticle)
        particle?.position = spriteNode.center
        
        spriteScene.addChild(particle!)
        spriteNode.presentScene(spriteScene)
        
    }
    
    func circle2(pos: CGPoint){
        let circle = UIView(frame: CGRect(x: view.frame.size.width/4, y: view.frame.size.height/4, width: 150, height: 150))
        circle.layer.backgroundColor = UIColor.clear.cgColor
        circle.layer.cornerRadius = 75
        circle.layer.borderColor = UIColor.red.cgColor
        //var view = UIView()
        //var number = NSNumber(value: 6)
        circle.layer.borderWidth = 1.0
        //circle.layer.shadowColor = UIColor.red.cgColor
        //circle.layer.shadowOffset = CGSize.zero
        //circle.layer.shadowOpacity = 0.5
        //circle.layer.shadowPath = circle.self
        //circle.layer.shadowRadius = 30
        //circle.layer.masksToBounds false
        //circle.layer.position = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
        circle.layer.position = pos
        circles.append(circle)
        view.addSubview(circle)
    }
    
    /*func clock(){
        Timer.scheduledTimer(withTimeInterval: 1.2, repeats: true, block: { timer in
            if self.hour < 24{
                //self.decreaseRed += 2
                //self.decreaseGreen += 2
                if self.hour == 7{
                    self.tempRed = self.tempRed - 5
                    self.tempGreen = self.tempGreen - 5
                    if self.tempRed == 230{self.tempRed+=0}
                    if self.tempGreen == 130{self.tempGreen+=0}
                }
                
                if self.hour == 12 {
                    self.tempRed = self.tempRed + 10
                    self.tempGreen = self.tempGreen + 10
                }
                if self.hour == 18{
                    self.tempRed = self.tempRed - 10
                    self.tempGreen = self.tempGreen - 10
                }
                UIView.animate(withDuration: 30.0, animations: {
                   
                    //self.backgroundImg.backgroundColor = UIColor(red: CGFloat(self.tempRed), green: CGFloat(self.tempGreen), blue: 0/255, alpha: 1)
                })
               
                
                print(self.decreaseRed)
                print(self.decreaseGreen)
                print(self.tempRed)
                print(self.tempGreen)
                
                if self.minute != 50{
                    self.minute+=10
                }else{
                    self.hour+=1
                    self.minute = 0
                }
                if self.hour == 24{
                    self.hour = 0
                    self.tempRed = 0
                    self.tempGreen = 0
                }
                
            }
            
            self.timeLbl.text = String(format: "%02d.%02d", self.hour, self.minute)
        })
        
    }*/
    
    func timeLapse(){
        hour = 7
        minute = 0
        //gradientLayer.colors = [UIColor.init(red: 0/255, green: 100/255, blue: 255/255, alpha: 0.5).cgColor, UIColor.white.cgColor]
        // 1380+50 = 1430
        // 12.00 = red:0 green:200 blue:255
        // 17.00 = red:0 green:100 blue: 255
        // 012345 012345 012345 012345 012345 012345    +60
        // 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 00
        //backgroundImg.gradientLayer(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>)
        //moonImg.isHidden = true
        moonImg.alpha = 0
        Timer.scheduledTimer(withTimeInterval: 1.2, repeats: true, block: { timer in
            if self.hour < 24{
                if self.minute != 50{
                    self.minute+=10
                }else{
                    self.hour+=1
                    self.minute = 0
                }
                if self.hour == 24{
                    self.hour = 0
                }
            }
            
            if self.hour == 18{
                UIView.animate(withDuration: 2, animations: {
                    //self.moonImg.isHidden = false
                    self.moonImg.alpha = 1
                    self.sunImg.alpha = 0
                    //self.sunImg.isHidden = true
                    self.backgroundImg.gradientLayer(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
                    
                })
                self.selectedSound = "night"
                self.playSound()
            }
            
            if self.hour == 7{
                self.backgroundImg.gradientLayer()
                
                UIView.animate(withDuration: 2, animations: {
                    self.moonImg.alpha = 0
                    self.sunImg.alpha = 1
                })
                self.selectedSound = "morning"
                self.playSound()
            }
           
            if self.hour == 12{
                self.backgroundImg.gradientLayer(red: 0, green: 130, blue: 255, alpha: 1.0)
                self.selectedSound = "afternoon"
                self.playSound()
            }
            
            self.timeLbl.text = String(format: "%02d.%02d", self.hour, self.minute)
        })
    
    }
    
    func parallax(){
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
        //backgroundImg.addMotionEffect(motionEffectGroup)
    }
    
    func addCurve(pos: CGPoint){
        circleCurve = UIView(frame: CGRect(x: view.frame.size.width/4, y: view.frame.size.height/4, width: 600, height: 600))
        circleCurve.layer.backgroundColor = UIColor.clear.cgColor
        circleCurve.layer.cornerRadius = 300
        circleCurve.layer.borderColor = UIColor.white.cgColor
        circleCurve.layer.borderWidth = 1.0
        //circle.layer.shadowColor = UIColor.red.cgColor
        //circle.layer.shadowOffset = CGSize.zero
        //circle.layer.shadowOpacity = 0.5
        //circle.layer.shadowPath = circle.self
        //circle.layer.shadowRadius = 30
        //circle.layer.position = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
        circleCurve.layer.position = pos
        //circleArray.append(circle)
        view.addSubview(circleCurve)
    }
    
    func createCircle(pos: CGPoint){
        //let circlePath = UIBezierPath(arcCenter: CGPoint(x: 100,y: 100), radius: CGFloat(20), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        circlePath = UIBezierPath(arcCenter: .zero, radius: UIScreen.main.bounds.size.width/5.0, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        //radius : UIScreen.main.bounds.size.width/2.0 = full left-right
        //radius -> untuk besar-kecil circle
        
        shapeLayer.path = circlePath.cgPath
    
        //change the fill color
        shapeLayer.fillColor = UIColor.clear.cgColor // no fill/transparent
        //change the stroke color
        shapeLayer.strokeColor = UIColor.cyan.cgColor
        //change the line width
        shapeLayer.lineWidth = 1.0
        //create shadow
        shapeLayer.shadowColor = UIColor.cyan.cgColor
        shapeLayer.shadowOffset = CGSize.zero
        //shapeLayer.shadowOffset = CGSize(width: 2, height: 2)
        shapeLayer.shadowOpacity = 0.5
        shapeLayer.shadowPath = circlePath.cgPath // mengikuti circle
        shapeLayer.shadowRadius = 30
        //change position
        //shapeLayer.position = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2) // center of view
        shapeLayer.position = pos
        self.pulse()
        
        view.layer.addSublayer(shapeLayer)
    }
    
    func playSound(){
        let sound = Bundle.main.url(forResource: selectedSound, withExtension: "mp3")
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: sound!)
        }catch{
            print(error)
        }
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
    }
    
    
    func createCurve(pos: CGPoint){
        //let circlePath = UIBezierPath(arcCenter: CGPoint(x: 100,y: 100), radius: CGFloat(20), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        curvePath = UIBezierPath(arcCenter: .zero, radius: CGFloat(300), startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        //radius : UIScreen.main.bounds.size.width/2.0 = full left-right
        //radius -> untuk besar-kecil circle
        
        curveLayer.path = curvePath.cgPath
        
        //change the fill color
        curveLayer.fillColor = UIColor.clear.cgColor // no fill/transparent
        //change the stroke color
        curveLayer.strokeColor = UIColor.white.cgColor
        //change the line width
        curveLayer.lineWidth = 1.0
        //change position
        //shapeLayer.position = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2) // center of view
        curveLayer.position = pos
        self.pulse()
        view.layer.addSublayer(curveLayer)
    }
    
    func pulse(){
        let pulseAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        pulseAnimation.duration = 1
        pulseAnimation.fromValue = 0
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        
        //view.layer.add(pulseAnimation, forKey: "animateOpacity")
        //enterBtn.layer.add(pulseAnimation, forKey: "animateOpacity")
        shapeLayer.add(pulseAnimation, forKey: "animateOpacity")
    }
    
    
}
extension UIView {
    /*func fadeInOut(duration: TimeInterval = 0.3){
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        }) {_ in
            UIView.animate(withDuration: duration, animations: {self.alpha = 1})
        }
    }*/
    
    func rotateImage(time times:Int) {
        if times == 0 { return }
        UIView.setAnimationCurve(.linear)
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3, animations: {
                self.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI * 2/3))
            })
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3, animations: {
                self.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI * 4/3))
            })
            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3, animations: {
                self.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI * 2))
            })
        }) { (_) in
            self.rotateImage(time: times - 1)
        }
    }
    
    
    func curveRotation(duration: CFTimeInterval = 5) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = Float.infinity
        self.layer.add(rotateAnimation, forKey: nil)
        //shapeLayer.add(rotateAnimation, forKey: nil)
    }
    
    func bounce(){
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.autoreverse, .repeat], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.transform = CGAffineTransform(translationX: 0, y: -30)
            })
        }, completion: nil)
        //        UIView.animate(withDuration: 1) {
        //            self.enterBtn.transform = CGAffineTransform(translationX: 0, y: -20)
        //        }
        //        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.45, initialSpringVelocity: 0.5, options: [.curveLinear], animations: {
        //            self.center = CGPoint(x: 0.0, y: 0.0)
        //        }, completion: nil)
    }
    
    func rotationImg(img: UIImageView){
        let path = UIBezierPath()
        path.move(to: self.center)
        // 12345 012345
        //7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 00 01 02 03 04 05 06
        //5 6
        //let toPoint = CGPoint(x: 500, y: 230)
        // total detik = 1380
        let toPoint = CGPoint(x: img.frame.maxX, y: img.frame.minY)
        let controlPoint = CGPoint(x: img.frame.minX-204, y: img.frame.midY)
        //let controlPoint = CGPoint(x: halfCircle.frame.width/3, y: halfCircle.frame.midY)
        path.addQuadCurve(to: toPoint, controlPoint: controlPoint)
        
        let animation = CAKeyframeAnimation()
        animation.path = path.cgPath
        animation.repeatCount = Float.infinity
        animation.duration = 121.8 //1430
        
        self.layer.add(animation, forKey: "position")
        
    }
    
    func fadeIn(duration: TimeInterval = 0.2){
        self.alpha = 0
        UIView.animate(withDuration: duration, animations: {self.alpha = 1})
    }
    
    func gradientLayer(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat){
        let gradientLayer = CAGradientLayer()
        //gradientLayer.colors = [UIColor.init(red: red, green: green, blue: blue, alpha: 1)]
        gradientLayer.colors = [UIColor.init(red: red, green: green, blue: blue, alpha: alpha).cgColor, UIColor.white.cgColor]
         //gradientLayer.colors = [UIColor.init(red: 0/255, green: 100/255, blue: 255/255, alpha: 0.5).cgColor, UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor]
        
        //gradientLayer.colors = [UIColor.orange.cgColor, UIColor.white.cgColor]
        //gradientLayer.colors = [color1, color2]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        //gradientLayer.frame = view.bounds
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
    }
    
    func gradientLayer(){
        let gradientLayer = CAGradientLayer()
        //gradientLayer.colors = [UIColor.init(red: 0/255, green: 100/255, blue: 255/255, alpha: 0.5).cgColor, UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor]
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        //gradientLayer.frame = view.bounds
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
    }
    
    func textShadow(radius: CGFloat, opacity: Float){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = radius//3.0
        self.layer.shadowOpacity = opacity//1.0
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.masksToBounds = false
    }
}
