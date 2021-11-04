//
//  CatFormViewController.swift
//  Miawouf
//
//  Created by Chr V on 03/11/2021.
//

import UIKit

class CatFormViewController: UIViewController , UITextFieldDelegate {
    
    var cat: Pet!
    
    @IBOutlet weak var nameTexteField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var racePickerView: UIPickerView!
    
    @IBOutlet weak var majoritySwitch: UISwitch!
    
    @IBOutlet weak var genderSegmentControl: UISegmentedControl!
}

    
extension CatFormViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return catRaces.count
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return catRaces[row]
    }

}
extension CatFormViewController {
    @IBAction func validate() {
        createPetObject()
        chekPetStatus()
    }
    
    private func createPetObject() {
        let name = nameTexteField.text
        let phone = phoneTextField.text
        let hasMajority = majoritySwitch.isOn
        let genderIndex = genderSegmentControl.selectedSegmentIndex
        let gender: Pet.Gender = (genderSegmentControl.selectedSegmentIndex == 0) ? .male : .female
        let raceIndex = racePickerView.selectedRow(inComponent: 0)
        let race = catRaces[raceIndex]
        cat = Pet(name: name, hasMajority: hasMajority, phone: phone, race: race, gender: gender)
    }
    private func chekPetStatus() {
        switch cat.status {
        case .accepted:
            performSegue(withIdentifier: "CatSegueToSuccess", sender: self)
        case .rejeted(let error):
            presentAlert(with: error)
        }
        
    }
    private func presentAlert(with error: String) {
        let alertVC = UIAlertController(title: "Erreur", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
}

    extension CatFormViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
        if segue.identifier == "CatSegueToSuccess" {
            let successVC = segue.destination as! CatSuccessViewController
            successVC.cat = cat
        }
    }
}
extension CatFormViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        nameTexteField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
    }

}
