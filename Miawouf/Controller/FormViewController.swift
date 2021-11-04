//
//  FormViewController.swift
//  Miawouf
//
//  Created by Chr V on 03/11/2021.
//

import UIKit

class FormViewController: UIViewController , UITextFieldDelegate {
    
    var dog: Pet!

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var racePickerView: UIPickerView!
    
    @IBOutlet weak var majoritySwitch: UISwitch!
    
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
}
extension FormViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dogRaces.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dogRaces[row]
    }
}
    extension FormViewController{
    @IBAction func validate() {
        createPetObject()
        chekPetStatus()
    }
    private func createPetObject(){
        let name = nameTextField.text
        let phone = phoneTextField.text
        let hasMajority = majoritySwitch.isOn
        let genderIndex = genderSegmentedControl.selectedSegmentIndex
        let gender: Pet.Gender = (genderSegmentedControl.selectedSegmentIndex == 0) ? .male : .female
        let raceIndex = racePickerView.selectedRow(inComponent: 0)
        let race = dogRaces[raceIndex]
        dog = Pet(name: name, hasMajority: hasMajority, phone: phone, race: race, gender: gender)
        
    }
    
    private func chekPetStatus() {
        switch dog.status {
        case .accepted:
            performSegue(withIdentifier: "segueToSuccess", sender: self)
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

    extension FormViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToSuccess" {
            let successVC = segue.destination as! SuccessViewController
            successVC.dog = dog
        }
    }
}
extension FormViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
    }
}
