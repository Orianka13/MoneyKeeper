//
//  ItemModel.swift
//  MoneyKeeper
//
//  Created by Олеся Егорова on 24.01.2023.
//

import Foundation

struct IncomeModel {
    let item: IncomeItem
    let date: Date
    let sum: Int
}

struct ExpenseModel {
    let item: ExpenseItem
    let date: Date
    let sum: Int
}

enum IncomeItem: String {
    case rent           = "Аренда"
    case salary         = "Зарплата"
    case investments    = "Инвестиции"
    case gifts          = "Подарки"
    case saving         = "Сбережения"
    case other          = "Другое"
}

enum ExpenseItem: String {
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







