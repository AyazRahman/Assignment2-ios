//
//  PressureViewController.swift
//  Assignment2
//
//  Created by M Rahman on 24/9/19.
//  Copyright © 2019 M Rahman. All rights reserved.
//

import UIKit

class PressureViewController: UIViewController {

    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var avg24hoursLabel: UILabel!
    @IBOutlet weak var avg3daysLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        currentLabel.text = "100kPa"
        avg24hoursLabel.text = "100kPa"
        avg3daysLabel.text = "100kPa"
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Data.currentReading.id != ""{
            currentLabel.text = "\(Int(Data.currentReading.pressure/1000)) kPa"
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
