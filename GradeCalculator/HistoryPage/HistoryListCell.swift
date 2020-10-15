//
//  HistoryListCell.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-10-06.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import UIKit

class HistoryListCell: UITableViewCell {
    private var viewModel: GeneralViewModel?
    private var record: HistoryItem?
    
    private var recordTitle = UILabel()
    private var recordTotalScore = UILabel()
    private var recordTotalWeight = UILabel()
    private var recordTime = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setRecord(viewModel: GeneralViewModel, record: HistoryItem) {
        self.viewModel = viewModel
        self.record = record
        addSubviews()
    }
    
    private func addSubviews() {
        self.accessoryType = .disclosureIndicator
        recordTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        recordTotalScore.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        recordTitle.text = record?.subject.title
        recordTotalScore.text = record?.totalScore
        recordTotalWeight.text = "\(record?.totalWeight ?? "")%"
        recordTotalWeight.textColor = Double(record?.totalWeight ?? "0.0") == 100.0 ? viewModel?.getOkColor() : Double(record?.totalWeight ?? "0.0")! > 100.0 ? viewModel?.getWarningColor() : viewModel?.getRemainderColor()
        recordTime.text = record?.time
        
        contentView.addSubview(recordTitle)
        contentView.addSubview(recordTotalScore)
        contentView.addSubview(recordTotalWeight)
        contentView.addSubview(recordTime)
        
        recordTitle.free()
        recordTotalScore.free()
        recordTotalWeight.free()
        recordTime.free()
        
        let views = Dictionary(dictionaryLiteral: ("title", recordTitle), ("score", recordTotalScore), ("weight", recordTotalWeight), ("time", recordTime))
        let horizontalConstraint_0 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[title]-(>=0)-[score]-|", options: [], metrics: nil, views: views)
        let verticalConstraint_0 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[title]-(>=0)-|", options: [], metrics: nil, views: views)
        let horizontalConstraint_1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=0)-[weight]-|", options: [], metrics: nil, views: views)
        let horizontalConstraint_2 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=0)-[time]-|", options: [], metrics: nil, views: views)
        let verticalConstraints_1 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[score]-[weight]-[time]-|", options: [], metrics: nil, views: views)
        self.addConstraints(horizontalConstraint_0)
        self.addConstraints(verticalConstraint_0)
        self.addConstraints(horizontalConstraint_1)
        self.addConstraints(horizontalConstraint_2)
        self.addConstraints(verticalConstraints_1)
        
//        let horizontalConstraint_0 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[title]-(>=0)-[score]-|", options: [], metrics: nil, views: views)
//        let verticalConstraint_0 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[title]-|", options: [], metrics: nil, views: views)
//        let verticalConstraint_1 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[score]-|", options: [], metrics: nil, views: views)
//        self.addConstraints(horizontalConstraint_0)
//        self.addConstraints(verticalConstraint_0)
//        self.addConstraints(verticalConstraint_1)
        
    }

}
