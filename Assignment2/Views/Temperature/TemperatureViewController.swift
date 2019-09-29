//
//  TemperatureViewController.swift
//  Assignment2
//
//  Created by M Rahman on 24/9/19.
//  Copyright © 2019 M Rahman. All rights reserved.
//

import UIKit
import Charts

class TemperatureViewController: UIViewController {

    @IBOutlet weak var chartView: LineChartView!
    
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var avg24hoursLabel: UILabel!
    @IBOutlet weak var avg3daysLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        currentLabel.text = "17°"
        avg24hoursLabel.text = "17°"
        avg3daysLabel.text = "17°"
        
        updateGraph()
    }
    
    func updateGraph(){
        chartView.legend.enabled = false
        var lineChartData = [ChartDataEntry]()
        let number = 10
        for i in 0..<number{
            let value = ChartDataEntry(x: Double(i), y: Data.sensorReadings[i].temperature)
            lineChartData.append(value)
        }
        let line = LineChartDataSet(entries: lineChartData, label: "")
        line.colors = [Theme.text!]
        let data = LineChartData()
        data.addDataSet(line)
        chartView.data = data
        chartView.chartDescription?.text = "Temperature Chart"
        //Changing color
        chartView.data?.setValueTextColor(Theme.text!)
        chartView.xAxis.labelTextColor = Theme.text!
        chartView.leftAxis.labelTextColor = Theme.text!
        chartView.rightAxis.labelTextColor = Theme.text!
        chartView.chartDescription?.textColor = Theme.text!
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Data.currentReading.id != ""{
            currentLabel.text = "\(Int(Data.currentReading.temperature)) °C"
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
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
