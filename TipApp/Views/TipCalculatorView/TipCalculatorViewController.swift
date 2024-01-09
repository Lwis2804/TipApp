

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
    
    var ingresaCuenta : Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func saveValues(){
        self.ingresaCuenta = Int(txtIngresarCuenta.text ?? "0" ) ?? 0
    }
    
    
    @IBAction func selectPercent(_ sender: Any) {
        saveValues()
        
    }
    
    
    

}
