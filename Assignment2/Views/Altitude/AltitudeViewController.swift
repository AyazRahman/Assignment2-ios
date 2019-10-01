//
//  AltitudeViewController.swift
//  Assignment2
//
//  Created by M Rahman on 24/9/19.
//  Copyright © 2019 M Rahman. All rights reserved.
//

import UIKit
import Charts

class AltitudeViewController: UIViewController {

    @IBOutlet weak var chartView: LineChartView!
    
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var avg24hoursLabel: UILabel!
    @IBOutlet weak var avg3daysLabel: UILabel!
    
    var observer: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        currentLabel.text = "100m"
        avg24hoursLabel.text = "100m"
        avg3daysLabel.text = "100m"
        
        if Data.currentReading.id != ""{
            setFields()
            updateGraph()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observer = NotificationCenter.default.addObserver(forName: .currentReadingUpdate, object: nil, queue: OperationQueue.main) { (notification) in
            self.setFields()
            self.updateGraph()
        }
    }
    
    func setFields(){
        currentLabel.text = "\(Data.currentReading.altitude) m"
        avg24hoursLabel.text = "17°"
        avg3daysLabel.text = "17°"
    }
    
    func updateGraph(){
        chartView.legend.enabled = false
        var lineChartData = [ChartDataEntry]()
        
        let number = 10 + 1
        let count = Data.sensorReadings.count
        for i in 1..<number{
            let value = ChartDataEntry(x: Double(i), y: Data.sensorReadings[count - i].altitude)
            lineChartData.append(value)
        }
        let line = LineChartDataSet(entries: lineChartData, label: "")
        line.colors = [Theme.text!]
        let data = LineChartData()
        data.addDataSet(line)
        chartView.data = data
        chartView.chartDescription?.text = "Altitude Chart"
        //Changing color
        chartView.data?.setValueTextColor(Theme.text!)
        chartView.xAxis.labelTextColor = Theme.text!
        chartView.leftAxis.labelTextColor = Theme.text!
        chartView.rightAxis.labelTextColor = Theme.text!
        chartView.chartDescription?.textColor = Theme.text!
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
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
