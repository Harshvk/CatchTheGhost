//
//  ViewController.swift
//  CatchTheGhost
//
//  Created by Harsh Vardhan Kushwaha on 23/08/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rowsTextField: UITextField!
    @IBOutlet weak var columnsTextField: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func generateButtonTapped(_ sender: UIButton) {
        let rows = Int(rowsTextField.text ?? "") ?? 0
        let column = Int(columnsTextField.text ?? "") ?? 0
        let data = GameData(row: rows, column: column)
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController {
            vc.gameData = data
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

