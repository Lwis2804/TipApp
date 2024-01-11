//
//  ExtensionTipCalculator.swift
//  TipApp
//
//  Created by LUIS GONZALEZ on 10/01/24.
//

import UIKit

extension TipCalculatorViewController : UITextFieldDelegate {
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(range.length)
        print(range.location)
        
        if range.length == 1 {
            print("El valpor de textfiel es \(textField.text)")
            print("El valpor de textfiel es \(string)")
            
        } else {
            var recibedAmount : String = (textField.text ?? "") + string
            saveValues(withStringAmount: recibedAmount)
            calculatePercent(withAmount: ingresaCuenta)
        }
        
        
        
        return true
    }
}
