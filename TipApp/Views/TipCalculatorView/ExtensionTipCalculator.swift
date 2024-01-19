//
//  ExtensionTipCalculator.swift
//  TipApp
//
//  Created by LUIS GONZALEZ on 10/01/24.
//

import UIKit

extension TipCalculatorViewController : UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length == 1 {
            let recibedAmount : String = String(textField.text?.dropLast() ?? "")
            saveValues(withStringAmount: recibedAmount)
            calculatePercent(withAmount: ingresaCuenta)
            lblMontoTotal.text = "$ \(ingresaCuenta + percentResult)"
            lblMontoPorPersonaResult.text = "$ \(ingresaCuenta + percentResult)"
            btnLimpiar.isHidden = true
        } else {
            let recibedAmount : String = (textField.text ?? "") + string
            saveValues(withStringAmount: recibedAmount)
            calculatePercent(withAmount: ingresaCuenta)
            lblMontoTotal.text = "$ \(ingresaCuenta + percentResult)"
            lblMontoPorPersonaResult.text = "$ \(ingresaCuenta + percentResult)"
            steperPersonas.isHidden = false
            btnLimpiar.isHidden = false
        }
        return true
    }
}

