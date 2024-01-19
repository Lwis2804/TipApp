//
//  OnePersonTipExtension.swift
//  TipApp
//
//  Created by LUIS GONZALEZ on 18/01/24.
//

import UIKit


extension OnePersonTipViewController : UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length == 1 {
            let recibedAmount : String = String(textField.text?.dropLast() ?? "")
            saveValues(withStringAmount: recibedAmount)
            calculatePercent(withAmount: ingresaCuenta)
            lblMontoTotal.text = "$ \(ingresaCuenta + percentResult)"
            btnLimpiar.isHidden = false
        } else {
            let recibedAmount : String = (textField.text ?? "") + string
            saveValues(withStringAmount: recibedAmount)
            calculatePercent(withAmount: ingresaCuenta)
            lblMontoTotal.text = "$ \(ingresaCuenta + percentResult)"
            btnLimpiar.isHidden = true
        }
        return true
    }
}
