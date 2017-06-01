//
//  ViewController.swift
//  EgredientTraveler
//
//  Created by Eric Cormack on 5/24/17.
//  Copyright © 2017 the Odin Spire. All rights reserved.
//

import UIKit
import CoreMotion

class MeterViewController: UIViewController/*, UITableViewDelegate, UITableViewDataSource*/ {
    //  UIOutlets
    @IBOutlet weak var stepCounter: UILabel!
    
    @IBOutlet weak var cadence: UILabel!
    @IBOutlet weak var pace: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    //  Internals
    let pedometer = CMPedometer()
    
    var data = [TravelData]()
    
    //  Actions
    @IBAction func startCounting(_ sender: Any) {
        if CMPedometer.isStepCountingAvailable() {
            startButton.isEnabled = false
            stopButton.isEnabled = true
            
            //  Button cannot be pressed if motion tracking is unavailable
            pedometer.startUpdates(from: Date()) { datums, error in
                guard let data = datums, error == nil else {
                    print("Data collection error: \(String(describing: error))")
                    return
                }
                
                DispatchQueue.main.async {
                    self.stepCounter.text = String(data.numberOfSteps.intValue)
                    self.cadence.text = "\(data.currentCadence?.doubleValue ?? 0) steps/second"
                    self.pace.text  = "\(data.currentPace?.doubleValue ?? 0) seconds/meter"
                }
            }
        }
    }
    
    @IBAction func stopCounting(_ sender: Any) {
        pedometer.stopUpdates()
        startButton.isEnabled = true
        stopButton.isEnabled = false
    }
    
    //  TableView
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return tableView.dequeueReusableCell(withIdentifier: "PedometryCell")!
//    }

    //  View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopButton.isEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

