//
//  ExtensionTipCalculator.swift
//  TipApp
//
//  Created by LUIS GONZALEZ on 10/01/24.
//

import UIKit

extension TipCalculatorViewController : UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string != "" {
            var recibedAmount : String = (textField.text ?? "") + string
            self.ingresaCuenta = self.toDouble(withAmount: recibedAmount)
            recibedAmount = ""
            calculatePercent(withAmount: ingresaCuenta)
            lblMontoTotal.text = formatToMoney(withDouble: ingresaCuenta + percentResult)
            lblMontoPorPersonaResult.text = formatToMoney(withDouble: ingresaCuenta + percentResult)
        }else{
            let recibedAmount : String = String(textField.text?.dropLast() ?? "")
            self.ingresaCuenta = self.toDouble(withAmount: recibedAmount)
            calculatePercent(withAmount: ingresaCuenta)
            lblMontoTotal.text = formatToMoney(withDouble: ingresaCuenta + percentResult)
            lblMontoPorPersonaResult.text = formatToMoney(withDouble: ingresaCuenta + percentResult)
        }
        return true
    }
}

