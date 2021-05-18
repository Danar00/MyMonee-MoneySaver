//
//  EditImpianViewController.swift
//  MyMonee-MoneySaver
//
//  Created by MacBook on 15/05/21.
//

import UIKit

class EditImpianViewController: UIViewController {
    
    
    @IBOutlet weak var titleEditImpian: UITextField!
    
    @IBOutlet weak var targetPriceEditImpian: UITextField!
    
    var textTitle: String = ""
    var textPrice: String = ""
    var indexData: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleEditImpian.text = textTitle
        targetPriceEditImpian.text = textPrice.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
    }
    
    fileprivate func goBackToMainTabBar(){
        let viewController = ImpianViewController(nibName: String(describing: ImpianViewController.self), bundle: nil)
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .flipHorizontal
        navigationController?.pushViewController(viewController, animated: true)
//        self.present(viewController, animated: true, completion: nil)
    }
    
    private func alert() {
        let alert = UIAlertController(title: "Data Tidak Lengkap", message: "Tolong masukkan data dengan lengkap", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func backEditImpianButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func updateData(){
        impianData[indexData!] = ImpianData(impianName: titleEditImpian.text!, impianProgress: Float(calculationProgress()), impianPrice: "IDR \(convertIntToFormatMoneyRaw(money: Int(getBalance())) ) / IDR \(convertIntToFormatMoneyRaw(money: Int(moneyToDecimal(money: targetPriceEditImpian.text!))))", impianPriceTarget: Int(targetPriceEditImpian.text!)!)
    }
    
    private func calculationProgress() -> Double {
        if getBalance() > moneyToDecimal(money: targetPriceEditImpian.text!) {
            return 1
        }
        else{
            return ((getBalance() / moneyToDecimal(money: targetPriceEditImpian.text!)))
        }
    }
    
    
    @IBAction func editImpianButton(_ sender: Any) {
        if titleEditImpian.text!.isEmpty || targetPriceEditImpian.text!.isEmpty {
            alert()
            return
        }
        else{
            updateData()
        }
        goBackToMainTabBar()
    }
    
    @IBAction func deleteImpianButton(_ sender: Any) {
        impianData.remove(at: indexData!)
        goBackToMainTabBar()
    }
    
}
