//
//  TermListVC.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-09-20.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import UIKit

class TermListVC: MultiSelectAndMoveTableViewController {
    private let numOfSection = 1
    private var viewModel: GeneralViewModel
    private var terms: Array<Term> {
        get {
            viewModel.getTerms()
        }
    }
    
    private static let cellIdentifier = "CellListCell"
    
    private let pageTitle = NSLocalizedString("PAGE_TITLE_TERMS", comment: "")
    private let alertTitle = NSLocalizedString("ALERT_TITLE_NEW_TERM", comment: "")
    private let saveButtonText = NSLocalizedString("BUTTON_TEXT_SAVE", comment: "")
    private let cancelButtonText = NSLocalizedString("BUTTON_TEXT_CANCEL", comment: "")
    
    private let defaultSubjectName = NSLocalizedString("TEXT_FIELD_LABEL_UNKNOWN", comment: "")
    
    private lazy var plusButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonSelector))
    }()
    
    private lazy var alertController: UIAlertController = {
        let alert = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (textField) in
            self.nameTextField = textField
        })
        alert.addAction(UIAlertAction(title: saveButtonText, style: .default, handler: { (action) in
            self.saveButtonAction()
            self.nameTextField.text = ""
        }))
        alert.addAction(UIAlertAction(title: cancelButtonText, style: .cancel, handler: { (action) in
            self.nameTextField.text = ""
        }))
        return alert
    }()
    
    private var nameTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        configureTableView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    init(viewModel: GeneralViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.addNotificationObserver()
    }
    
    deinit {
        removeNotificationObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(addItemSelector), name: GeneralViewModel.addTermListNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeItemsSelector), name: GeneralViewModel.deleteMultiTermsListNotificationName, object: nil)
    }
    
    private func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setNavBar() {
        navigationItem.title = pageTitle
        navigationItem.rightBarButtonItem = plusButton
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    private func configureTableView() {
//        view.addSubview(self.tableView)
        // set delegates
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //set row height
        self.tableView.rowHeight = 48
        //register cells
        self.tableView.register(TermListCell.self, forCellReuseIdentifier: TermListVC.cellIdentifier)
        //set constraints
//        tableView.free()
        self.tableView.allowsMultipleSelectionDuringEditing = true
//        self.tableView.pin(to: self.view)
    }
    
    // MARK - selectors and actions
    private func saveButtonAction() {
        let termTitle = nameTextField.text! != "" ? nameTextField.text! : defaultSubjectName
        print(termTitle)
        viewModel.addTerm(title: termTitle)
    }
    
    @objc private func addButtonSelector() {
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func addItemSelector(notification: NSNotification) {
        let rowIndex = notification.userInfo?[GeneralViewModel.addTermRowKey] as! Int
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: rowIndex, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
    
    @objc private func removeItemsSelector(notification: NSNotification) {
        let rowIndex = notification.userInfo?[GeneralViewModel.deleteMultiTermsRowsKey] as! [Bool]
        var removeRows:[IndexPath] = []
        for index in 0..<rowIndex.count {
            if rowIndex[index] == true {
                removeRows.append(IndexPath(row: index, section: 0))
            }
        }
        tableView.beginUpdates()
        tableView.deleteRows(at: removeRows, with: .automatic)
        tableView.endUpdates()
    }
    
    @objc override func deleteButtonSelector() {
        viewModel.removeTerms(at: selectedIndex)
        super.deleteButtonSelector()
    }
    
    override func getDataLength() -> Int {
        return terms.count
    }
}


extension TermListVC {
    // MARK: - Table view data source
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        navigationItem.rightBarButtonItem = tableView.isEditing ? trashButton : plusButton
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return numOfSection
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return terms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TermListVC.cellIdentifier) as! TermListCell
        let term = terms[indexPath.row]
        cell.setTerm(viewModel: viewModel, term: term)
        print(term.title)
        return cell
//        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        if !tableView.isEditing {
            let termSummaryVC = TermSummaryVC(viewModel: viewModel, initTerm: terms[indexPath.row])
            self.navigationController?.pushViewController(termSummaryVC, animated: true)
            self.tableView.deselectRow(at: indexPath, animated: true)
            print("push the view")
            print(viewModel.getTerms()[indexPath.row].subjects.map({ $0.title }))
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        super.tableView(tableView, moveRowAt: sourceIndexPath, to: destinationIndexPath)
        viewModel.moveTerm(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
}
