//
//  SideMenuViewController.swift
//  Balet
//
//  Created by Guillermo Romo Jiménez on 06/12/18.
//  Copyright © 2018 memoromoj. All rights reserved.

import UIKit

class SideMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.45)
        self.showAnimate()
    }
    @IBAction func hideMenu(_ sender: Any) {
        removeAnimate()
    }
    @IBAction func profile(_ sender: Any) {
    }
    @IBAction func settings(_ sender: Any) {
    }
    
    
    func showAnimate(){
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.2, animations: {//.25
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    func removeAnimate(){
        UIView.animate(withDuration: 0.25, animations: {//.25
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3);
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished){self.view.removeFromSuperview()}
        });
    }
}
