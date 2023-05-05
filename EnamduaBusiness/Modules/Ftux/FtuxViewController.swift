//
//  FtuxViewController.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 28/04/23.
//

import UIKit

class FtuxViewController: UIViewController {
    
    @IBOutlet var getStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    // MARK: - FUNCTION
    func setup() {
        getStartedButton.layer.cornerRadius = 30
        getStartedButton.layer.masksToBounds = true
    }
    
    // MARK: - ACTION
    @available(iOS 13.0, *)
    @IBAction func getStartedButton(_ sender: Any) {
        showMainViewController()
    }
}
