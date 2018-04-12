//
//  BaseViewController.swift
//  TwitSplit
//
//  Created by LinhLe on 4/9/18.
//  Copyright © 2018 LinhLe. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setLeftButton(image: UIImage) {
        let icon = image.withRenderingMode(.alwaysOriginal)
        let leftButton = UIBarButtonItem.init(image: icon, style: .plain, target: self, action: #selector(self.leftButtonHandle))
        leftButton.width = 50
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    func setRightButton(image: UIImage) {
        let icon = image.withRenderingMode(.alwaysOriginal)
        let rightButton = UIBarButtonItem.init(image: icon, style: .plain, target: self, action: #selector(self.rightButtonHandle))
        rightButton.width = 50
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func rightButtonHandle(){
        
    }
    
    @objc func leftButtonHandle(){
        
    }
    //Hides current viewcontroller
    @objc func dismissSelf() {
        if self.navigationController?.viewControllers.first == self {
            self.dismiss(animated: true)
        } else {
            // self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
