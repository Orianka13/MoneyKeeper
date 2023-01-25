//
//  ListViewController.swift
//  MoneyKeeper
//
//  Created by Олеся Егорова on 24.01.2023.
//

import UIKit

class ListViewController: UIViewController {
    
    private enum Fonts {
        static let segmentedControllFont = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
        static let cellTextFont = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)
        static let cellSecontTextFont = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)
        static let sectionHeaterFont = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
    }
    
    private enum Colors {
        static let secondaryTextColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 0.7)
        static let sectionTextColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 0.5)
        static let cellTextColor: UIColor = .white
    }
    
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
        setSegmentedControl()
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
    
    private func setSegmentedControl(){
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, .font: Fonts.segmentedControllFont ?? UIFont()], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, .font: Fonts.segmentedControllFont ?? UIFont()], for: .normal)
    }
    
    private func setDates() {
        let mappingDates = items.map({$0.date})
        var uniqueDates = [String]()
        for date in mappingDates {
            if !uniqueDates.contains(date) {
                uniqueDates.append(date)
            }
        }
        dates = uniqueDates
    }
    
    private func setBalance() {
        let totalIncome = ItemModel.getIncomes().map({$0.sum})
        let totalExpense = ItemModel.getExpenses().map({$0.sum})
        let sumIncome = totalIncome.reduce(0, +)
        let sumExpense = totalExpense.reduce(0, +)
        title = "Баланс: \(sumIncome - sumExpense) руб"
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
        
        var content = cell.defaultContentConfiguration()
        content.text = item.item
        content.textProperties.color = Colors.cellTextColor
        content.textProperties.font = Fonts.cellTextFont ?? UIFont()
        content.secondaryText = "\(item.sum) руб."
        content.secondaryTextProperties.color = Colors.secondaryTextColor
        content.secondaryTextProperties.font = Fonts.cellSecontTextFont ?? UIFont()
        cell.contentConfiguration = content
        return cell
    }
}


//MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dateLabel = UILabel(
            frame: CGRect(x: 20, y: 3, width: 100, height: 20)
        )
        dateLabel.text = dates[section]
        dateLabel.font = Fonts.sectionHeaterFont
        dateLabel.textColor = Colors.sectionTextColor
        
        let contentVIew = UIView()
        contentVIew.addSubview(dateLabel)
        
        return contentVIew
    }
}

