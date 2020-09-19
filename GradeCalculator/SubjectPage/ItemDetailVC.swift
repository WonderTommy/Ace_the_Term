//
//  AddItemVC.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-09-07.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import UIKit

enum ItemDetailMode {
    case New
    case Modify
}

class ItemDetailCellModel {
    var identifier: String
    var hintText: String
    var keyBoardType: UIKeyboardType
    var text: String?
    init(identifier: String, hintText: String, keyBoardType: UIKeyboardType, text: String?) {
        self.identifier = identifier
        self.hintText = hintText
        self.keyBoardType = keyBoardType
        self.text = text
    }
//    convenience init(identifier: String, hintText: String, keyBoardType: UIKeyboardType, text: String) {
//        self.init(identifier: identifier, hintText: hintText, keyBoardType: keyBoardType)
//        self.text = text
//    }
    
    public func getValueByDouble() -> Double {
        return Double(self.text ?? "") ?? 0.0
    }
}

class ItemDetailVC: UITableViewController {
    private var mode: ItemDetailMode
    private var delegate: ItemListDelegate
    private var item: Item?
    
//    let form = For
    private let newItemNavBarTitle = NSLocalizedString("PAGE_TITLE_ADD_ITEM", comment: "")
    private let saveButtonText = NSLocalizedString("BUTTON_TEXT_SAVE", comment: "")
    private let cancelButtonText = NSLocalizedString("BUTTON_TEXT_CANCEL", comment: "")
    
    private let fieldNameHint = NSLocalizedString("TEXT_FIELD_HINT_NAME", comment: "")
    private let fieldPointHint = NSLocalizedString("TEXT_FIELD_HINT_POINTS", comment: "")
    private let fieldFullPointHint = NSLocalizedString("TEXT_FIELD_HINT_FULL_POINTS", comment: "")
    private let fieldWeightHint = NSLocalizedString("TEXT_FIELD_HINT_WEIGHT", comment: "")
    
    private let defaultItemName = NSLocalizedString("TEXT_FIELD_LABEL_UNKNOWN", comment: "")
    
//    private let tableHeaderHeight: CGFloat = 50
    
    private static let cellIdentifierPrefix = "inputCell"
    private let cellModel: [ItemDetailCellModel]
    
    private lazy var saveButton: UIBarButtonItem = {
        return UIBarButtonItem(title: saveButtonText, style: .done, target: self, action: #selector(saveButtonAction))
    }()
    
    private lazy var cancelButton: UIBarButtonItem = {
        return UIBarButtonItem(title: cancelButtonText, style: .plain, target: self, action: #selector(cancelButtonAction))
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.contentInset = UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .white
        setNavBar()
        configureTableView()
    }
    
    init(mode: ItemDetailMode, item: Item?, delegate: ItemListDelegate) {
        self.mode = mode
        cellModel = [
            ItemDetailCellModel(identifier: "\(ItemDetailVC.cellIdentifierPrefix)0", hintText: fieldNameHint, keyBoardType: .default, text: item?.name),
            ItemDetailCellModel(identifier: "\(ItemDetailVC.cellIdentifierPrefix)1", hintText: fieldPointHint, keyBoardType: .decimalPad, text: (item != nil) ? String(item!.points) : ""),
            ItemDetailCellModel(identifier: "\(ItemDetailVC.cellIdentifierPrefix)2", hintText: fieldFullPointHint, keyBoardType: .decimalPad, text: (item != nil) ? String(item!.fullPoints) : ""),
            ItemDetailCellModel(identifier: "\(ItemDetailVC.cellIdentifierPrefix)3", hintText: fieldWeightHint, keyBoardType: .decimalPad, text: (item != nil) ? String(item!.weight) : "")
        ]
        self.item = item
        self.delegate = delegate
//        super.init(nibName: nil, bundle: nil)
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setNavBar() {
        switch self.mode {
        case .New:
//            self.title = self.newItemNavBarTitle
            navigationItem.title = self.newItemNavBarTitle
            navigationItem.rightBarButtonItem = saveButton
            navigationItem.leftBarButtonItem = cancelButton
            break;
        case.Modify:
//            self.title = self.newItemNavBarTitle
            navigationItem.rightBarButtonItem = saveButton
            break;
        }
    }
    
    private func configureTableView() {
        tableView.rowHeight = 40
        for identifier in cellModel.map({ $0.identifier }) {
            tableView.register(ItemDetailCell.self, forCellReuseIdentifier: identifier)
        }
        tableView.bounces = false
//        tableView.scrollsToTop = true
//        tableView.isScrollEnabled = false
//        tableView.isScrollEnabled = false
        
//        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.tableHeaderHeight))
//        headerView.backgroundColor = .systemGray5
//        tableView.tableHeaderView = headerView
//
//        tableView.tableFooterView = UIView()
//        let frame = tableView.tableFooterView?.frame
//        let footerHeight = tableView.frame.height - tableView.contentSize.height - 85
//        let footerNewFrame = CGRect(x: frame!.origin.x, y: frame!.origin.x, width: frame!.width, height: footerHeight)
//        let footerView = UIView(frame: footerNewFrame)
//        footerView.backgroundColor = .systemGray5
//        tableView.tableFooterView = footerView
        
        
        
//        tableView.tableFooterView?.backgroundColor = .red
//        let views = Dictionary(dictionaryLiteral: ("table", self.tableView))
//        let tableConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[table]|", options: [], metrics: nil, views: views as [String : Any])
//        self.view.addConstraints(tableConstraint)
    }
    
    @objc private func saveButtonAction() {
        print("save button clicked")
        for model in cellModel {
            print("text: \(model.text ?? "")")
        }
        switch (self.mode) {
        case .New:
            self.delegate.addItemForSubject(name: cellModel[0].text ?? defaultItemName, points: cellModel[1].getValueByDouble(), fullPoints: cellModel[2].getValueByDouble(), weight: cellModel[3].getValueByDouble())
            self.dismiss(animated: true, completion: nil)
            break
        case.Modify:
            self.delegate.modifyItemForSubject(id: self.item!.id, name: cellModel[0].text ?? defaultItemName, points: cellModel[1].getValueByDouble(), fullPoints: cellModel[2].getValueByDouble(), weight: cellModel[3].getValueByDouble())
            self.navigationController?.popViewController(animated: true)
            break
        }
    }
    
    @objc private func cancelButtonAction() {
        print("cancel button clicked")
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK - TableView methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel[indexPath.row].identifier, for: indexPath) as! ItemDetailCell
        cell.configureTextField(model: cellModel[indexPath.row])
        return cell
        //        return UITableViewCell()
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = UIView()
//        header.backgroundColor = .systemGray5
//        return header
//    }
}



class ItemDetailCell: UITableViewCell, UITextFieldDelegate {
    private var cellModel: ItemDetailCellModel? {
        didSet {
            inputField.placeholder = cellModel?.hintText
            inputField.keyboardType = cellModel?.keyBoardType as! UIKeyboardType
            inputField.text = cellModel?.text ?? ""
        }
    }
    private var inputField: UITextField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureTextField(model: ItemDetailCellModel) {
        inputField.delegate = self
        cellModel = model
        
        addSubViews()
        configureCellLayout()
    }
    
    private func addSubViews() {
        addSubview(self.inputField)
    }
    
    private func configureCellLayout() {
        self.inputField.free()
        let views = Dictionary(dictionaryLiteral: ("input", self.inputField))
        let horizontalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[input]-|", options: [], metrics: nil, views: views)
        let verticalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|[input]|", options: [], metrics: nil, views: views)
        self.addConstraints(horizontalConstraint)
        self.addConstraints(verticalConstraint)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        cellModel?.text = text ?? ""
//        print("\(text ?? "")")
        return true
    }
}
