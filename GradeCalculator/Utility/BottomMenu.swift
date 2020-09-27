//
//  ShowBottomMenu.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-09-26.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import UIKit

class BottomMenu: NSObject {
    private var viewModel: GeneralViewModel
    private var terms: Array<Term> {
        get {
            return viewModel.getTerms()
        }
    }
//    private var content: UIView
//    private var paddingTop: Int
//    private var paddingBottom: Int
//    private var paddingLeft: Int
//    private var paddingRight: Int
    
    let blackView = UIView()
    
//    let collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.backgroundColor = UIColor.white
//        return cv
//    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        button.width
        button.backgroundColor = UIColor.red
    
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("save", for: .normal)
//        button.width
        button.backgroundColor = UIColor.systemPink
        button.layer.cornerRadius = 4
        return button
    }()
    
    private let segmentTitle: UILabel = {
        let label = UILabel()
        label.text = "Choose a folder"
        return label
    }()
    
    private lazy var listView: TermListSegment = {
//        let termListVC = TermListVC(viewModel: viewModel)
        let tableView = TermListSegment(frame: CGRect(x: 0, y: 0, width: 1000, height: 200), style: .plain, viewModel: self.viewModel) //termListVC.tableView!
        
//        let tableView = UITableView()
//        tableView.backgroundColor = UIColor.blue
//        print(tableView.dataSource as! TermListTableView)
        return tableView
    }()
    
    private let placeHolderView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = UIColor.green
        return view
    }()
    
    let collectionView: UIView = {
//        let layout = UICollectionViewFlowLayout()
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        let cv = UIView()
//        cv.axis = .vertical
//        cv.alignment = .center
//        cv.distribution = .equalSpacing
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    private var contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
//    init(viewModel: GeneralViewModel, content: UIView, paddingTop: Int, paddingBottom: Int, paddingLeft: Int, paddingRight: Int) {
//        self.viewModel = viewModel
//        self.content = content
//        self.paddingTop = paddingTop
//        self.paddingBottom = paddingBottom
//        self.paddingLeft = paddingLeft
//        self.paddingRight = paddingRight
//        super.init()
//    }
    
    init(viewModel: GeneralViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    public func showBottomMenu() {
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissSelectFolder)))
            
            window.addSubview(blackView)
            
            window.addSubview(collectionView)
            
            let height: CGFloat = 350
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            
            blackView.frame = window.frame
            blackView.alpha = 0
            addContentView()
            addArrangedSubviews()
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: height)
            }, completion: nil)
            
            
//            setSubViews()
            
        }
    }
    
    private func addContentView() {
        collectionView.addSubview(contentView)
        contentView.free()
        contentView.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 8).isActive = true
        contentView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -36).isActive = true
    }
    
    private func addArrangedSubviews() {
//        contentView.addArrangedSubview(cancelButton)
//        contentView.addArrangedSubview(placeHolderView)
        contentView.addArrangedSubview(segmentTitle)
//        segmentTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        segmentTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32).isActive = true
        
        contentView.addArrangedSubview(listView)
        listView.configCell()
//        listView.free()
        listView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        listView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        listView.setEditing(true, animated: false)
        
        contentView.addArrangedSubview(saveButton)
        saveButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.85).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func setSubViews() {
        collectionView.addSubview(listView)
        //        view.addSubview(self.tableView)
        listView.configCell()
        listView.setEditing(true, animated: false)
        collectionView.addSubview(cancelButton)
        
//        cancelButton.free()
//        listView.free()
//        let verticalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[list]-(>=0)-[button]-|", options: [], metrics: nil, views: Dictionary(dictionaryLiteral: ("list", listView), ("button", cancelButton)))
//        collectionView.addConstraints(verticalConstraint)
        
//        cancelButton.free()
////        cancelButton.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor, multiplier: 0.5).isActive = true
//        cancelButton.centerXAnchor.constraint(equalToSystemSpacingAfter: collectionView.centerXAnchor, multiplier: 0.5).isActive = true
//        cancelButton.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
//        listView.free()
//        listView.topAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
////        listView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
//        listView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor).isActive = true
//        listView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor).isActive = true
//        listView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        collectionView.addSubview(placeHolderView)
//        placeHolderView.free()
////        placeHolderView.topAnchor.constraint(equalTo: listView.bottomAnchor).isActive = true
//        placeHolderView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
//        placeHolderView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
//        placeHolderView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor).isActive = true
//        placeHolderView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor).isActive = true
    }
    
    @objc private func dismissSelectFolder() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: window.frame.height)
            }
        }, completion: nil)
    }
    
//    override init() {
////        self.collectionView.dataSource = self
////        self.collectionView.delegate = self
//    }
}

//extension BottomMenu: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//
//
//}

class TermListSegment: UITableView {
    private static let cellIdentifier = "CellListCell"
    private var viewModel: GeneralViewModel
    private var terms: Array<Term> {
        get {
            return viewModel.getTerms()
        }
    }
    init(frame: CGRect, style: UITableView.Style, viewModel: GeneralViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configCell() {
        self.delegate = self
        self.dataSource = self
        //set row height
        self.rowHeight = 48
        //register cells
        self.register(TermListCell.self, forCellReuseIdentifier: TermListSegment.cellIdentifier)
        //set constraints
    //        tableView.free()
        self.allowsMultipleSelectionDuringEditing = true
    }
}


extension TermListSegment: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getTerms().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TermListSegment.cellIdentifier) as! TermListCell
        let term = terms[indexPath.row]
        cell.setTerm(term: term)
        print(term.title)
        return cell
    }
    
    
}
