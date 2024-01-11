

import UIKit

class TipCalculatorViewController: UIViewController {
    
    //MARK: - O U T L E T S
    
    @IBOutlet weak var lblCuenta: UILabel!
    @IBOutlet weak var txtIngresarCuenta: UITextField!
    @IBOutlet weak var lblPropina: UILabel!
    @IBOutlet weak var lblPorcentaje: UILabel!
    @IBOutlet weak var segmentedControlPorcentaje: UISegmentedControl!
    @IBOutlet weak var lblPorPersona: UILabel!
    @IBOutlet weak var steperPersonas: UIStepper!
    @IBOutlet weak var lblNoPersonas: UILabel!
    @IBOutlet weak var segmentedDivision: UISegmentedControl!
    @IBOutlet weak var lblPropinaResult: UILabel!
    @IBOutlet weak var lblMontoPropinaResult: UILabel!
    @IBOutlet weak var imgDivision: UIView!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblMontoTotal: UILabel!
    @IBOutlet weak var btnLimpiar: UIButton!
    
    //MARK: - V A R I A B L E S
    
    var ingresaCuenta : Double = 0
    private var choosePercent : percent = .none
    private var percentResult : Double = 0
    
    private enum percent {
        case none, tenPercent, fifteenPercent, twentyPercent, twentyfivePercent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtIngresarCuenta.delegate = self
        lblPorcentaje.text = "0"
       
    }
    
    func saveValues( withStringAmount strAmnt : String){
        self.ingresaCuenta = Double(strAmnt) ?? 0.0
    }
    

    
    @IBAction func selectPercent(_ sender: Any) {
        
        switch segmentedControlPorcentaje.selectedSegmentIndex {
        case 0:
            choosePercent = .tenPercent
            break
        case 1:
            choosePercent = .fifteenPercent
            break
        case 2:
            choosePercent = .twentyPercent
            break
        case 3:
            choosePercent = .twentyfivePercent
            break
        default:
            break
        }
    }
    
    func calculatePercent( withAmount : Double) {
        switch choosePercent {
        case .tenPercent, .none:
            percentResult = withAmount * 0.1
            lblPorcentaje.text = "\(percentResult)"
            break
        case .fifteenPercent:
            percentResult = withAmount * 0.15
            lblPorcentaje.text = "\(percentResult)"
            break
        case .twentyPercent:
            percentResult = withAmount * 0.2
            lblPorcentaje.text = "\(percentResult)"
            break
        case .twentyfivePercent:
            percentResult = withAmount * 0.25
            lblPorcentaje.text = "\(percentResult)"
            break
        }
    }
    
}
