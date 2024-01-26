

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
        let font = UIFont.systemFont(ofSize: 20)
        segmentedControlPorcentaje.setTitleTextAttributes([NSAttributedString.Key.font: font],
                                                for: .normal)
    }
    
    
    //MARK: - F U N C T I O N S
    
    func toDouble(withAmount strAmnt: String) -> Double {
        return Double(strAmnt) ?? 0.0
    }
    
    func formatToMoney(withDouble Dbl: Double) -> String {
       return String(format: "$ %.2f MXN", Dbl)
    }
    
    func updateValues() {
        lblMontoPropinaResult.text = formatToMoney(withDouble: percentResult / Double(nOPersonas))
        segmentedControlPorcentaje.isHidden = false
    }
    
    
    func calculatePercent( withAmount : Double) {
            switch choosePercent {
            case .tenPercent, .none:
                percentResult = withAmount * 0.1
                updateValues()
                break
            case .fifteenPercent:
                percentResult = withAmount * 0.15
                updateValues()
                break
            case .twentyPercent:
                percentResult = withAmount * 0.2
                updateValues()
                break
            case .twentyfivePercent:
                percentResult = withAmount * 0.25
                updateValues()
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
        lblMontoTotal.text = formatToMoney(withDouble: ingresaCuenta + percentResult)
        lblMontoPorPersonaResult.text = formatToMoney(withDouble: ingresaCuenta + percentResult)
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
        lblMontoPropinaResult.text = formatToMoney(withDouble: percentResult / Double(nOPersonas))
        lblMontoPorPersonaResult.text = formatToMoney(withDouble: (ingresaCuenta + percentResult) / Double(nOPersonas))
    }

    @IBAction func btnLimpiarAction(_ sender: Any) {
        let ingresaCuenta : Double = Double("") ?? 0.0
        txtIngresarCuenta.text = String(ingresaCuenta)
        lblMontoPropinaResult.text = "$\(0.00) MXN"
        lblMontoTotal.text = "$\(0.00)MXN"
        lblMontoPorPersonaResult.text = "$\(0.00)MXN"
        segmentedControlPorcentaje.selectedSegmentIndex = 0
        segmentedControlPorcentaje.selectedSegmentIndex = 0
        lblNoPersonas.text = "\(1)"
    }
    
    
}
