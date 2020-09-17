//
//  SubjectListCell.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-08-30.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import UIKit

class SubjectListCell: UITableViewCell {
    private var subject: Subject?
    private var itemTitle = UILabel()
//    private var itemChevron = UIImageView(image: UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(scale: .small)))
//    var itemTitle2 = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
//        addSubview(itemTitle2)
        configureItemTitle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not bee implemented")
    }
    
    public func setSubject(subject: Subject) {
        self.subject = subject
        itemTitle.text = subject.title
//        itemTitle2.text = subject.title
    }
    
    private func addSubviews() {
        contentView.addSubview(itemTitle)
        
//        itemChevron.image = itemChevron.image?.withRenderingMode(.alwaysTemplate)
//        itemChevron.tintColor = .gray
//        addSubview(itemChevron)
    }
    
    private func configureItemTitle() {
        self.accessoryType = .disclosureIndicator
//        self.clipsToBounds = true
        itemTitle.free()
//        itemTitle.translatesAutoresizingMaskIntoConstraints = false
        let views = Dictionary(dictionaryLiteral: ("title", self.itemTitle))
        let horizontalContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[title]-(>=0)-|", options: [], metrics: nil, views: views)
        self.addConstraints(horizontalContraints)
        let verticalContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[title]-|", options: [], metrics: nil, views: views)
        self.addConstraints(verticalContraints)
        
        
//        let verticalContraints2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[chevron]-|", options: [], metrics: nil, views: views)
//        self.addConstraints(verticalContraints2)
        
//        itemTitle.pin(to: self)
        
//        itemTitle.numberOfLines = 0
//        itemTitle.adjustsFontSizeToFitWidth = true
//        itemTitle.translatesAutoresizingMaskIntoConstraints = false
//        itemTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        itemTitle.leadingAnchor
    }
}
