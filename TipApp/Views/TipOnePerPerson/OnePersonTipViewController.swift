//
//  OnePersonTipViewController.swift
//  TipApp
//
//  Created by LUIS GONZALEZ on 18/01/24.
//

import UIKit

class OnePersonTipViewController: UIViewController {
    
    //MARK: - O U T L E T S

    
    @IBOutlet weak var lblCuenta: UILabel!
    @IBOutlet weak var txtIngresarCuenta: UITextField!{
        didSet {self.txtIngresarCuenta.delegate = self}
    }
    @IBOutlet weak var lblPropina: UILabel!
    @IBOutlet weak var segmentedControlPorcentaje: UISegmentedControl!
    @IBOutlet weak var lblPropinaResult: UILabel!
    @IBOutlet weak var lblMontoPropinaResult: UILabel!
    @IBOutlet weak var imgDivision: UIView!
    @IBOutlet weak var lblMontoTotal: UILabel!
    @IBOutlet weak var btnLimpiar: UIButton!
    @IBOutlet weak var lblMontoTotalResult: UILabel!
    
    //MARK: - V A R I A B L E S
    
    var ingresaCuenta : Double = 0
    private var choosePercent : percent = .none
    var percentResult : Double = 0
    
    private enum percent {
        case none, tenPercent, fifteenPercent, twentyPercent, twentyfivePercent
    }
    
    //MARK: - L I F E . C Y C L E
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: - F U N C T I O N S
    
    func saveValues( withStringAmount strAmnt : String){
        self.ingresaCuenta = Double(strAmnt) ?? 0.0
    }
    
    
    func calculatePercent( withAmount : Double) {
            switch choosePercent {
            case .tenPercent, .none:
                percentResult = withAmount * 0.1
                lblMontoPropinaResult.text = "\(percentResult)"
                segmentedControlPorcentaje.isHidden = false
                break
            case .fifteenPercent:
                percentResult = withAmount * 0.15
                lblMontoPropinaResult.text = "\(percentResult)"
                segmentedControlPorcentaje.isHidden = false
                break
            case .twentyPercent:
                percentResult = withAmount * 0.2
                lblMontoPropinaResult.text = "\(percentResult)"
                segmentedControlPorcentaje.isHidden = false
                break
            case .twentyfivePercent:
                percentResult = withAmount * 0.25
                lblMontoPropinaResult.text = "\(percentResult)"
                segmentedControlPorcentaje.isHidden = false
                break
            }
    }
    
    
    //MARK: - A C T I O N S
    @IBAction func selectPercent(_ sender: Any) {
            switch segmentedControlPorcentaje.selectedSegmentIndex {
            case 0:
                choosePercent = .tenPercent
                percentResult = ingresaCuenta
                calculatePercent(withAmount: percentResult)
                lblMontoTotalResult.text = "$ \(ingresaCuenta + percentResult)"
  
            case 1:
                choosePercent = .fifteenPercent
                percentResult = ingresaCuenta
                calculatePercent(withAmount: percentResult)
                lblMontoTotalResult.text = "$ \(ingresaCuenta + percentResult)"
            case 2:
                choosePercent = .twentyPercent
                percentResult = ingresaCuenta
                calculatePercent(withAmount: percentResult)
                lblMontoTotalResult.text = "$ \(ingresaCuenta + percentResult)"
            case 3:
                choosePercent = .twentyfivePercent
                percentResult = ingresaCuenta
                calculatePercent(withAmount: percentResult)
                lblMontoTotalResult.text = "$ \(ingresaCuenta + percentResult)"
            default:
                break
            }
    }
    

    @IBAction func btnLimpiarCuetna(_ sender: Any) {
        let ingresaCuenta : Double = Double("") ?? 0.0
        txtIngresarCuenta.text = String(ingresaCuenta)
        lblMontoPropinaResult.text = "$\(0.00)"
        lblMontoTotalResult.text = "$\(0.00)"
        segmentedControlPorcentaje.selectedSegmentIndex = 0
        segmentedControlPorcentaje.selectedSegmentIndex = 1
    }
    

}
