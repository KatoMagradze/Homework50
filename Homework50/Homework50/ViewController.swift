//
//  ViewController.swift
//  Homework50
//
//  Created by Kato on 6/29/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var blueView: UIView!
    
    @IBOutlet weak var durationSlider: UISlider!
    @IBOutlet weak var delaySlider: UISlider!
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var delayLabel: UILabel!
    
    
    var pickerData: [[String]] = [[String]]()
    
    var durationTracker = 0.5
    var delayTracker = 0.5
    
    var easeInTracker = false
    var easeOutTracker = false
    
    var isCircle = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        durationLabel.text = "Duration: \(durationSlider.value)"
        delayLabel.text = "Delay: \(delaySlider.value)"
        
        pickerData = [["shake", "opacity"], ["ease in", "ease out"]]
        
        blueView.layer.cornerRadius = 15
    }
    
    @IBAction func changeShapeTapped(_ sender: UIButton) {
        
        if isCircle == false {
            UIView.animate(
                withDuration: durationTracker,
                delay: delayTracker,
                options: [.curveEaseIn],
                animations:  {
                    
                self.blueView.layer.cornerRadius = 125/2
                    
            }) { (finished) in
                self.isCircle = true
            }
        }
            
        else {
            UIView.animate(withDuration: durationTracker, animations:  {
                self.blueView.layer.cornerRadius = 15
            }) { (finished) in
                self.isCircle = false
            }
        }
    }

    @IBAction func durationSliderChanged(_ sender: UISlider) {
        
        let durationRounded = String(format: "%.1f", durationSlider.value)
        self.durationTracker = Double(durationRounded)!
        durationLabel.text = "Duration: \(durationRounded)"
    }
    
    @IBAction func delaySliderChanged(_ sender: UISlider) {
        let delayRounded = String(format: "%.1f", delaySlider.value)
        self.delayTracker = Double(delayRounded)!
        delayLabel.text = "Delay: \(delayRounded)"
    }
    
    @IBAction func optionsTapped(_ sender: UIButton) {
        
        performSegue(withIdentifier: "options_segue", sender: self)
        
    }
    
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = Double.pi * 2
        rotation.duration = durationTracker
        rotation.isCumulative = true
        
        if easeInTracker {
            rotation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        }
        else if easeOutTracker {
         rotation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        }
        else {
            rotation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        }
        
        self.blueView.layer.add(rotation, forKey: "rotation")
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = durationTracker
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        self.blueView.layer.add(animation, forKey: "shake")
    }
    
    func opacity() {
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.duration = 1
        opacityAnimation.fromValue = 0
        opacityAnimation.toValue = 1
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    
        self.blueView.layer.add(opacityAnimation, forKey: nil)
    }
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch (row, component) {
        case (0,0):
            self.rotate()
            self.shake()
        case (1,0):
            self.rotate()
            self.opacity()
        case(0, 1):
            print("ease in")
            easeInTracker = true
            easeOutTracker = false
        case(1, 1):
            print("ease out")
            easeInTracker = false
            easeOutTracker = true
        default:
            print("nothing")
        }
    }
}



