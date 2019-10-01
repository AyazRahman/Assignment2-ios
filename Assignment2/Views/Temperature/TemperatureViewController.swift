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
    
    var observer: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        currentLabel.text = "NA"
        avg24hoursLabel.text = "17°"
        avg3daysLabel.text = "17°"
        
        if Data.currentReading.id != "" {
            setFields()
            updateGraph()
        }
    }
    
    func setFields(){
        currentLabel.text = "\(Data.currentReading.temperature) °C"
        let average = Data.get3days(sensor: "Temperature")
        avg24hoursLabel.text = (average[0] == "NA" ? "NA" : "\(average[0]) °C")
        avg3daysLabel.text = (average[1] == "NA" ? "NA" : "\(average[1]) °C")
    }
    
    func updateGraph(){
        chartView.legend.enabled = false
        var lineChartData = [ChartDataEntry]()
        
        let number = 10
        let count = Data.sensorReadings.count
        for i in (count - number)..<count{
            let value = ChartDataEntry(x: Double(i), y: Data.sensorReadings[count - i].temperature)
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
        observer = NotificationCenter.default.addObserver(forName: .currentReadingUpdate, object: nil, queue: OperationQueue.main) { (notification) in
            self.setFields()
            self.updateGraph()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
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
