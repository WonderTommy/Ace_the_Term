//
//  TermSummaryVC.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-10-04.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import UIKit

class TermSummaryVC: UIViewController {
    private var viewModel: GeneralViewModel
    private var initTerm: Term
    private var term: Term {
        get {
            return viewModel.getTerm(targetTerm: initTerm)!
        }
    }
    
    private static let cellIdentifier = "cellIdentifier"
    
    private let navigationBarTitle = NSLocalizedString("PAGE_TITLE_TERM_SUMMARY", comment: "")
    private let averageScoreLabel = NSLocalizedString("LABLE_AVERAGE_SCORE", comment: "")
    
    private var averageScoreText: String {
        get {
            return "\(averageScoreLabel): \(term.averageScore)%"
        }
    }
    
    private lazy var contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var averageScore: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.text = averageScoreText
        return label
    }()
    
    private lazy var subjectsTable: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        //set row height
        table.rowHeight = 48
        //register cells
        table.register(TermSummaryCell.self, forCellReuseIdentifier: TermSummaryVC.cellIdentifier)
        table.backgroundColor = .systemFill
        table.layer.cornerRadius = 4
        //set constraints
//        tableView.free()
//        table.allowsMultipleSelectionDuringEditing = true
        return table
    }()
    
    init(viewModel: GeneralViewModel, initTerm: Term) {
        self.viewModel = viewModel
        self.initTerm = initTerm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBar()
        setUpLayout()
        addObservers()
    }
    
    private func setNavBar() {
        self.navigationItem.title = "\(navigationBarTitle) (\(term.title))"
    }
    

    private func setUpLayout() {
        view.backgroundColor = .white
        view.addSubview(contentView)
        contentView.free()
        contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//        contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        contentView.addArrangedSubview(averageScore)
        averageScore.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32).isActive = true
        
        contentView.addArrangedSubview(subjectsTable)
        subjectsTable.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32).isActive = true
        subjectsTable.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(addItemForTermSelector(notification:)), name: GeneralViewModel.addItemForTermNotificationName, object: nil)
    }
    
    @objc private func addItemForTermSelector(notification: NSNotification) {
        let targetTerm = notification.userInfo?[GeneralViewModel.addItemForTermRow] as! Term
        if targetTerm == initTerm {
            averageScore.text = averageScoreText
        }
        subjectsTable.beginUpdates()
        subjectsTable.reloadSections([0], with: .automatic)
        subjectsTable.endUpdates()
    }

}

extension TermSummaryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return term.subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = subjectsTable.dequeueReusableCell(withIdentifier: TermSummaryVC.cellIdentifier) as! TermSummaryCell
        let subject = term.subjects[indexPath.row]
        cell.setSubject(viewModel: viewModel, subject: subject)
        print(term.title)
        return cell
    }
}
