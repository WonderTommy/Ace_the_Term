//
//  ResultVCViewController.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-09-19.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import UIKit

class ResultVC: UIViewController {
    
    private let pageTitle = NSLocalizedString("PAGE_TITLE_RESULT", comment: "")
    private let saveButtonText = NSLocalizedString("BUTTON_TEXT_SAVE", comment: "")
    private let totalPointLabelText = NSLocalizedString("RESULT_ITEM_LABEL_TOTAL", comment: "")
    private let highestPossibleLabelText = NSLocalizedString("RESULT_ITEM_LABEL_HIGHEST_POSSITLE", comment: "")
    private let pointLostLabelText = NSLocalizedString("RESULT_ITEM_LABEL_POINTS_LOST", comment: "")
    
    private var subject: Subject
    
    private lazy var saveButton: UIBarButtonItem = {
        return UIBarButtonItem(title: saveButtonText, style: .done, target: self, action: #selector(saveButtonAction))
    }()
    
    private lazy var totalPointLabel: UILabel = {
        var label = UILabel()
        label.text = totalPointLabelText
        return label
    }()
    
    private lazy var totalPointValue: UILabel = {
        var label = UILabel()
        label.text = "\(CalculationUtility.summationScore(items: subject.items))%"
        return label
    }()
    
    private lazy var pointLostLabel: UILabel = {
        var label = UILabel()
        label.text = pointLostLabelText
        return label
    }()
    
    private lazy var pointLostValue: UILabel = {
        var label = UILabel()
        label.text = "\(CalculationUtility.summationPercentageLost(items: subject.items))%"
        return label
    }()
    
    private var outerStackView = UIStackView()
    private var firstRow = UIStackView()
    private var secondRow = UIStackView()
    private var thirdRow = UIStackView()
    
    init(subject: Subject) {
        self.subject = subject
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavBar()
        addSubeViews()
        configureLayout()
        // Do any additional setup after loading the view.
    }
    
    private func setNavBar() {
        self.navigationItem.title = pageTitle
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    private func addSubeViews() {
        outerStackView.axis = .vertical
        outerStackView.alignment = .center
        outerStackView.distribution = .fillEqually
        outerStackView.spacing = 8
        view.addSubview(outerStackView)
        firstRow.axis = .vertical
        firstRow.alignment = .center
        firstRow.distribution = .fillEqually
        secondRow.axis = .vertical
        secondRow.alignment = .center
        secondRow.distribution = .equalCentering
        thirdRow.axis = .vertical
        thirdRow.alignment = .center
        thirdRow.distribution = .equalCentering
    }
    
    private func configureLayout() {
        outerStackView.free()
//        outerStackView.frame = view.bounds
        outerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        outerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        outerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        outerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true

        totalPointLabel.backgroundColor = .red
        totalPointValue.backgroundColor = .blue
        firstRow.addArrangedSubview(totalPointLabel)
        firstRow.addArrangedSubview(totalPointValue)
        outerStackView.addArrangedSubview(firstRow)
        secondRow.addArrangedSubview(pointLostLabel)
        secondRow.addArrangedSubview(pointLostValue)
        outerStackView.addArrangedSubview(secondRow)
//        thirdRow.addArrangedSubview(totalPointLabel)
//        outerStackView.addArrangedSubview(thirdRow)
//        outerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
//        outerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
//        outerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
//        outerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
//        totalPointLabel.free()
//        totalPointValue.free()
//        let views = Dictionary(dictionaryLiteral:
//            ("superview", view!),
//            ("totalPointLabel", totalPointLabel),
//            ("totalPointValue", totalPointValue))
//        totalPointLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
//        totalPointValue.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
//        let verticalConstraint_0 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[totalPointLabel]-(>=0)-[totalPointValue]-|", options: [], metrics: nil, views: views)
//        view.addConstraints(verticalConstraint_0)
    }
    
    // MARK - Button actions
    @objc private func saveButtonAction() {
        print("save button clicked")
    }

}
