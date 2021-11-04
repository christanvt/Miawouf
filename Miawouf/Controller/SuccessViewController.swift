//
//  SuccessViewController.swift
//  Miawouf
//
//  Created by Chr V on 03/11/2021.
//

import UIKit

class SuccessViewController: UIViewController {
    var dog: Pet!

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextLabel()
    }
    
    private func setTextLabel() {
        if let name = dog.name {
            label.text = """
            Wouf de bienvenue à
            \(name) !
            
            
            
            Vous avez été ajouté à notre base de donnée ! Nous vous enverrons un SMS dès que nous avons une âme soeur à vous proposer !
            """
        }
    }
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
