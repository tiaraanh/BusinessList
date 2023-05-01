//
//  MainViewController.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 28/04/23.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tabBarTint()
    }
    
    func tabBarTint() {
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .gray
    }
 

}

// MARK: - UIViewController
@available(iOS 13.0, *)
extension UIViewController {
    func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Main")
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as! UIWindowScene
        let window = windowScene.windows.first!
        
        UIView.transition(with: window, duration: 0.25, options: [.transitionCrossDissolve, .allowAnimatedContent], animations: { () -> Void in
            
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            window.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
            
        }, completion: nil)
    }
}
