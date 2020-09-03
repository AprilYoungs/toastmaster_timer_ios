//
//  ViewController.swift
//  ToastmasterTimer
//
//  Created by April Yang on 2020/9/3.
//  Copyright © 2020 April Yang. All rights reserved.
//

import UIKit

private let availableTimes = [
    30,
    60,
    120,
    180,
    240,
    300,
    360,
    420,
    480,
    540,
    600
]
class TimerViewController: UIViewController {
    
    /// picker view section
    @IBOutlet weak var pickerViewContainer: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var startButton: UIButton!
    
    /// timer section
    @IBOutlet weak var timerContainer: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    /// current timer session
    var currentIndex: Int?
    var startTimeStamp: Date?
    var timer: CADisplayLink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }
    
    func render() {
        self.title = "Timer"
        
        self.pickerViewContainer.isHidden = false
        self.timerContainer.isHidden = true
        
        self.nameTextField.returnKeyType = .done
        
        self.startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        self.stopButton.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
        self.nameTextField.addTarget(self.nameTextField, action: #selector(self.nameTextField.resignFirstResponder), for: .editingDidEndOnExit)
    }
    
    @objc func startTimer() {
        self.pickerViewContainer.isHidden = true
        self.timerContainer.isHidden = false
        
        let index = self.pickerView.selectedRow(inComponent: 0)
        let second = availableTimes[index]
        self.currentIndex = index
        self.startTimeStamp = Date()
        
        print("start with time-->\(second)")
        
        self.nameTextField.becomeFirstResponder()
        timer = CADisplayLink(target: self, selector: #selector(updateTimerProgress))
        timer?.add(to: RunLoop.current, forMode: .common)
    }
    
    @objc func stopTimer() {
        
        let alertController = UIAlertController(title: "Are you sure?", message: "Stop timer, it will save the record, you are free to edit the record in the list page", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "stop", style: .default, handler:implementStopTimer(action:)))
        alertController.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func implementStopTimer(action: UIAlertAction) {
        self.pickerViewContainer.isHidden = false
        self.timerContainer.isHidden = true
        
        timer?.invalidate()
        timer = nil
        
    }
    
    @objc func updateTimerProgress() {
        guard let timeStamp = startTimeStamp,
            let currentIndex = currentIndex
        else { return }
        
        let totalTime = TimeInterval(availableTimes[currentIndex])
        let timePass = Date().timeIntervalSince(timeStamp)
        var timeLeft = Int(totalTime - timePass)
        
        let isMinus = timeLeft < 0
        timeLeft = isMinus ? -timeLeft : timeLeft
        let min = timeLeft / 60
        let sec = timeLeft % 60
        self.timeLabel.text = String(format: "%@%02d:%02d", isMinus ? "-": "", min, sec)
    }
}

extension TimerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return availableTimes.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let min = availableTimes[row] / 60
        let sec = availableTimes[row] % 60
        return String(format: "%02d:%02d", min, sec)
    }
}
