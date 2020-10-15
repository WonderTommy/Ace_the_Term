//
//  CalculationViewModel.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-08-03.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import Foundation
import UIKit

class GeneralViewModel: ObservableObject {
    public static let updateSubjectListKey = "UPDATE_SUBJECT_LIST_KEY"
    public static let addSubjectListKey = "ADD_SUBJECT_LIST_KEY"
    public static let newSubjectRowKey = "NEW_SUBJECT_ROW_KEY"
    public static let deleteSubjectListKey = "DELETE_SUBJECT_LIST_KEY"
    public static let deleteSubjectRowKey = "DELETE_SUBJECT_ROW_KEY"
    public static let deleteMultiSubjectsListKey = "DELETE_MULTI_SUBLECTS_LIST_KEY"
    public static let deleteMultiSubjectsRowsKey = "DELETE_MULTI_SUBJECTS_ROWS_KEY"
    public static let addItemListKey = "ADD_ITEM_LIST_KEY"
    public static let newItemRowKey = "NEW_ITEM_ROW_KEY"
    public static let modifyItemListKey = "MODIFY_ITEM_LIST_KEY"
    public static let modifyItemRowKey = "MODIFY_ITEM_ROW_KEY"
    public static let deleteMultiItemsListKey = "DELETE_ITEMS_LIST_KEY"
    public static let deleteMultiItemsRowsKey = "DELETE_ITEMS_ROWS_KEY"
    
    public static let updateSubjectListNotificationName = NSNotification.Name(GeneralViewModel.updateSubjectListKey)
    public static let addSubjectListNotificationName = NSNotification.Name(GeneralViewModel.addSubjectListKey)
    public static let deleteSubjectListNotificationName = NSNotification.Name(GeneralViewModel.deleteSubjectListKey)
    public static let deleteMultiSelectsListNotificationName = NSNotification.Name(GeneralViewModel.deleteMultiSubjectsListKey)
    public static let addItemListNotificationName = NSNotification.Name(GeneralViewModel.addItemListKey)
    public static let modifyItemListNotificationName = NSNotification.Name(GeneralViewModel.modifyItemListKey)
    public static let deleteMultiItemsListNotificationName = NSNotification.Name(GeneralViewModel.deleteMultiItemsListKey)
    
    
    public static let addTermListKey = "ADD_TERM_LIST_KEY"
    public static let addTermRowKey = "ADD_TERM_ROW_KEY"
    public static let deleteMultiTermsListKey = "DELETE_MULTI_TERMS_LIST_KEY"
    public static let deleteMultiTermsRowsKey = "DELETE_MULTI_TERMS_ROWS_KEY"
    
    public static let addTermListNotificationName = NSNotification.Name(GeneralViewModel.addTermListKey)
    public static let deleteMultiTermsListNotificationName = Notification.Name(GeneralViewModel.deleteMultiTermsListKey)
    
    public static let addItemForTermKey = "ADD_ITEM_FOR_TERM_KEY"
    public static let addItemForTermRow = "ADD_ITEM_FOR_ROW"
    
    public static let addItemForTermNotificationName = NSNotification.Name(GeneralViewModel.addItemForTermKey)
    
    public static let addRecordListKey = "ADD_RECORD_LIST_KEY"
    public static let addRecordRowKey = "ADD_RECORD_ROW_KEY"
    public static let deleteMultiRecordsListKey = "DELETE_MULTI_RECORDs_LIST_KEY"
    public static let deleteMultiRecordsRows = "DELETE_MULTI_RECORDS_ROWS"
    
    public static let addRecordNotificationName = NSNotification.Name(GeneralViewModel.addRecordListKey)
    public static let deleteMultiRecordsNotificationName = NSNotification.Name(GeneralViewModel.deleteMultiRecordsListKey)
    
    
//    @Published private var calculatorModel: CalculatorModel = GeneralViewModel.createCalculatorModel()
//    @Published private var historyModel: HistoryModel = GeneralViewModel.createHistoryModel()
//    @Published private var settingModel: SettingModel = GeneralViewModel.createSettingModel()
    private var calculatorModel: CalculatorModel = GeneralViewModel.createCalculatorModel()
    private var termModel: TermModel = GeneralViewModel.createTermModel()
    private var historyModel: HistoryModel = GeneralViewModel.createHistoryModel()
    private var settingModel: SettingModel = GeneralViewModel.createSettingModel()
    
    
    
    
    // MARK - Calculator Model
    private static func createCalculatorModel() -> CalculatorModel {
        return CalculatorModel()
    }
    
    private static func createTermModel() -> TermModel {
        return TermModel()
    }
    
    private static func createHistoryModel() -> HistoryModel {
        return HistoryModel()
    }
    
    private static func createSettingModel() -> SettingModel {
        return SettingModel()
    }
    
    // MARK - Calculator Model interface
    public func addSubject(title: String, items: Array<Item>?) {
        self.calculatorModel.addSubject(title: title, items: items)
        let newItemRow = calculatorModel.subjects.count - 1
        NotificationCenter.default.post(name: GeneralViewModel.addSubjectListNotificationName, object: nil, userInfo: [GeneralViewModel.newSubjectRowKey: newItemRow])
    }
    
    public func removeSubject(removeSubject: Subject) {
        self.calculatorModel.removeSubject(removeSubject: removeSubject)
    }
    
    public func removeSubject(at index: Int) {
        self.calculatorModel.removeSubject(at: index)
        NotificationCenter.default.post(name: GeneralViewModel.deleteSubjectListNotificationName, object: nil, userInfo: [GeneralViewModel.deleteSubjectRowKey: index])
    }
    
    public func removeSubjects(at spots: [Int]) {
        self.calculatorModel.removeSubjects(at: spots)
        NotificationCenter.default.post(name: GeneralViewModel.deleteMultiSelectsListNotificationName, object: nil, userInfo: [GeneralViewModel.deleteMultiSubjectsRowsKey: spots])
    }
    
    public func removeSubjects(at spots: [Bool]) {
        self.calculatorModel.removeSubjects(at: spots)
        NotificationCenter.default.post(name: GeneralViewModel.deleteMultiSelectsListNotificationName, object: nil, userInfo: [GeneralViewModel.deleteMultiSubjectsRowsKey: spots])
    }
    
    public func moveSubject(from source: Int, to destination: Int) {
        self.calculatorModel.moveSubject(from: source, to: destination)
    }
    
    public func getSubjects() -> Array<Subject> {
        return self.calculatorModel.subjects
    }
    
    public func getSubject(targetSubject: Subject) -> Subject? {
        var result: Subject?
        for subject in self.calculatorModel.subjects {
            if (targetSubject == subject) {
                result = subject
            }
        }
        return result
    }
    
    public func addItemForSubject(targetSubject: Subject, name: String, points: Double, fullPoints: Double, weight: Double) {
        calculatorModel.addItemForSubject(targetSubject: targetSubject, name: name, points: points, fullPoints: fullPoints, weight: weight)
        let targetItems = getSubject(targetSubject: targetSubject)?.items
        if (targetItems != nil) {
            NotificationCenter.default.post(name: GeneralViewModel.addItemListNotificationName, object: nil, userInfo: [GeneralViewModel.newItemRowKey: getSubject(targetSubject: targetSubject)!.items.count - 1])
        }
    }
    
    public func modifyItemForSubject(targetSubject: Subject, item: Item) {
        calculatorModel.modifyItemForSubject(targetSubject: targetSubject, item: item)
        let targetItems = getSubject(targetSubject: targetSubject)?.items
        var rowIndex = 0
        if (targetItems != nil) {
            for index in 0..<targetItems!.count {
                if item == targetItems![index] {
                    rowIndex = index
                    break
                }
            }
        }
        if (targetItems != nil) {
            NotificationCenter.default.post(name: GeneralViewModel.modifyItemListNotificationName, object: nil, userInfo: [GeneralViewModel.modifyItemRowKey: rowIndex])
        }
    }
    
    public func removeItemsForSubject(targetSubject: Subject, at spots: [Int]) {
        calculatorModel.removeItemsForSubject(targetSubject: targetSubject, at: spots)
    }
    
    public func removeItemsForSubject(targetSubject: Subject, at spots: [Bool]) {
        calculatorModel.removeItemsForSubject(targetSubject: targetSubject, at: spots)
        NotificationCenter.default.post(name: GeneralViewModel.deleteMultiItemsListNotificationName, object: nil, userInfo: [GeneralViewModel.deleteMultiItemsRowsKey: spots])
    }
    
    public func moveItemForSubject(targetSubject: Subject, from source: Int, to destination: Int) {
        calculatorModel.moveItemForSubject(targetSubject: targetSubject, from: source, to: destination)
    }
    // MARK - Term Model interface
    public func getTerms() -> Array<Term> {
        return termModel.terms
    }
    
    public func getTerm(targetTerm: Term) -> Term? {
        var result: Term?
        for term in self.termModel.terms {
            if (targetTerm == term) {
                result = term
                break
            }
        }
        return result
    }
    
    public func addTerm(title: String) {
        termModel.addTerm(title: title, subjects: nil)
        NotificationCenter.default.post(name: GeneralViewModel.addTermListNotificationName, object: nil, userInfo: [GeneralViewModel.addTermRowKey: termModel.terms.count - 1])
    }
    
    public func removeTerms(at spots: [Bool]) {
        termModel.removeTerms(at: spots)
        NotificationCenter.default.post(name: GeneralViewModel.deleteMultiTermsListNotificationName, object: nil, userInfo: [GeneralViewModel.deleteMultiTermsRowsKey: spots])
    }
    
    public func moveTerm(from source: Int, to destination: Int) {
        termModel.moveTerm(from: source, to: destination)
    }
    
    public func addSubjectsForTerm(targetTerm: Term, subjects: [Subject]) {
        termModel.addSubjectsForTerm(targetTerm: targetTerm, subjects: subjects)
        NotificationCenter.default.post(name: GeneralViewModel.addItemForTermNotificationName, object: nil, userInfo: [GeneralViewModel.addItemForTermRow: targetTerm])
    }
    
    // MARK - History Model Interface
    public func addHistoryRecord(subject: Subject) {
        self.historyModel.addRecord(subject: subject)
        NotificationCenter.default.post(name: GeneralViewModel.addRecordNotificationName, object: nil, userInfo: [GeneralViewModel.addRecordRowKey: historyModel.records.count - 1])
    }
    
    public func getRecords() -> Array<HistoryItem> {
        return self.historyModel.records
    }
    
    public func moveRecord(from source: Int, to destination: Int) {
        historyModel.moveRecord(from: source, to: destination)
    }
    
    public func removeRecords(at spots: [Bool]) {
        historyModel.removeRecords(at: spots)
        NotificationCenter.default.post(name: GeneralViewModel.deleteMultiRecordsNotificationName, object: nil, userInfo: [GeneralViewModel.deleteMultiRecordsRows: spots])
    }
    
    // MARK - Setting Model Interface
    
    public func getWarningColor() -> UIColor {
        return settingModel.warningColor
    }
    
    public func getRemainderColor() -> UIColor {
        return settingModel.remainderColor
    }
    
    public func getOkColor() -> UIColor {
        return settingModel.okColor
    }
}
