//
//  ListViewController.swift
//  MoneyKeeper
//
//  Created by Олеся Егорова on 24.01.2023.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    private var items: [ItemModel] = ItemModel.getIncomes()
    private var expenses: [ItemModel] = ItemModel.getExpenses()
    private var dates: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        setBalance()
        setDates()
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            items = ItemModel.getIncomes()
            setDates()
            tableView.reloadData()
        default:
            items = expenses
            setDates()
            tableView.reloadData()
        }
    }
    
    @IBAction func addIncome(_ sender: UIButton) {
    }
    
    @IBAction func addExpense(_ sender: UIButton) {
    }
    
    private func setDates() {
        let mappingDates = items.map({$0.date})
        dates = distinct(source: mappingDates)
    }
    
    private func distinct<T: Equatable>(source: [T]) -> [T] {
        var unique = [T]()
        for item in source {
            if !unique.contains(item) {
                unique.append(item)
            }
        }
        return unique
    }
    
    private func setBalance() {
        let totalIncome = ItemModel.getIncomes().map({$0.sum})
        let totalExpense = ItemModel.getExpenses().map({$0.sum})
        
        var sumIncome = 0
        for number in totalIncome {
            sumIncome += number
        }
        
        var sumExpense = 0
        for number in totalExpense {
            sumExpense += number
        }
        title = "Баланс: \(sumIncome - sumExpense)"
    }
}



//MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dates.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filteredItems = items.filter{$0.date == dates[section]}
        return filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let filteredItems = items.filter{$0.date == dates[indexPath.section]}
        let item = filteredItems[indexPath.row]
        cell.textLabel?.text = item.item
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        dates[section]
    }
}


//MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
