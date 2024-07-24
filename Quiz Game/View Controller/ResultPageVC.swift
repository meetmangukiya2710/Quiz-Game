//
//  ResultPageVC.swift
//  Quiz Game
//
//  Created by R95 on 16/07/24.
//

import UIKit

class ResultPageVC: UIViewController {
    
    
    @IBOutlet weak var totalCorrectLbl: UILabel!
    @IBOutlet weak var totalInCorrectLbl: UILabel!
    @IBOutlet weak var totalMarks: UILabel!
    
    var totalCorrect = 0
    var totalInCorrect = 0
    var totalMark = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        totalCorrectLbl.text = "\(totalCorrect)"
        totalInCorrectLbl.text = "\(totalInCorrect)"
        totalMarks.text = "\(totalMark)"
    }

}
