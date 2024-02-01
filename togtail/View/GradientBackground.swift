//
//  GradientBackground.swift
//  togtail
//
//  Created by Tolga Yakar on 22.01.2024.
//

import UIKit

struct GradientBackground {
    
    static func initGradientBG(view: UIView) {
        //Creating CAGradientLayer instance for gradient background color
        let gradientBG = CAGradientLayer()
        
        //Set gradientBG frame to ViewControllers view boundaries.
        gradientBG.frame = view.bounds
        
        //Adding colors for gradient effect.
        gradientBG.colors = [UIColor.systemGreen.cgColor,
                             UIColor.systemBlue.cgColor,
                             UIColor.systemRed.cgColor]
        
        //Adds a sublayer to the view in order to display.
        //In this case, out gradientBG was added as a sublayer.
        view.layer.insertSublayer(gradientBG, at: 0)
    }
}
