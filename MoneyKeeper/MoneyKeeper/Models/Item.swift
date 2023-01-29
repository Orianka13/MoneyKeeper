//
//  ItemModel.swift
//  MoneyKeeper
//
//  Created by Олеся Егорова on 24.01.2023.
//

import Foundation


struct Item: Equatable {
    let category: Category
    let item: String
    let date: Date
    let sum: Double
}

enum Category {
    case income
    case expense
}

enum IncomeItem: String, CaseIterable {
    case rent           = "Аренда"
    case salary         = "Зарплата"
    case investments    = "Инвестиции"
    case gifts          = "Подарки"
    case saving         = "Сбережения"
    case other          = "Другое"
}
enum ExpenseItem: String, CaseIterable {
    case rent               = "Аренда"
    case health             = "Здоровье"
    case cafe               = "Кафе"
    case credit             = "Кредит"
    case clothes            = "Одежда"
    case pet                = "Питомец"
    case gifts              = "Подарки"
    case products           = "Продукты"
    case entertainment      = "Развлечения"
    case connection         = "Связь"
    case sport              = "Спорт"
    case accounts           = "Счета"
    case transport          = "Транспорт"
    case other              = "Другое"
}

