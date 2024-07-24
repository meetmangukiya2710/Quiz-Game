//
//  ViewController.swift
//  Quiz Game
//
//  Created by R95 on 15/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func startGameBtn(_ sender: Any) {
        let navigation = storyboard?.instantiateViewController(identifier: "QuizPageVC") as! QuizPageVC
        
        navigationController?.pushViewController(navigation, animated: true)
    }
    
}
