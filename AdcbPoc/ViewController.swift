//
//  ViewController.swift
//  AdcbPoc
//
//  Created by Abhinav Mallick on 28/05/21.
//

import UIKit
import AdcbWeb

class ViewController: UIViewController {
    
    @IBAction func launchNuclei(_ sender: Any) {
        do {
            try AdcbWebLauncher.openAdcbWeb()
        } catch let error {
            print(error)
        }
    }
    

}
