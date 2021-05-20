//
//  ImpianViewController.swift
//  MyMonee-MoneySaver
//
//  Created by MacBook on 14/05/21.
//

import UIKit

class ImpianViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EmptyDataDelegate, ButtonCell{
    
    @IBOutlet weak var tableViewImpian: UITableView!
    
    @IBOutlet weak var emptyDataImpianView: EmptyDataImpian!
    
    var indexData: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewImpian.delegate = self
        tableViewImpian.dataSource = self
        
        let uiNib = UINib(nibName: String(describing: ImpianViewCell.self), bundle: nil)
        tableViewImpian.register(uiNib, forCellReuseIdentifier: String(describing: ImpianViewCell.self))

        validateEmptyImpian()
        if let savedData = UserDefaults.standard.value(forKey: "savedArrayImpian") as? Data {
            let _impianData = try? PropertyListDecoder().decode(Array<ImpianData>.self, from: savedData)
            impianData = _impianData ?? []
        }
        emptyDataImpianView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        validateEmptyImpian()
        tableViewImpian.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return impianData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ImpianViewCell.self), for: indexPath) as! ImpianViewCell
        cell.layer.backgroundColor = UIColor.clear.cgColor
        
        cell.titleLabel.text = impianData[indexPath.row].impianName
        cell.progress.progress = impianData[indexPath.row].impianProgress
        cell.priceLabel.text = impianData[indexPath.row].impianPrice
        cell.indexData = indexPath.row
        if impianData[indexPath.row].impianProgress == 1 {
            cell.buttonDetail.setImage(UIImage(named: "ic_checklist"), for: .normal)
            cell.buttonDetail.isEnabled = true
        }
        else{
            cell.buttonDetail.setImage(UIImage(named: "ic_checklist_disable"), for: .normal)
            cell.buttonDetail.isEnabled = false
        }
        cell.delegate = self
        
        indexData = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailImpianViewController = DetailImpianViewController(nibName: String(describing: DetailImpianViewController.self), bundle: nil)
        
        let selectedRow = impianData[indexPath.row]
        
        detailImpianViewController.textTitle = selectedRow.impianName
        detailImpianViewController.textPrice = convertIntToFormatMoney(money: selectedRow.impianPriceTarget, isDepoOrWithdraw: nil)
        detailImpianViewController.progressBar = selectedRow.impianProgress
        detailImpianViewController.textProgressTarget = "\(Int(selectedRow.impianProgress * 100))%"
        detailImpianViewController.progressPrice = selectedRow.impianPrice
        detailImpianViewController.indexData = indexPath.row
        
        navigationController?.pushViewController(detailImpianViewController, animated: true)
    }
    
    func validateEmptyImpian() {
        if impianData.isEmpty {
            emptyDataImpianView.isHidden = false
            tableViewImpian.isHidden = true
            emptyDataImpianView.backgroundColor = .clear
        }
        else{
            tableViewImpian.isHidden = false
            emptyDataImpianView.isHidden = true
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        validateEmptyImpian()
    }
        
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func addImpian(_ sender: Any) {
        let addImpian = AddImpianViewController(nibName: String(describing: AddImpianViewController.self), bundle: nil)
        navigationController?.pushViewController(addImpian, animated: true)
    }
    
    func add() {
        let addImpian = AddImpianViewController(nibName: String(describing: AddImpianViewController.self), bundle: nil)
        navigationController?.pushViewController(addImpian, animated: true)
    }
    
    func confirmationButton(index: Int) {
        let selectedRow = impianData[index]
        impianData.remove(at: index)
        usageHistory.append(UsageHistory(usageName: selectedRow.impianName, usageDate: currentDate(), price: selectedRow.impianPriceTarget, status: true))
        UserDefaults.standard.set(try? PropertyListEncoder().encode(impianData), forKey: "savedArray")
        tableViewImpian.reloadData()
        self.viewDidAppear(true)
    }
    
    func delete(index: Int) {
        impianData.remove(at: index)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(impianData), forKey: "savedArrayImpian")
        tableViewImpian.reloadData()
        self.viewDidAppear(true)
    }
}

extension ImpianViewController: ConvertDate {
    func currentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy - HH.mm"
        let result = formatter.string(from: date)
        return result
    }
}
