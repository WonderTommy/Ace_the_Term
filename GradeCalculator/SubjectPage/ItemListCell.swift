//
//  ItemListCell.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-09-06.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import UIKit

class ItemListCell: UITableViewCell {
    private var item: Item?
    
    private var itemName = UILabel()
    private var itemPoint = UILabel()
    private var itemFullPoint = UILabel()
    private var itemPercentage = UILabel()
    private var itemTrueScorePercent = UILabel()
    private var itemTrueScore = UILabel()
//    private var itemChevron = UIImageView(image: UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(scale: .small)))
    
    // MARK - constants
    private let titleFontSize: CGFloat = 24
    private let resultFontSize: CGFloat = 20
    private let bodyFontSize: CGFloat = 16
    private let pointLabel: String = NSLocalizedString("CALCULATION_ITEM_LABEL_POINTS", comment: "")
    private let fullPointLabel: String = NSLocalizedString("CALCULATION_ITEM_LABEL_FULL_POINTS", comment: "")
    private let weightLabel: String = NSLocalizedString("CALCULATION_ITEM_LABEL_WEIGHT", comment: "")

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureCellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setItem(item: Item) {
        self.item = item
        
        itemName.text = item.name
        itemTrueScorePercent.text = "\(item.trueScorePercent)%"
        itemTrueScore.text = "\(item.trueScore)"
        itemPoint.text = "\(pointLabel) \(item.points)"
        itemFullPoint.text = "\(fullPointLabel) \(item.fullPoints)"
        itemPercentage.text = "\(weightLabel) \(item.weight)%"
    }
    
    private func addSubviews() {
//        itemName.font = .systemFont(ofSize: titleFontSize)
        itemName.font = UIFont(name: "HelveticaNeue-Bold", size: titleFontSize)
        contentView.addSubview(itemName)
        itemPoint.font = .systemFont(ofSize: bodyFontSize)
        contentView.addSubview(itemPoint)
        itemFullPoint.font = .systemFont(ofSize: bodyFontSize)
        contentView.addSubview(itemFullPoint)
        itemPercentage.font = .systemFont(ofSize: bodyFontSize)
        contentView.addSubview(itemPercentage)
//        itemTrueScorePercent.font = .systemFont(ofSize: resultFontSize)
        itemTrueScorePercent.font = UIFont(name: "HelveticaNeue-Bold", size: resultFontSize)
        contentView.addSubview(itemTrueScorePercent)
        itemTrueScore.font = .systemFont(ofSize: bodyFontSize)
        contentView.addSubview(itemTrueScore)
//        itemChevron.image = itemChevron.image?.withRenderingMode(.alwaysTemplate)
//        itemChevron.tintColor = .gray
//        addSubview(itemChevron)
    }
    
    private func configureCellLayout() {
        self.accessoryType = .disclosureIndicator
        itemName.free()
        itemPoint.free()
        itemFullPoint.free()
        itemPercentage.free()
        itemTrueScorePercent.free()
        itemTrueScore.free()
//        itemChevron.free()
        let views = Dictionary(dictionaryLiteral:
                                ("name", itemName),
                                ("trueScorePercentage", itemTrueScorePercent),
                                ("trueScore", itemTrueScore),
                                ("point", itemPoint),
                                ("fullPoint", itemFullPoint),
                                ("weight", itemPercentage))
        let horizontalContraint_0 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[name]-(>=0)-[trueScorePercentage]-|", options: [], metrics: nil, views: views)
        let horizontalContraint_1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[point]-(>=0)-[trueScore]-|", options: [], metrics: nil, views: views)
        let horizontalContraint_2 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[fullPoint]-(>=0)-|", options: [], metrics: nil, views: views)
        let horizontalContraint_3 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[weight]-(>=0)-|", options: [], metrics: nil, views: views)
        let verticalConstraint_0 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(4)-[name]-(4)-[point]-(4)-[fullPoint]-(4)-[weight]-(4)-|", options:[], metrics: nil, views: views)
        let verticalConstraint_1 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[trueScorePercentage]-(4)-[trueScore]-(>=0)-|", options:[], metrics: nil, views: views)
//        let verticalConstraint_2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=20)-[chevron]-(>=45)-|", options: NSLayoutConstraint.FormatOptions.alignAllCenterY, metrics: nil, views: views)
        self.addConstraints(horizontalContraint_0)
        self.addConstraints(horizontalContraint_1)
        self.addConstraints(horizontalContraint_2)
        self.addConstraints(horizontalContraint_3)
        self.addConstraints(verticalConstraint_0)
        self.addConstraints(verticalConstraint_1)
//        self.addConstraints(verticalConstraint_2)
    }
}
