//
//  ViewController.swift
//  Demo Swift
//
//  Created by Eduardo Mello de Macedo | Stone on 14/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

import UIKit
import StoneSDK

class ViewController: UITableViewController {
    
    var optionsList: [String] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "Stone"
        
        self.optionsList.append("Estabelece Sessão com Pinpad")
        self.optionsList.append("Ativação do Stone Code")
        self.optionsList.append("Download das Tabelas")
        self.optionsList.append("Carregamento das Tabelas")
        self.optionsList.append("Realizar Transação")
        self.optionsList.append("Listar Transações")
        self.optionsList.append("Listar Lojistas")
        self.optionsList.append("Cancelar Transações")
        self.optionsList.append("Envio de Comprovante por E-mail")
        self.optionsList.append("Testando Validações")
        self.optionsList.append("Captura de PAN")
        self.optionsList.append("Exibe Mensagem no Display")
        self.optionsList.append("Buscar dispositivos low energy")
        
        // Verificamos se já foi definido um Stone Code;
        if STNValidationProvider.validateActivation() == false {
            NSLog("Sem Stone Code definido.")
        }
        
        STNPinPadConnectionProvider.connect { (succeeded, error) in
            if succeeded {
                NSLog("Pinpad connectado");
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsList.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "simpleTableViewCell")
        cell.textLabel?.text = optionsList[indexPath.row]
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "segueConnectPinpad", sender: nil)
            break
        case 1:
            performSegue(withIdentifier: "segueActivationStoneCode", sender: nil)
            break
        case 2:
            performSegue(withIdentifier: "segueDownloadTable", sender: nil)
            break
        case 3:
            performSegue(withIdentifier: "segueRefreshTables", sender: nil)
            break
        case 4:
            performSegue(withIdentifier: "seguePerformTransaction", sender: nil)
            break
        case 5:
            performSegue(withIdentifier: "segueListTransaction", sender: nil)
            break
        case 6:
            performSegue(withIdentifier: "segueListMerchant", sender: nil)
            break
        case 7:
            performSegue(withIdentifier: "segueCancelTransaction", sender: nil)
            break
        case 8:
            performSegue(withIdentifier: "segueSendingVoucherEmail", sender: nil)
            break
        case 9:
            performSegue(withIdentifier: "segueTesteValidation", sender: nil)
            break
        case 10:
            performSegue(withIdentifier: "segueCapturePan", sender: nil)
            break;
        case 11:
            performSegue(withIdentifier: "segueScreenDisplay", sender: nil)
        case 12:
            performSegue(withIdentifier: "segueSearchLowEnergyDevices", sender: nil)
        default:
            break
        
        }
    }
    
}

