//
//  ItemVC.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-08-31.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import UIKit

protocol ItemListDelegate {
    func addItemForSubject(name: String, points: Double, fullPoints: Double, weight: Double)
    func modifyItemForSubject(id: Int, name: String, points: Double, fullPoints: Double, weight: Double)
}

class ItemListVC: UIViewController {
    private var viewModel: GeneralViewModel
    private var initSubject: Subject!
    private var subject: Subject {
        return viewModel.getSubject(targetSubject: initSubject) ?? initSubject
    }
    
    private var tableView = UITableView()
    
    private let calculationButtonLabel = NSLocalizedString("BUTTON_TEXT_CALCULATE", comment: "")
    private static let cellIdentifier = "ItemListCell";
    
    private lazy var selectedIndex: [Bool] = {
        var temp: [Bool] = []
        for _ in subject.items {
            temp.append(false)
        }
        return temp
    }()
    
    private lazy var calculationButton: UIBarButtonItem = {
        return UIBarButtonItem(title: calculationButtonLabel, style: .plain, target: self, action: #selector(calculationButtonSelector))
    }()
    
    private lazy var plusButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonSelector))
    }()
    
    private lazy var deleteButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonSelector))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavBar()
        configureTableView()
        addNotificationObserver()
    }
    
    // MARK - Initializers
    init(viewModel: GeneralViewModel, subject: Subject) {
        self.viewModel = viewModel
        self.initSubject = subject
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeNotificationObserver()
    }
    
    private func setNavBar() {
//        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.title = self.subject.title
        self.navigationItem.rightBarButtonItems = tableView.isEditing ? [editButtonItem, deleteButton] : [plusButton, editButtonItem, calculationButton]
    }
    
    private func configureTableView() {
        view.addSubview(self.tableView)
        // set delegates
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //set row height
        self.tableView.rowHeight = 112
        //register cells
        self.tableView.register(ItemListCell.self, forCellReuseIdentifier: ItemListVC.cellIdentifier)
        //set constraints
//        tableView.free()
        self.tableView.allowsMultipleSelectionDuringEditing = true
        self.tableView.pin(to: self.view)
    }
    
    private func addNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(addItemSelector(notification:)), name: GeneralViewModel.addItemListNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(modifyItemSelector(notification:)), name: GeneralViewModel.modifyItemListNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeMultiItemsSelector(notification:)), name: GeneralViewModel.deleteMultiItemsListNotificationName, object: nil)
    }
    
    private func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK - selectors
    @objc private func calculationButtonSelector() {
        print("calculation button clicked")
    }
    
    @objc private func addButtonSelector() {
        print("add button clicked")
        let addItemNavController = UINavigationController(rootViewController: ItemDetailVC(mode: ItemDetailMode.New, item: nil, delegate: self))
        self.present(addItemNavController, animated: true, completion: nil)
    }
    
    @objc private func deleteButtonSelector() {
        print("trash icon clicked")
        print(selectedIndex)
        viewModel.removeItemsForSubject(targetSubject: initSubject, at: selectedIndex)
        
        let originLength = selectedIndex.count
        for rawIndex in 0..<originLength {
            let index = originLength - 1 - rawIndex
            if (selectedIndex[index] == true) {
                selectedIndex.remove(at: index)
            }
        }
    }
    
    @objc private func addItemSelector(notification: NSNotification) {
        let rowIndex = notification.userInfo?[GeneralViewModel.newItemRowKey] as! Int
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: rowIndex, section: 0)], with: .automatic)
        tableView.endUpdates()
//        print("triggered")
    }
    
    @objc private func modifyItemSelector(notification: NSNotification) {
        let rowIndex = notification.userInfo?[GeneralViewModel.modifyItemRowKey] as! Int
        tableView.reloadRows(at: [IndexPath(row: rowIndex, section: 0)], with: .fade)
    }
    
    @objc private func removeMultiItemsSelector(notification: NSNotification) {
        tableView.beginUpdates()
        var removeRows: [IndexPath] = []
        let deleteIndicators = notification.userInfo?[GeneralViewModel.deleteMultiItemsRowsKey] as! [Bool]
        print("deleteIndicators: ", deleteIndicators)
        print("left count: ", subject.items.count)
        for index in 0..<deleteIndicators.count {
            if (deleteIndicators[index] == true) {
                removeRows.append(IndexPath(row: index, section: 0))
            }
        }
        tableView.deleteRows(at: removeRows, with: .automatic)
        print("reload")
        tableView.endUpdates()
    }
    
}

extension ItemListVC: UITableViewDelegate, UITableViewDataSource {
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
        self.navigationItem.rightBarButtonItems = tableView.isEditing ? [editButtonItem] : [plusButton, editButtonItem, calculationButton]
        self.navigationItem.hidesBackButton = tableView.isEditing
        self.navigationItem.leftBarButtonItem = tableView.isEditing ? deleteButton : nil
        
        if !isEditing {
            for index in 0..<selectedIndex.count {
                selectedIndex[index] = false
            }
        } else {
            if selectedIndex.count < subject.items.count {
                for _ in 0..<subject.items.count - selectedIndex.count {
                    selectedIndex.append(false)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subject.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemListVC.cellIdentifier) as! ItemListCell
        let item = self.subject.items[indexPath.row]
        cell.setItem(item: item)
        print(item.name)
        return cell
//        return UITableViewCell()
    }
    
    // the onclick of cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("index: ", indexPath.row)
        if (tableView.isEditing) {
//            if (!selectedIndex.contains(indexPath.row)) {
//                selectedIndex.append(indexPath.row)
//            }
            selectedIndex[indexPath.row] = true
            print(selectedIndex)
            return
        }
//        let itemVC = ItemListVC(subject: calculatorModel.subjects[indexPath.row])
//        self.navigationController?.pushViewController(itemVC, animated: true)
        let itemDetailVC = ItemDetailVC(mode: .Modify, item: subject.items[indexPath.row], delegate: self)
        self.navigationController?.pushViewController(itemDetailVC, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("delect: \(indexPath.row)")
//        selectedIndex.removeAll(where: { $0 == indexPath.row })
        selectedIndex[indexPath.row] = false
        print(selectedIndex)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        viewModel.moveItemForSubject(targetSubject: initSubject, from: sourceIndexPath.row, to: destinationIndexPath.row)
        
        let tempSource = selectedIndex[sourceIndexPath.row]
        selectedIndex.remove(at: sourceIndexPath.row)
        selectedIndex.insert(tempSource, at: destinationIndexPath.row)
        print(selectedIndex)
    }
}

extension ItemListVC: ItemListDelegate {
    func addItemForSubject(name: String, points: Double, fullPoints: Double, weight: Double) {
        print("name: \(name)")
        print("points: \(points)")
        print("fullPoints: \(fullPoints)")
        print("weight: \(weight)")
        viewModel.addItemForSubject(targetSubject: initSubject, name: name, points: points, fullPoints: fullPoints, weight: weight)
        print(viewModel.getSubjects()[0].items)
    }
    func modifyItemForSubject(id: Int, name: String, points: Double, fullPoints: Double, weight: Double) {
        print("id: \(id)")
        print("name: \(name)")
        print("points: \(points)")
        print("fullPoints: \(fullPoints)")
        print("weight: \(weight)")
        viewModel.modifyItemForSubject(targetSubject: initSubject, item: Item(id: id, name: name, points: points, fullPoints: fullPoints, weight: weight))
        print(viewModel.getSubjects()[0].items)
    }
}

