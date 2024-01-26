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
            lblMontoTotalResult.text = "$\(ingresaCuenta + percentResult) MXN"
            btnLimpiar.isHidden = true
        } else {
            let recibedAmount : String = (textField.text ?? "") + string
            saveValues(withStringAmount: recibedAmount)
            calculatePercent(withAmount: ingresaCuenta)
            lblMontoTotalResult.text = "$\(ingresaCuenta + percentResult) MXN"
            btnLimpiar.isHidden = false
        }
        return true
    }
}



extension Double {
    func redondear(numeroDeDecimales: Int) -> String {
        let formateador = NumberFormatter()
        formateador.maximumFractionDigits = numeroDeDecimales
        formateador.roundingMode = .down
        return formateador.string(from: NSNumber(value: self)) ?? ""
    }
}
