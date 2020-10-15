//
//  HistoryDetailVC.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-10-08.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import UIKit

class HistoryDetailVC: UIViewController {
    private var viewModel: GeneralViewModel
    private var record: HistoryItem
    
    private let totalScoreLabel = NSLocalizedString("LABEL_TOTAL_SCORE", comment: "")
    private let recordTimeLabel = NSLocalizedString("LABEL_TIME", comment: "")
    
    private let messageUnder = NSLocalizedString("RESULT_MESSAGE_UNDER", comment: "")
    private let messageOver = NSLocalizedString("RESULT_MESSAGE_OVER", comment: "")
    private let messageOK = NSLocalizedString("RESULT_MESSAGE_OK", comment: "")
    
    private static let cellIdentifier = "HistoryDetailCellIdentifier"
    
    private let contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var totalScore: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.text = "\(totalScoreLabel): \(record.subject.totalScore)"
        return label
    }()
    
    private lazy var recordTime: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.text = "\(recordTimeLabel): \(record.time)"
        return label
    }()
    
    private lazy var itemTable: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        //set row height
        table.rowHeight = 72
        //register cells
        table.register(HistoryDetailCell.self, forCellReuseIdentifier: HistoryDetailVC.cellIdentifier)
        table.backgroundColor = .systemFill
        table.layer.cornerRadius = 4
        //set constraints
//        tableView.free()
//        table.allowsMultipleSelectionDuringEditing = true
        return table
    }()
    
    private lazy var percentageMessage: UILabel = {
        var label = UILabel()
        let totalPercentage = CalculationUtility.summationPercentage(items: record.subject.items)
        label.text = totalPercentage == 100 ? messageOK : totalPercentage > 100 ? "\(messageOver)(\(totalPercentage)%)" : "\(messageUnder)(\(totalPercentage)%)"
        label.textColor = totalPercentage == 100 ? viewModel.getOkColor() : totalPercentage > 100 ? viewModel.getWarningColor() : viewModel.getRemainderColor()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    init(viewModel: GeneralViewModel, record: HistoryItem) {
        self.viewModel = viewModel
        self.record = record
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setUpLayout()
        // Do any additional setup after loading the view.
    }
    
    private func setNavBar() {
        navigationItem.title = record.subject.title
    }
    
    private func setUpLayout(){
        view.backgroundColor = .white
        
        view.addSubview(contentView)
        contentView.free()
        contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        contentView.addArrangedSubview(totalScore)
        totalScore.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32).isActive = true
        contentView.addArrangedSubview(recordTime)
        recordTime.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32).isActive = true
        contentView.addArrangedSubview(itemTable)
        itemTable.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32).isActive = true
        itemTable.heightAnchor.constraint(equalToConstant: 300).isActive = true
        contentView.addArrangedSubview(percentageMessage)
        percentageMessage.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32).isActive = true
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HistoryDetailVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return record.subject.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemTable.dequeueReusableCell(withIdentifier: HistoryDetailVC.cellIdentifier, for: indexPath) as! HistoryDetailCell
        let item = record.subject.items[indexPath.row]
        cell.setItem(item: item)
        return cell
    }
}
