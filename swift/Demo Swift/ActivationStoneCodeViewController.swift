//
//  ActivationStoneCodeViewController.swift
//  Demo Swift
//
//  Created by Eduardo Mello de Macedo | Stone on 15/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

import UIKit
import StoneSDK

class ActivationStoneCodeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var stoneCodeTextField: UITextField!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var loadingView: LoadingView!
    
    var environments = ["Produção",
                        "InternalHomolog",
                        "Sandbox",
                        "Staging",
                        "Certification"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Ativar Stone Code"
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        //warning: IMPLEMENT DYNAMIC ENVIROMENT SET
        self.pickerView.selectRow(Int(STNConfig.environment.rawValue),
                                  inComponent: 0,
                                  animated: false)
        
        self.loadingView = LoadingView.init(frame: UIScreen.main.bounds)
        self.navigationController?.view.addSubview(self.loadingView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func performActivation(_ sender: Any) {
        let stoneCode: String = self.stoneCodeTextField.text!
        /*
            Efetuando ativação do Stone Code;
         */
        self.loadingView.show()
        STNStoneCodeActivationProvider.activateStoneCode(stoneCode) { (succeeded, error) in
            DispatchQueue.main.async {
                if succeeded
                {
                    self.feedbackLabel.text = "Stone Code Ativado com Sucesso."
                }
                else
                {
                    self.feedbackLabel.text = error.debugDescription
                }
                self.loadingView.hide()
            }
        }
    }
    
    @IBAction func performDeactivation(_ sender: Any) {
        let stoneCode: String = self.stoneCodeTextField.text!
        /*
            Efetuando a Desativação do Stone Code;
         */
        STNStoneCodeActivationProvider.deactivateMerchant(withStoneCode: stoneCode)
        self.feedbackLabel.text = "Desativação realizada com sucesso."
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return environments.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return environments[row];
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        //            TODO: SET ENVIRONMENT BY MERCHANT DATA
        case 0:
            STNConfig.environment = STNEnvironmentProduction
            break
        case 1:
            STNConfig.environment = STNEnvironmentInternalHomolog
            break
        case 2:
            STNConfig.environment = STNEnvironmentSandbox
            break
        case 3:
            STNConfig.environment = STNEnvironmentStaging
            break
        case 4:
            STNConfig.environment = STNEnvironmentCertification
            break
        default:
            break
        }
    }
}
