//
//  TermSummaryCell.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-10-06.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import UIKit

class TermSummaryCell: UITableViewCell {
    private var viewModel: GeneralViewModel?
    private var subject: Subject?
    
    private lazy var subjectTitle: UILabel = {
        let label = UILabel()
        label.text = subject?.title
        return label
    }()
    
    private lazy var subjectScore: UILabel = {
        let label = UILabel()
        label.text = "\(subject?.totalScore ?? "0")%"
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setSubject(viewModel: GeneralViewModel, subject: Subject) {
        self.viewModel = viewModel
        self.subject = subject
        resetRowData()
        addSubviews()
    }
    
    private func addSubviews() {
        contentView.backgroundColor = .systemFill
        contentView.addSubview(subjectTitle)
        contentView.addSubview(subjectScore)
        subjectTitle.free()
        subjectScore.free()
        let views = Dictionary(dictionaryLiteral: ("title", subjectTitle), ("score", subjectScore))
        let horizontalConstraint_0 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[title]-(>=0)-[score]-|", options: [], metrics: nil, views: views)
        let verticalConstraint_0 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[title]-|", options: [], metrics: nil, views: views)
        let verticalConstraint_1 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[score]-|", options: [], metrics: nil, views: views)
        self.addConstraints(horizontalConstraint_0)
        self.addConstraints(verticalConstraint_0)
        self.addConstraints(verticalConstraint_1)
    }

    private func resetRowData() {
        subjectTitle.text = subject?.title
        subjectScore.text = "\(subject?.totalScore ?? "0")%"
    }
}
