

import UIKit

class TipCalculatorViewController: UIViewController {
    
    //MARK: - O U T L E T S
    
    @IBOutlet weak var lblCuenta: UILabel!
    @IBOutlet weak var txtIngresarCuenta: UITextField!
    @IBOutlet weak var lblPropina: UILabel!
    @IBOutlet weak var segmentedControlPorcentaje: UISegmentedControl!
    @IBOutlet weak var lblPorPersona: UILabel!
    @IBOutlet weak var steperPersonas: UIStepper!{
        didSet{self.steperPersonas.value = 1}
    }
    @IBOutlet weak var lblNoPersonas: UILabel!
    @IBOutlet weak var lblPropinaResult: UILabel!
    @IBOutlet weak var lblMontoPropinaResult: UILabel!
    @IBOutlet weak var imgDivision: UIView!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblMontoTotal: UILabel!
    @IBOutlet weak var btnLimpiar: UIButton!
    @IBOutlet weak var lblMontoPorPersona: UILabel!
    @IBOutlet weak var lblMontoPorPersonaResult: UILabel!
    //MARK: - V A R I A B L E S
    
    var ingresaCuenta : Double = 0
    private var choosePercent : percent = .none
    var percentResult : Double = 0
    
    private enum percent {
        case none, tenPercent, fifteenPercent, twentyPercent, twentyfivePercent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtIngresarCuenta.delegate = self
        segmentedControlPorcentaje.isHidden = true
        btnLimpiar.isHidden = true
        steperPersonas.isHidden = true
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
    
    func divideTip() {
        
    }
    
    
    //MARK: - A C T I O N S
    @IBAction func selectPercent(_ sender: Any) {
            switch segmentedControlPorcentaje.selectedSegmentIndex {
            case 0:
                choosePercent = .tenPercent
                percentResult = ingresaCuenta
                calculatePercent(withAmount: percentResult)
                lblMontoTotal.text = "$ \(ingresaCuenta + percentResult)"
                lblMontoPorPersonaResult.text = "$ \(ingresaCuenta + percentResult)"
            case 1:
                choosePercent = .fifteenPercent
                percentResult = ingresaCuenta
                calculatePercent(withAmount: percentResult)
                lblMontoTotal.text = "$ \(ingresaCuenta + percentResult)"
                lblMontoPorPersonaResult.text = "$ \(ingresaCuenta + percentResult)"
            case 2:
                choosePercent = .twentyPercent
                percentResult = ingresaCuenta
                calculatePercent(withAmount: percentResult)
                lblMontoTotal.text = "$ \(ingresaCuenta + percentResult)"
                lblMontoPorPersonaResult.text = "$ \(ingresaCuenta + percentResult)"
            case 3:
                choosePercent = .twentyfivePercent
                percentResult = ingresaCuenta
                calculatePercent(withAmount: percentResult)
                lblMontoTotal.text = "$ \(ingresaCuenta + percentResult)"
                lblMontoPorPersonaResult.text = "$ \(ingresaCuenta + percentResult)"
            default:
                break
            }
    }
    

    @IBAction func addPerson(_ sender: UIStepper) {
     /*   if sender.value <= 1 {
            steperPersonas.isHidden = true
       } else {
            steperPersonas.isHidden = false
        } */
        lblNoPersonas.text = "\(Int(sender.value))"
        let propinaNoPersonas = percentResult / sender.value
        let totalPorPersona = (ingresaCuenta + percentResult) / sender.value
        print(sender.value)
        lblMontoPropinaResult.text = String(propinaNoPersonas)
        lblMontoPorPersonaResult.text = String(totalPorPersona)
    }

}
