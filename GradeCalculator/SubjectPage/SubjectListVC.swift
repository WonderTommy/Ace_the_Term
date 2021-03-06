//
//  FirstVC.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-08-30.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import UIKit

protocol SubjectListDelegate {
    func addItemForSubject(name: String, points: Double, fullPoints: Double, weight: Double)
    func modifyItemForSubject(id: Int, name: String, points: Double, fullPoints: Double, weight: Double)
}

class SubjectListVC: MultiSelectAndMoveTableViewController {
//    private var tableView = UITableView()
//    private var calculatorModel: CalculatorModel!// = CalculatorModel()
    private var numOfSections: Int = 1
    private var viewModel: GeneralViewModel
    private var subjects: Array<Subject> {
        get {
            return viewModel.getSubjects()
        }
    }
    
    private let navigationBarTitle = NSLocalizedString("PAGE_TITLE_SUBJECTS", comment: "")
    private static let cellIdentifier = "SubjectListCell"
    
    private let saveButtonText = NSLocalizedString("BUTTON_TEXT_SAVE", comment: "")
    private let cancelButtonText = NSLocalizedString("BUTTON_TEXT_CANCEL", comment: "")
    private let editButtonText = NSLocalizedString("BUTTON_TEXT_EDIT", comment: "")
    private let doneButtonText = NSLocalizedString("BUTTON_TEXT_DONE", comment: "")
    
    private let defaultSubjectName = NSLocalizedString("TEXT_FIELD_LABEL_UNKNOWN", comment: "")
    
    private let segmentTitleText = NSLocalizedString("SEGMENT_TITLE_CHOOSE_FOLDER", comment: "")
    
//    private lazy var selectedIndex: [Bool] = {
//        var temp: [Bool] = []
//        for _ in self.subjects {
//            temp.append(false)
//        }
//        return temp
//    }()
    
    private let newSubjectAlertTitle = NSLocalizedString("ALERT_TITLE_NEW_SUBJECT", comment: "")
    private let selectSubjectAlertMessage = NSLocalizedString("ALERT_MESSAGE_SELECT_AT_LEAST_ONE_SUBJECT", comment: "")
    private let selectTermAlertMessage = NSLocalizedString("ALERT_MESSAGE_SELECT_AT_LEAST_ONE_FOLDER", comment: "")
    private let alertButtonTextOK = NSLocalizedString("ALERT_BUTTON_OK", comment: "")
    
    private lazy var newSubjectAlertController: UIAlertController = {
        let alert = UIAlertController(title: newSubjectAlertTitle, message: nil, preferredStyle: .alert)
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
    
    private lazy var selectSubjectAlertController: UIAlertController = {
        let alert = UIAlertController(title: nil, message: selectSubjectAlertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: alertButtonTextOK, style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        return alert
    }()
    
    private lazy var selectTermAlertController: UIAlertController = {
        let alert = UIAlertController(title: nil, message: selectTermAlertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: alertButtonTextOK, style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        return alert
    }()
    
    private lazy var plusButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonSelector))
    }()
    
//    private lazy var deleteButton: UIBarButtonItem = {
//        return UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(presentDeleteAlert))
//    }()
    
    private lazy var folderButton: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: "folder"), style: .plain, target: self, action: #selector(folderButtonSelector))
    }()
    
    private var nameTextField =  UITextField()
    
    private lazy var segmentTitle: UILabel = {
        let label = UILabel()
        label.text = segmentTitleText
        return label
    }()
    
    private lazy var termListSegment: TermListSegment = {
        return TermListSegment(frame: CGRect(x: 0, y: 0, width: 1000, height: 200), style: .plain, viewModel: self.viewModel)
    }()
    
    private lazy var segmentCancelButton: UIButton = {
        let button = UIButton()
        button.setTitle(cancelButtonText, for: .normal)
        button.backgroundColor = UIColor.systemRed
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(segmentCancelButtonSelector), for: .touchUpInside)
        return button
    }()
    
    private lazy var segmentSaveButton: UIButton = {
        let button = UIButton()
        button.setTitle(saveButtonText, for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(segmentSaveButtonSelector), for: .touchUpInside)
        return button
    }()
    
    private lazy var bottomMenuLauncher: BottomMenu = {
        let contentView = UIStackView()
        contentView.axis = .vertical
        contentView.distribution = .equalCentering
        contentView.alignment = .center
        contentView.spacing = 8
        
        contentView.addArrangedSubview(segmentTitle)
        segmentTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32).isActive = true
        
        contentView.addArrangedSubview(termListSegment)
        termListSegment.configCell()
        termListSegment.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        termListSegment.heightAnchor.constraint(equalToConstant: 200).isActive = true
        termListSegment.setEditing(true, animated: false)
        
        contentView.addArrangedSubview(segmentCancelButton)
        segmentCancelButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9).isActive = true
        segmentCancelButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        contentView.addArrangedSubview(segmentSaveButton)
        segmentSaveButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9).isActive = true
        segmentSaveButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        let bottomMenu = BottomMenu(content: contentView, menuHeight: 400, paddingTop: 16, paddingBottom: -36, paddingLeft: 0, paddingRight: 0, dismissOnClickOff: true)
        bottomMenu.setDelegate(delegate: self)
        return bottomMenu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        configureTableView()
//        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|", options: [], metrics: nil, views: Dictionary(dictionaryLiteral: ("tableView", self.tableView)))
//        view.addConstraint(constraints[0])
//        constraints.append(
//            NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tableView]-0-|", options: [], metrics: nil, views: Dictionary(dictionaryLiteral: ("tableView", self.tableView)))[0])
//        view.addConstraints(constraints)
        // Do any additional setup after loading the view.
    }
    
    // MARK - init
    init(viewModel: GeneralViewModel) {
//        self.calculatorModel = calculatorModel
        self.viewModel = viewModel
//        self.subjects = viewModel.getSubjects()
        super.init(nibName: nil, bundle: nil)
        self.addNotificationObserver()
    }
    
    deinit {
        removeNotificationObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setNavBar() {
        self.navigationItem.title = self.navigationBarTitle
//        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonSelector(_:)))
//        let editButton = UIBarButtonItem(title: editButtonText, style: .plain, target: self, action: #selector(editButtonSelector(_:)))
        self.navigationItem.rightBarButtonItem = tableView.isEditing ? trashButton : plusButton
        self.navigationItem.leftBarButtonItem = editButtonItem
    }
    
    private func configureTableView() {
//        view.addSubview(self.tableView)
        // set delegates
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
        //set row height
        self.tableView.rowHeight = 48
        //register cells
        self.tableView.register(SubjectListCell.self, forCellReuseIdentifier: SubjectListVC.cellIdentifier)
        //set constraints
//        tableView.free()
        self.tableView.allowsMultipleSelectionDuringEditing = true
//        self.tableView.pin(to: self.view)
    }
    
    private func addNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(addSubjectSelector(notification:)), name: GeneralViewModel.addSubjectListNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeSubjectSelector(notification:)), name: GeneralViewModel.deleteSubjectListNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeMultiSubjectsSelector(notification:)), name: GeneralViewModel.deleteMultiSelectsListNotificationName, object: nil)
    }
    
    private func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK - button actions
    @objc private func addButtonSelector() {
        present(newSubjectAlertController, animated: true, completion: nil)
    }
    
//    @objc private func editButtonSelector(_ sender: UIBarButtonItem) {
//        tableView.setEditing(!tableView.isEditing, animated: true)
//        sender.title = tableView.isEditing ? doneButtonText : editButtonText
//    }
    @objc override func deleteButtonSelector() {
        viewModel.removeSubjects(at: selectedIndex)
        super.deleteButtonSelector()
    }
    
    
    @objc private func folderButtonSelector() {
        print("click button clicked")
//        present(UINavigationController(rootViewController: TermListVC(viewModel: viewModel)), animated: true, completion: nil)
        if anyRowSelected() {
            bottomMenuLauncher.showBottomMenu()
        } else {
            present(selectSubjectAlertController, animated: true, completion: nil)
        }
    }
    
    @objc private func segmentSaveButtonSelector() {
        if termListSegment.anyRowSelected() {
            let subjects = viewModel.getSubjects()
            var selectedSubjects: [Subject] = []
            for index in 0..<selectedIndex.count {
                if selectedIndex[index] == true {
                    selectedSubjects.append(subjects[index])
                }
            }
            
            let selectedTermIndex = termListSegment.getSelectedIndex()
            let terms = viewModel.getTerms()
            for index in selectedTermIndex {
                viewModel.addSubjectsForTerm(targetTerm: terms[index], subjects: selectedSubjects)
            }
            bottomMenuLauncher.dismissBottomMenu()
            setEditing(false, animated: true)
        } else {
            present(selectTermAlertController, animated: true, completion: nil)
        }
    }
    
    @objc private func segmentCancelButtonSelector() {
        bottomMenuLauncher.dismissBottomMenu()
        setEditing(false, animated: true)
    }
    
    private func saveButtonAction() {
        let subjectTitle = nameTextField.text! != "" ? nameTextField.text! : defaultSubjectName
        viewModel.addSubject(title: subjectTitle, items: nil)
        print(viewModel.getSubjects().map({$0.title}))
    }
    
    @objc private func addSubjectSelector(notification: NSNotification) {
//        tableView.reloadData()
        let rowIndex = notification.userInfo?[GeneralViewModel.newSubjectRowKey] as! Int
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: rowIndex, section: 0)], with: .automatic)
        tableView.endUpdates()
        print(notification.name)
    }
    
    @objc private func removeSubjectSelector(notification: NSNotification) {
        tableView.beginUpdates()
        let rowIndex = notification.userInfo?[GeneralViewModel.deleteSubjectRowKey] as! Int
        tableView.deleteRows(at: [IndexPath(row: rowIndex, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
    
    @objc private func removeMultiSubjectsSelector(notification: NSNotification) {
        tableView.beginUpdates()
        var removeRows: [IndexPath] = []
        let deleteIndicators = notification.userInfo?[GeneralViewModel.deleteMultiSubjectsRowsKey] as! [Bool]
        for index in 0..<deleteIndicators.count {
            if (deleteIndicators[index] == true) {
                removeRows.append(IndexPath(row: index, section: 0))
            }
        }
        tableView.deleteRows(at: removeRows, with: .automatic)
        print("reload")
        tableView.endUpdates()
    }
    
    override func getDataLength() -> Int {
        return subjects.count
    }
}

extension SubjectListVC: BottomMenuDelegate {
    func dismissAction() {
        termListSegment.clearSelectedIndex()
        setEditing(false, animated: true)
    }
}

extension SubjectListVC {
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
//        tableView.setEditing(editing, animated: animated)
        navigationItem.rightBarButtonItems = tableView.isEditing ? [trashButton, folderButton] : [plusButton]
    }
//    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        print("didEndDisplaying\(indexPath.row)")
//    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return numOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SubjectListVC.cellIdentifier) as! SubjectListCell
        let subject = subjects[indexPath.row]
        cell.setSubject(subject: subject)
        print(subject.title)
        return cell
//        return UITableViewCell()
    }
    
    // the onclick of cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        if !tableView.isEditing {
            let itemVC = ItemListVC(viewModel: viewModel, subject: subjects[indexPath.row])
            self.navigationController?.pushViewController(itemVC, animated: true)
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            viewModel.removeSubject(at: indexPath.row)
////            tableView.beginUpdates()
//////            let rowIndex = notification.userInfo?[GeneralViewModel.deleteSubjectRowKey] as! Int
////            tableView.deleteRows(at: [indexPath], with: .automatic)
////            tableView.endUpdates()
//        }
//    }
    
//    func tableView(_ tableView: UITableView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
//    func tableView(_ tableView: UITableView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath) {
//        tableView.setEditing(true, animated: true)
//    }
    
//    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        print("delect: \(indexPath.row)")
////        selectedIndex.removeAll(where: { $0 == indexPath.row })
//        selectedIndex[indexPath.row] = false
//        print(selectedIndex)
//    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        super.tableView(tableView, moveRowAt: sourceIndexPath, to: destinationIndexPath)
        viewModel.moveSubject(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
//    func tableViewDidEndMultipleSelectionInteraction(_ tableView: UITableView) {
//        print("\(#function)")
//    }
}
