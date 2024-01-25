

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
    var nOPersonas: Int = 1
    
    private enum percent {
        case none, tenPercent, fifteenPercent, twentyPercent, twentyfivePercent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtIngresarCuenta.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    
    //MARK: - F U N C T I O N S
    
    func toDouble(withAmount strAmnt: String) -> Double {
        return Double(strAmnt) ?? 0.0
    }
    
    
    func calculatePercent( withAmount : Double) {
            switch choosePercent {
            case .tenPercent, .none:
                percentResult = withAmount * 0.1
                lblMontoPropinaResult.text = "\(percentResult / Double(nOPersonas))"
                segmentedControlPorcentaje.isHidden = false
                break
            case .fifteenPercent:
                percentResult = withAmount * 0.15
                lblMontoPropinaResult.text = "\(percentResult / Double(nOPersonas))"
                segmentedControlPorcentaje.isHidden = false
                break
            case .twentyPercent:
                percentResult = withAmount * 0.2
                lblMontoPropinaResult.text = "\(percentResult / Double(nOPersonas))"
                segmentedControlPorcentaje.isHidden = false
                break
            case .twentyfivePercent:
                percentResult = withAmount * 0.25
                lblMontoPropinaResult.text = "\(percentResult / Double(nOPersonas))"
                segmentedControlPorcentaje.isHidden = false
                break
            }
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        // APARECER BOTON DE LIMPIAR
    }
    
    func updateAmount(){
        calculatePercent(withAmount: self.toDouble(withAmount: txtIngresarCuenta.text ?? ""))
        lblMontoTotal.text = "$ \(ingresaCuenta + percentResult)"
        lblMontoPorPersonaResult.text = "$ \(ingresaCuenta + percentResult)"
    }
    
    
    //MARK: - A C T I O N S
    @IBAction func selectPercent(_ sender: Any) {
        switch segmentedControlPorcentaje.selectedSegmentIndex {
        case 0:
            choosePercent = .tenPercent
            self.updateAmount()
        case 1:
            choosePercent = .fifteenPercent
            self.updateAmount()
        case 2:
            choosePercent = .twentyPercent
            self.updateAmount()
        case 3:
            choosePercent = .twentyfivePercent
            self.updateAmount()
        default:
            break
        }
    }
    

    @IBAction func addPerson(_ sender: UIStepper) {
        sender.minimumValue = 1
        lblNoPersonas.text = "\(Int(sender.value))"
        self.nOPersonas = Int(sender.value)
        let propinaNoPersonas = percentResult / Double(nOPersonas)
        let totalPorPersona = (ingresaCuenta + percentResult) / Double(nOPersonas)
        lblMontoPropinaResult.text = String(propinaNoPersonas)
        lblMontoPorPersonaResult.text = String(totalPorPersona)
    }

    @IBAction func btnLimpiarAction(_ sender: Any) {
        let ingresaCuenta : Double = Double("") ?? 0.0
        txtIngresarCuenta.text = String(ingresaCuenta)
        lblMontoPropinaResult.text = "$\(0.00)"
        lblMontoTotal.text = "$\(0.00)"
        lblMontoPorPersonaResult.text = "$\(0.00)"
        segmentedControlPorcentaje.selectedSegmentIndex = 0
        segmentedControlPorcentaje.selectedSegmentIndex = 0
        lblNoPersonas.text = "\(1)"
    }
    
    
}
