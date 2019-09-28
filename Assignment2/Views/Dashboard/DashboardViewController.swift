//
//  DashboardViewController.swift
//  Assignment2
//
//  Created by M Rahman on 24/9/19.
//  Copyright © 2019 M Rahman. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, DatabaseListener {

    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var altitudeView: UIView!
    @IBOutlet weak var pressureView: UIView!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    var allSensorReadings = [SensorReading]()
    weak var databaseController: DatabaseProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = Theme.primary!.withAlphaComponent(0.4)
        cityLabel.setStyle()
        conditionLabel.setStyle()
        temperatureLabel.setStyle()
        altitudeLabel.setStyle()
        pressureLabel.setStyle()
        
        setupAnimatedControls()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1.0, delay: 0.3, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [], animations: {
            self.weatherView.transform = .identity
            self.altitudeView.transform = .identity
            self.pressureView.transform = .identity
        }) { (success) in
            //for doing something after animation finished
            print("Animated")
            
        }
        
    }
    
    func setupAnimatedControls() {
        weatherView.transform = CGAffineTransform(translationX: 0, y: -weatherView.frame.height - 50)
        altitudeView.transform = CGAffineTransform(translationX: -altitudeView.frame.width, y: 0)
        pressureView.transform = CGAffineTransform(translationX: pressureView.frame.width, y: 0)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        databaseController?.addListener(listener: self)
    }
          
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.removeListener(listener: self)
    }
       
    func onSensorReadingListChange(change: DatabaseChange, sensorReadings: [SensorReading]) {
        
            self.allSensorReadings = sensorReadings
        if allSensorReadings.count > 0 {
            let currentReading = self.allSensorReadings[self.allSensorReadings.count - 1 ]
            self.temperatureLabel.text = "\(currentReading.temperature) °C"
            self.pressureLabel.text = "\(currentReading.pressure) kPa"
            self.altitudeLabel.text = "\(currentReading.altitude) m"
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
