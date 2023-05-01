//
//  DetailsViewController.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 30/04/23.
//

import UIKit

class DetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

 

}

extension UIViewController {
    func showDetailsViewController() {
        let viewController = UIStoryboard(name: "Details", bundle: nil)
            .instantiateViewController(withIdentifier: "Details") as! DetailsViewController
       
        navigationController?.pushViewController(viewController, animated: true)
    }
}
