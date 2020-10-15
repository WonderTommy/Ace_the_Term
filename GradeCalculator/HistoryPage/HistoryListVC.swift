//
//  HistoryListVC.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-10-06.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import UIKit

class HistoryListVC: MultiSelectAndMoveTableViewController {
    
    private static let cellIdentifier = "HistoryListCellIdentifier"
    private var viewModel: GeneralViewModel
    private var records: Array<HistoryItem> {
        get {
            return viewModel.getRecords().reversed()
        }
    }
    
    private let navigationTitle = NSLocalizedString("PAGE_TITLE_HISTORY", comment: "")
    
//    lazy var trashButton: UIBarButtonItem = {
//        return UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(presentDeleteAlert))
//    }()

    init(viewModel: GeneralViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        addNotificationObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeNotificationObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        configureTableView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func setNavBar() {
        navigationItem.title = navigationTitle
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    private func addNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(addRecordSelector(notification:)), name: GeneralViewModel.addRecordNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteRecordsSelector(notification:)), name: GeneralViewModel.deleteMultiRecordsNotificationName, object: nil)
    }
    
    public func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 96
        self.tableView.register(HistoryListCell.self, forCellReuseIdentifier: HistoryListVC.cellIdentifier)
        self.tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    override func getDataLength() -> Int {
        return records.count
    }
    
    // MARK - selectors
    @objc private func addRecordSelector(notification: NSNotification) {
        tableView.beginUpdates()
        let rowIndex = notification.userInfo?[GeneralViewModel.addRecordRowKey] as! Int
        print("addRecord", rowIndex)
//        tableView.insertRows(at: [IndexPath(row: rowIndex, section: 0)], with: .automatic)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
    
    @objc private func deleteRecordsSelector(notification: NSNotification) {
        let rowIndex = notification.userInfo?[GeneralViewModel.deleteMultiRecordsRows] as! [Bool]
        let length = rowIndex.count
        var removeIndex: [IndexPath] = []
        for index in 0..<length {
            if rowIndex[index] == true {
                removeIndex.append(IndexPath(row: index, section: 0))
            }
        }
        tableView.beginUpdates()
        tableView.deleteRows(at: removeIndex, with: .automatic)
        tableView.endUpdates()
    }
    
    @objc override func deleteButtonSelector() {
        viewModel.removeRecords(at: selectedIndex)
        super.deleteButtonSelector()
    }
}

extension HistoryListVC {
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        navigationItem.rightBarButtonItem = isEditing ? trashButton : nil
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return records.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("load row at ", indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryListVC.cellIdentifier) as! HistoryListCell
        let record = records[indexPath.row]
        cell.setRecord(viewModel: viewModel, record: record)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        if !isEditing {
            print("push history item VC")
            navigationController?.pushViewController(HistoryDetailVC(viewModel: viewModel, record: records[indexPath.row]), animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        super.tableView(tableView, moveRowAt: sourceIndexPath, to: destinationIndexPath)
        viewModel.moveRecord(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
}
