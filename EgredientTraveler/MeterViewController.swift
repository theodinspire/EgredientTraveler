//
//  ViewController.swift
//  EgredientTraveler
//
//  Created by Eric Cormack on 5/24/17.
//  Copyright © 2017 the Odin Spire. All rights reserved.
//

import UIKit
import CoreMotion

class MeterViewController: UIViewController {
    @IBOutlet weak var xGravRaw: UILabel!
    @IBOutlet weak var yGravRaw: UILabel!
    @IBOutlet weak var zGravRaw: UILabel!
    
    @IBOutlet weak var xGrav: UILabel!
    @IBOutlet weak var yGrav: UILabel!
    @IBOutlet weak var zGrav: UILabel!
    
    @IBOutlet weak var xAccRaw: UILabel!
    @IBOutlet weak var yAccRaw: UILabel!
    @IBOutlet weak var zAccRaw: UILabel!
    
    @IBOutlet weak var xAcc: UILabel!
    @IBOutlet weak var yAcc: UILabel!
    @IBOutlet weak var zAcc: UILabel!
    
    @IBOutlet weak var xVel: UILabel!
    @IBOutlet weak var yVel: UILabel!
    @IBOutlet weak var zVel: UILabel!
    
    @IBOutlet weak var xPos: UILabel!
    @IBOutlet weak var yPos: UILabel!
    @IBOutlet weak var zPos: UILabel!
    
    let motionManager = CMMotionManager()
    let updateRate = 1.0 / 128.0
    
    let filter = 0.15
    var filterComp = 1.0
    
    var lastAcc = Vector.zeroVector
    var velocity = Vector.zeroVector
    var position = Vector.zeroVector
    
    var updateCount = 0
    var lastTime: TimeInterval = 0
    
    var accSample = [Vector]()
    var accBias = Vector.zeroVector
    var biasThreshold = 128
    var biasSet = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        filterComp = 1 - filter
        
        motionManager.deviceMotionUpdateInterval = updateRate
        motionManager.showsDeviceMovementDisplay = true
        //lastAcc = Vector(acceleration: motionManager.accelerometerData?.acceleration) ?? lastAcc
        
        lastTime = ProcessInfo.processInfo.systemUptime
        
        motionManager.startDeviceMotionUpdates(using: CMAttitudeReferenceFrame.xMagneticNorthZVertical, to: OperationQueue.init(), withHandler: self.handleMotion)
    }
    
    func handleMotion(from data: CMDeviceMotion?, error: Error?) {
        if let error = error { print(error.localizedDescription) }
        guard let motion = data else { return }
        
        if !biasSet {
            updateCount += 1
            
            let quaternion = motion.attitude.quaternion
            let acc = quaternion.rotate(acceleration: motion.userAcceleration)
            accSample.append(acc)
            
            if updateCount == biasThreshold {
                accBias = Vector.mean(vectors: accSample)
                biasSet = true
                
                DispatchQueue.main.async {
                    self.xAccRaw.text = String(self.accBias.x)
                    self.yAccRaw.text = String(self.accBias.y)
                    self.zAccRaw.text = String(self.accBias.z)
                }
            }
        } else {
            let quaternion = motion.attitude.quaternion
            
            //            let gravRaw = motion.gravity
            //            self.xGravRaw.text = String(format: "%1.3f", gravRaw.x)
            //            self.yGravRaw.text = String(format: "%1.3f", gravRaw.y)
            //            self.zGravRaw.text = String(format: "%1.3f", gravRaw.z)
            //
            //            let grav = quaternion.rotate(acceleration: gravRaw)
            //            self.xGrav.text = String(format: "%1.3f", grav.x)
            //            self.yGrav.text = String(format: "%1.3f", grav.y)
            //            self.zGrav.text = String(format: "%1.3f", grav.z)
            //
            let accRaw = motion.userAcceleration
            //            self.xAccRaw.text = String(format: "%1.3f", accRaw.x)
            //            self.yAccRaw.text = String(format: "%1.3f", accRaw.y)
            //            self.zAccRaw.text = String(format: "%1.3f", accRaw.z)
            
            let acc = quaternion.rotate(acceleration: accRaw) - accBias
            
            let currentTime = motion.timestamp
            let deltaT = currentTime - self.lastTime
            self.lastTime = currentTime
            
            //let meanAcc = Vector.mean(vectors: acc, self.lastAcc)
            self.lastAcc = self.filter * acc + self.filterComp * self.lastAcc
            
            self.velocity += deltaT /*self.updateRate*/ * Constants.accelerationDueToGravity * self.lastAcc
            self.position += deltaT /*self.updateRate*/ * self.velocity
            
            DispatchQueue.main.async {
                self.xAcc.text = String(format: "%1.3f", acc.x)
                self.yAcc.text = String(format: "%1.3f", acc.y)
                self.zAcc.text = String(format: "%1.3f", acc.z)
                
                self.xVel.text = String(format: "%1.3f", self.velocity.x)
                self.yVel.text = String(format: "%1.3f", self.velocity.y)
                self.zVel.text = String(format: "%1.3f", self.velocity.z)
                
                self.xPos.text = String(format: "%1.3f", self.position.x)
                self.yPos.text = String(format: "%1.3f", self.position.y)
                self.zPos.text = String(format: "%1.3f", self.position.z)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

