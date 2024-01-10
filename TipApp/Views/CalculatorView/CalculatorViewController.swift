//
//  CalculatorViewController.swift
//  TipApp
//
//  Created by LUIS GONZALEZ on 02/01/24.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    //MARK: - O U T L E S
    
    //result
    @IBOutlet weak var lblResult: UILabel!
    
    
    //numbers
    @IBOutlet weak var lblComa: UIButton!
    @IBOutlet weak var lblNumber0: UIButton!
    @IBOutlet weak var lblNumber1: UIButton!
    @IBOutlet weak var lblNumber2: UIButton!
    @IBOutlet weak var lblNumber3: UIButton!
    @IBOutlet weak var lblNumber4: UIButton!
    @IBOutlet weak var lblNumber5: UIButton!
    @IBOutlet weak var lblNumber6: UIButton!
    @IBOutlet weak var lblNumber7: UIButton!
    @IBOutlet weak var lblNumber8: UIButton!
    @IBOutlet weak var lblNumber9: UIButton!
    
    //operators
    @IBOutlet weak var lbloperatorAC: UIButton!
    @IBOutlet weak var lblOperatorPlusMinus: UIButton!
    @IBOutlet weak var lblOperatorResult: UIButton!
    @IBOutlet weak var lblOperatorAdition: UIButton!
    @IBOutlet weak var lblOperatorMinus: UIButton!
    @IBOutlet weak var lblOperatorMultiplication: UIButton!
    @IBOutlet weak var lblOperatorPercent: UIButton!
    @IBOutlet weak var lblOperatorDivision: UIButton!
    
    //MARK: - V A R I A B L E S
    
    private var total : Double = 0                       // almacena total
    private var temp : Double = 0                        // valor por pantalla temporal
    private var operating = false                        // indicr si se ha seleccionado un operador
    private var deciaml = false                          // indicar si el valor es decimal
    private var operation : operationType = .none  // operacion actual
    
    //MARK: - C O N S T A N T E S
    
    private let kDecimalSeparator = Locale.current.decimalSeparator! // definir separador decimal por pais
    private let kMaxLenght = 9                          // tamanio de numeros a trabajar en pantalla
    private let kTotal = "total"
    
    private enum operationType {
        case none, addiction, substraction, mutiplication, division, percent
        }
    
    // Formateo de valores auxiliares - formate de modo que se va utilizando la app
    private let auxFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 100
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 100
        return formatter
    }()
    
    // Formateo de modo que se va utilizando la app en resultdo final
    private let auxTotalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = ""
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 100
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 100
        return formatter
    }()
    
    
    
    // Formateo de valores por pantalla por defecto
    private let printFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = locale.groupingSeparator
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 9
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        return formatter
    }()
    
    //Formateo de valores por pantalla en frmato cientifico
    private let printScientificFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.maximumFractionDigits = 3
        formatter.exponentSymbol = "e"
        return formatter
    }()
   
    //MARK: - L I F E . C Y C L E
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblComa.setTitle(kDecimalSeparator, for: .normal)
        
        total = UserDefaults.standard.double(forKey: kTotal)
        
        result()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.lblComa.round()
        self.lblNumber0.round()
        self.lblNumber1.round()
        self.lblNumber2.round()
        self.lblNumber3.round()
        self.lblNumber4.round()
        self.lblNumber5.round()
        self.lblNumber6.round()
        self.lblNumber7.round()
        self.lblNumber8.round()
        self.lblNumber9.round()
        
        self.lbloperatorAC.round()
        self.lblOperatorMinus.round()
        self.lblOperatorResult.round()
        self.lblOperatorAdition.round()
        self.lblOperatorPercent.round()
        self.lblOperatorDivision.round()
        self.lblOperatorMultiplication.round()
        self.lblOperatorPlusMinus.round()
    }


    //MARK: - B U T T O N  A C T I O N S
    
    @IBAction func operatorAC(_ sender: UIButton) {
        clear()
        sender.shine()
    }
    
    @IBAction func operatorPlusMinus(_ sender: UIButton) {
        if operation != .none {
            result()
        }
        temp = temp * (-1)
        lblResult.text = printFormatter.string(from: temp as NSNumber)
        sender.shine()
    }
    
    @IBAction func operatorPercent(_ sender: UIButton) {
        if operation != .percent {
            result()
        }
        operating = true
        operation = .percent
        result()
        sender.shine()
    }
    
    @IBAction func operatorDivision(_ sender: UIButton) {
        if operation != .none {
            result()
        }
        operating = true
        operation = .division
        sender.selectOperation(true)
        sender.shine()
    }
    
    @IBAction func operatorMultiplier(_ sender: UIButton) {
        if operation != .none {
            result()
        }
        operating = true
        operation = .mutiplication
        sender.selectOperation(true)
        sender.shine()

    }
    
    @IBAction func operationMinus(_ sender: UIButton) {
        if operation != .none {
            result()
        }
        operating = true
        operation = .substraction
        sender.selectOperation(true)
        sender.shine()
    }
    
    @IBAction func operatorAdition(_ sender: UIButton) {
        if operation != .none {
            result()
        }
        operating = true
        operation = .addiction
        sender.selectOperation(true)
        sender.shine()
    }
    
    @IBAction func operatorResult(_ sender: UIButton) {
        result()
        sender.shine()
    }
    
    @IBAction func operatorComa(_ sender: UIButton) {
        let currentTemp = auxTotalFormatter.string(from: NSNumber(value: temp))
        if !operating && currentTemp?.count ?? 0 >= kMaxLenght {
            return
        }
        
        lblResult.text = (lblResult.text ?? "") + kDecimalSeparator
        deciaml = true
        selectVisualOperation()
        sender.shine()
    }
    
    
    @IBAction func numberAction(_ sender: UIButton) {
        lbloperatorAC.setTitle("C", for: .normal)
        var currentTemp = auxTotalFormatter.string(from: NSNumber(value: temp))
        if !operating && currentTemp?.count ?? 0 >= kMaxLenght {
            return
        }
        
        currentTemp = auxFormatter.string(from: NSNumber(value: temp))!
        
        // seleccion de operacion
        if operating {
            total = total == 0 ? temp : total
            lblResult.text = ""
            currentTemp = ""
            operating = false
        }
        
        // operando con decimales
        if deciaml {
            currentTemp = "\(currentTemp ?? "")\(kDecimalSeparator)"
            deciaml = false
        }
        
        let number = sender.tag
        temp = Double(currentTemp! + String(number))!
        lblResult.text = printFormatter.string(from: NSNumber(value: temp))
        
        selectVisualOperation()
       
        sender.shine()
    
    }
    
    //Limpiar valores
    private func clear() {
        operation = .none
        lbloperatorAC.setTitle("AC", for: .normal)
        if temp != 0 {
            temp = 0
            lblResult.text = "0"
        } else {
            total = 0
            result()
        }
    }
    // Obtiene resultado final
    private func result() {
        switch operation {
        case .none:
            // no hago operacion
            break
        case .addiction:
            total = total + temp
            break
        case .substraction:
            total = total - temp
            break
        case .mutiplication:
            total = total * temp
            break
        case .division:
            total = total / temp
            break
        case .percent:
            temp = temp / 100
            total = temp
            break
        }
        
        //Formateo de pantalla
        if let currentTotal =  auxTotalFormatter.string(from: NSNumber(value: total)), currentTotal.count > kMaxLenght {
            lblResult.text = printScientificFormatter.string(from: NSNumber(value: total))
        } else {
            lblResult.text = printFormatter.string(from: NSNumber(value: total))
        }
        
        operation = .none
        
        selectVisualOperation()
        UserDefaults.standard.set(total, forKey: kTotal)
        print("Total \(total)")
        
    }
    
    //Muestra de forma visual la oeracion seleccionada
    private func selectVisualOperation() {
        
        lblOperatorAdition.selectOperation(false)
        lblOperatorMinus.selectOperation(false)
        lblOperatorMultiplication.selectOperation(false)
        lblOperatorDivision.selectOperation(false)
        
        if !operating {
            // no estamos operando
        } else {
            switch operation {
            case .none, .percent:
                lblOperatorAdition.selectOperation(false)
                lblOperatorMinus.selectOperation(false)
                lblOperatorMultiplication.selectOperation(false)
                lblOperatorDivision.selectOperation(false)
                break
            case .addiction:
                lblOperatorAdition.selectOperation(true)
                lblOperatorMinus.selectOperation(false)
                lblOperatorMultiplication.selectOperation(false)
                lblOperatorDivision.selectOperation(false)
                break
            case .substraction:
                lblOperatorAdition.selectOperation(false)
                lblOperatorMinus.selectOperation(true)
                lblOperatorMultiplication.selectOperation(false)
                lblOperatorDivision.selectOperation(false)
                break
            case .mutiplication:
                lblOperatorAdition.selectOperation(false)
                lblOperatorMinus.selectOperation(false)
                lblOperatorMultiplication.selectOperation(true)
                lblOperatorDivision.selectOperation(false)
                break
            case .division:
                lblOperatorAdition.selectOperation(false)
                lblOperatorMinus.selectOperation(false)
                lblOperatorMultiplication.selectOperation(false)
                lblOperatorDivision.selectOperation(true)
                break
      
            }
        }
    }
    
}
