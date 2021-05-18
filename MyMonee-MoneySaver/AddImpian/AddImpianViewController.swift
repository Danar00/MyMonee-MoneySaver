//
//  AddImpianViewController.swift
//  MyMonee-MoneySaver
//
//  Created by MacBook on 14/05/21.
//

import UIKit

class AddImpianViewController: UIViewController {

    
    @IBOutlet weak var titleImpian: UITextField!
    
    @IBOutlet weak var targetImpian: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    fileprivate func goBackToMainTabBar(){
        let viewController = ImpianViewController(nibName: String(describing: ImpianViewController.self), bundle: nil)
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .flipHorizontal
        navigationController?.pushViewController(viewController, animated: true)
//        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func backTambahImpianButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveImpian(_ sender: Any) {
        if titleImpian.text!.isEmpty || targetImpian.text!.isEmpty {
            alert()
            return
        }
        else{
            insertImpian()
        }
        
        goBackToMainTabBar()
    }
    
    func insertImpian() {
//        usageHistory.append(UsageHistory(id: "MF - 32141", usageName: titleLabel.text!, usageDate: getCurrentDate(), price: priceLabel.text!, status: statusInsert))
        
        
        impianData.append(ImpianData(impianName: titleImpian.text!, impianProgress: Float(calculationProgress()), impianPrice: "IDR \(convertIntToFormatMoneyRaw(money: Int(getBalance()))) / IDR \(convertIntToFormatMoneyRaw(money: Int(moneyToDecimal(money: targetImpian.text!))))", impianPriceTarget: Int(targetImpian.text!)!))
    }
    
    private func calculationProgress() -> Double {
        if getBalance() > moneyToDecimal(money: targetImpian.text!) {
            return 1
        }
        else{
            return ((getBalance() / moneyToDecimal(money: targetImpian.text!)))
        }
    }
    
    private func alert() {
        let alert = UIAlertController(title: "Data Tidak Lengkap", message: "Tolong masukkan data dengan lengkap", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
}
