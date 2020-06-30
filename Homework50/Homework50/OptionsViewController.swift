//
//  OptionsViewController.swift
//  Homework50
//
//  Created by Kato on 6/30/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

protocol InfoProtocol {
    
}

class OptionsViewController: UIViewController {

    @IBOutlet weak var grayView: UIView!
    
    @IBOutlet weak var velocitySlider: UISlider!
    @IBOutlet weak var dampingSlider: UISlider!
    @IBOutlet weak var rotationSlider: UISlider!
    
    @IBOutlet weak var velocityLabel: UILabel!
    @IBOutlet weak var dampingLabel: UILabel!
    @IBOutlet weak var rotationLabel: UILabel!
    
    var velocityTracker = 0.0
    var dampingTracker = 0.0
    var rotationTracker = 0.0
    
    var infoDelegate: InfoProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        grayView.layer.cornerRadius = 10
        
        velocityLabel.text = "Velocity: \(velocitySlider.value)"
        dampingLabel.text = "Scale: \(dampingSlider.value)"
        rotationLabel.text = "Rotation: \(rotationSlider.value)"
        
    }
    
    @IBAction func velocityChanged(_ sender: UISlider) {
        
        let velocityRounded = String(format: "%.1f", velocitySlider.value)
        self.velocityTracker = Double(velocityRounded)!
        velocityLabel.text = "Velocity: \(velocityRounded)"
        
    }
    
    @IBAction func scaleChanged(_ sender: UISlider) {
        let scaleRounded = String(format: "%.1f", dampingSlider.value)
        self.dampingTracker = Double(scaleRounded)!
        dampingLabel.text = "Scale: \(scaleRounded)"
    }
    
    @IBAction func rotationChanged(_ sender: UISlider) {
        let rotationRounded = String(format: "%.1f", rotationSlider.value)
        self.rotationTracker = Double(rotationRounded)!
        rotationLabel.text = "Rotation: \(rotationRounded)"
    }
    
    @IBAction func resetTapped(_ sender: UIButton) {
        velocitySlider.value = 0.5
        velocityChanged(velocitySlider)
        
        dampingSlider.value = 0.5
        scaleChanged(dampingSlider)
        
        rotationSlider.value = 0.5
        rotationChanged(rotationSlider)
    }
    @IBAction func applyTapped(_ sender: UIButton) {
        
    }
}
