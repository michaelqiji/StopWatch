//
//  ViewController.swift
//  StopWatch
//
//  Created by QiJi on 2016-03-08.
//  Copyright © 2016 QiJi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var laps: [String] = []
    
    var timer = NSTimer()
    var minutes: Int = 0
    var seconds: Int = 0
    var franctions: Int = 0
    
    var stopwatchString: String = ""
    
    
    var startStopWatch: Bool = true
    var addLap: Bool = false
    
    
    @IBOutlet weak var stopwatchLabel: UILabel!

    @IBOutlet weak var startstopBtn: UIButton!
    
    @IBOutlet weak var lapresetBtn: UIButton!
    
    @IBOutlet weak var lapsTableView: UITableView!
    
    @IBAction func startStop(sender: AnyObject) {
        
        
        if startStopWatch == true {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: ("updateStopwatch"), userInfo: nil, repeats: true)
            
            startStopWatch = false
            
            startstopBtn.setTitle("Stop", forState: UIControlState.Normal)
            startstopBtn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
            
            addLap = true
            
        } else {
            timer.invalidate()
            startStopWatch = true
            
            startstopBtn.setTitle("Start", forState: UIControlState.Normal)
            startstopBtn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            lapresetBtn.setTitle("Reset", forState: UIControlState.Normal)
            
            addLap = false
            
            
        }
        
        
    }
   
    
    @IBAction func lapReset(sender: AnyObject) {
        
        if addLap == true {
            
            laps.insert(stopwatchString, atIndex: 0)
            lapsTableView.reloadData()
            
        } else {
            addLap = false
            lapresetBtn.setTitle("Lap", forState: .Normal)
            
            laps.removeAll(keepCapacity: false)
            lapsTableView.reloadData()
            
            
            franctions = 0
            seconds = 0
            minutes = 0
            
            stopwatchString = "00:00.00"
            stopwatchLabel.text = stopwatchString
        }
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        stopwatchLabel.text = "00:00.00"
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateStopwatch() {
        
        franctions += 1
        
        if franctions == 100 {
            seconds += 1
            franctions = 0
        }
        
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        
        let franctionString = franctions > 9 ? "\(franctions)" : "0\(franctions)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        stopwatchString = "\(minutesString):\(secondsString).\(franctionString)"
        stopwatchLabel.text = stopwatchString
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        
        cell.backgroundColor = self.view.backgroundColor
        
        cell.textLabel?.text = "Lap \(laps.count-indexPath.row)"
        cell.detailTextLabel?.text = laps[indexPath.row]
        
        return cell
        
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }


}

