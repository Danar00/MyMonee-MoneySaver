//
//  ImpianViewController.swift
//  MyMonee-MoneySaver
//
//  Created by MacBook on 14/05/21.
//

import UIKit

class ImpianViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewImpian: UITableView!
    
    @IBOutlet weak var emptyDataImpianView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewImpian.delegate = self
        tableViewImpian.dataSource = self
        
        let uiNib = UINib(nibName: String(describing: ImpianViewCell.self), bundle: nil)
        tableViewImpian.register(uiNib, forCellReuseIdentifier: String(describing: ImpianViewCell.self))

        validateEmptyImpian()
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
            emptyDataImpianView.isHidden = true
            tableViewImpian.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    @IBAction func addFirstImpian(_ sender: Any) {
        let addImpian = AddImpianViewController(nibName: String(describing: AddImpianViewController.self), bundle: nil)
        navigationController?.pushViewController(addImpian, animated: true)
    }
    
    @IBAction func addImpian(_ sender: Any) {
        let addImpian = AddImpianViewController(nibName: String(describing: AddImpianViewController.self), bundle: nil)
        navigationController?.pushViewController(addImpian, animated: true)
    }
    
}
