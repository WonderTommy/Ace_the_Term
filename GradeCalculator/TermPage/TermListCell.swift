//
//  TermListCell.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-09-20.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import UIKit

class TermListCell: UITableViewCell {
    private var initTerm: Term?
    private var term: Term {
        get {
            return viewModel?.getTerm(targetTerm: initTerm!) ?? initTerm!
        }
    }
    private var viewModel: GeneralViewModel?
    private var itemTitle = UILabel()
    private var termAverage = UILabel()
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
    
    public func setTerm(viewModel: GeneralViewModel, term: Term) {
        self.viewModel = viewModel
        self.initTerm = term
        itemTitle.text = initTerm!.title
        termAverage.text = "\(initTerm!.averageScore)%"
        addObservers()
//        itemTitle2.text = subject.title
    }
    
    private func addSubviews() {
        contentView.addSubview(itemTitle)
        contentView.addSubview(termAverage)
//        itemChevron.image = itemChevron.image?.withRenderingMode(.alwaysTemplate)
//        itemChevron.tintColor = .gray
//        addSubview(itemChevron)
    }
    
    private func configureItemTitle() {
        self.accessoryType = .disclosureIndicator
//        self.clipsToBounds = true
        itemTitle.free()
        termAverage.free()
//        itemTitle.translatesAutoresizingMaskIntoConstraints = false
        let views = Dictionary(dictionaryLiteral: ("title", self.itemTitle), ("average", self.termAverage))
        let horizontalContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[title]-(>=0)-[average]-|", options: [], metrics: nil, views: views)
        let verticalContraints_0 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[title]-|", options: [], metrics: nil, views: views)
        let verticalContraints_1 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[average]-|", options: [], metrics: nil, views: views)
        self.addConstraints(horizontalContraints)
        self.addConstraints(verticalContraints_0)
        self.addConstraints(verticalContraints_1)
        
        
//        let verticalContraints2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[chevron]-|", options: [], metrics: nil, views: views)
//        self.addConstraints(verticalContraints2)
        
//        itemTitle.pin(to: self)
        
//        itemTitle.numberOfLines = 0
//        itemTitle.adjustsFontSizeToFitWidth = true
//        itemTitle.translatesAutoresizingMaskIntoConstraints = false
//        itemTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        itemTitle.leadingAnchor
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(addItemForTermSelector(notification:)), name: GeneralViewModel.addItemForTermNotificationName, object: nil)
    }
    
    @objc private func addItemForTermSelector(notification: NSNotification) {
        let targetTerm = notification.userInfo?[GeneralViewModel.addItemForTermRow] as! Term
        if targetTerm == initTerm {
            termAverage.text = "\(term.averageScore)%"
        }
    }
}
