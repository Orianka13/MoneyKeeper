//
//  NewItemViewController.swift
//  MoneyKeeper
//
//  Created by Олеся Егорова on 28.01.2023.
//

import UIKit

class NewItemViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var itemTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var sumTextField: UITextField!
    
    var isIncome: Bool!
    var income: IncomeItem?
    var expense: ExpenseItem?
    var delegate: NewItemViewControllerDelegate!
    
    private let pickerView = UIPickerView()
    private let datePicker = UIDatePicker()
    
    private let incomeItems = IncomeItem.allCases
    private let expenseItems = ExpenseItem.allCases
    
    private var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setPickerView()
        setDatePicker()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func okButtonPressed(_ sender: UIButton) {
        guard let item = itemTextField.text, itemTextField.text != nil else {
            showAlert(message: "Выберите категорию")
            return
        }
        guard let date = formatter.date(from:dateTextField.text ?? "") else {
            showAlert(message: "Выберите дату")
            return
        }
        
        guard let sum = Double(sumTextField.text ?? "") else {
            showAlert(message: "Введите сумму")
            sumTextField.text = ""
            return
        }
        
        let newItem = Item(category: isIncome ? .income : .expense,
                             item: item,
                             date: date,
                             sum: sum)
        
        itemTextField.text = ""
        dateTextField.text = ""
        sumTextField.text = ""
        
        delegate.addNew(item: newItem)
        dismiss(animated: true)
    }
    
  
    
    private func setUI(){
        if isIncome {
            titleLabel.text = "Новый доход"
        } else {
            titleLabel.text = "Новый расход"
        }
    }
    
    private func setPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedPickerView))
        toolBar.setItems([doneButton], animated: true)
        itemTextField.inputAccessoryView = toolBar
        
        pickerView.delegate = self
        pickerView.dataSource = self
        itemTextField.inputView = pickerView
    }
    
    private func setDatePicker() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolBar.setItems([doneButton], animated: true)
        
        dateTextField.inputAccessoryView = toolBar
        datePicker.datePickerMode = .date
        dateTextField.inputView = datePicker
        datePicker.preferredDatePickerStyle = .wheels
    }
    
    @objc private func donePressed() {
        dateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc private func donePressedPickerView() {
        let currentValue = isIncome
        ? incomeItems[pickerView.selectedRow(inComponent: 0)].rawValue
        : expenseItems[pickerView.selectedRow(inComponent: 0)].rawValue
        itemTextField.text = currentValue
        view.endEditing(true)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    // MARK: - Navigation
}

//MARK: - UIPickerViewDelegate

extension NewItemViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        isIncome ? incomeItems[row].rawValue : expenseItems[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedPoint = isIncome ? incomeItems[row].rawValue : expenseItems[row].rawValue
        itemTextField.text = selectedPoint
    }
}

//MARK: - UIPickerViewDataSource

extension NewItemViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        isIncome ? incomeItems.count : expenseItems.count
    }
}
