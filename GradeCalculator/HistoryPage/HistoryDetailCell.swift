//
//  HistoryDetailCell.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-10-08.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import UIKit

class HistoryDetailCell: UITableViewCell {
    private var item: Item?
    
    private lazy var itemTitle: UILabel = {
        let label = UILabel()
        label.text = item?.name
        return label
    }()
    
    private lazy var itemScorePercent: UILabel = {
        let label = UILabel()
        label.text = "\(item?.trueScorePercent ?? 0.0)%"
        return label
    }()
    
    private lazy var itemScore: UILabel = {
        let label = UILabel()
        label.text = "\(item?.trueScore ?? 0.0)"
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setItem(item: Item) {
        self.item = item
        resetRowData()
        addSubviews()
    }
    
    private func addSubviews() {
        contentView.backgroundColor = .systemFill
        contentView.addSubview(itemTitle)
        contentView.addSubview(itemScore)
        contentView.addSubview(itemScorePercent)
        itemTitle.free()
        itemScore.free()
        itemScorePercent.free()
        let views = Dictionary(dictionaryLiteral: ("title", itemTitle), ("score", itemScore), ("percent", itemScorePercent))
        let horizontalConstraint_0 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[title]-(>=0)-[percent]-|", options: [], metrics: nil, views: views)
        let horizontalConstraint_1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=0)-[score]-|", options: [], metrics: nil, views: views)
        let verticalConstraint_0 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[title]-(>=0)-|", options: [], metrics: nil, views: views)
        let verticalConstraint_1 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[percent]-[score]-|", options: [], metrics: nil, views: views)
        self.addConstraints(horizontalConstraint_0)
        self.addConstraints(horizontalConstraint_1)
        self.addConstraints(verticalConstraint_0)
        self.addConstraints(verticalConstraint_1)
    }
    
    private func resetRowData() {
        itemTitle.text = item?.name
        itemScore.text = "\(item?.trueScore ?? 0.0)"
        itemScorePercent.text = "\(item?.trueScorePercent ?? 0.0)%"
    }
}
