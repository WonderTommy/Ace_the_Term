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
    
    private let messageUnder = NSLocalizedString("RESULT_MESSAGE_UNDER", comment: "")
    private let messageOver = NSLocalizedString("RESULT_MESSAGE_OVER", comment: "")
    private let messageOK = NSLocalizedString("RESULT_MESSAGE_OK", comment: "")
    
    private var subject: Subject
    
    private lazy var saveButton: UIBarButtonItem = {
        return UIBarButtonItem(title: saveButtonText, style: .done, target: self, action: #selector(saveButtonAction))
    }()
    
    private lazy var totalPointLabel: UILabel = {
        var label = UILabel()
        label.text = totalPointLabelText
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 40)
        return label
    }()
    
    private lazy var totalPointValue: UILabel = {
        var label = UILabel()
        label.text = "\(CalculationUtility.summationScore(items: subject.items))%"
        label.font = .systemFont(ofSize: 32)
        return label
    }()
    
    private lazy var highestPossibleLabel: UILabel = {
        var label = UILabel()
        label.text = highestPossibleLabelText
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 28)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var highestPossibleValue: UILabel = {
        var label = UILabel()
        label.text = "\(100 - CalculationUtility.summationPercentageLost(items: subject.items))%"
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var pointLostLabel: UILabel = {
        var label = UILabel()
        label.text = pointLostLabelText
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 28)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var pointLostValue: UILabel = {
        var label = UILabel()
        label.text = "\(CalculationUtility.summationPercentageLost(items: subject.items))%"
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var percentageMessage: UILabel = {
        var label = UILabel()
        let totalPercentage = CalculationUtility.summationPercentage(items: subject.items)
        label.text = totalPercentage == 100 ? messageOK : totalPercentage > 100 ? "\(messageOver)(\(totalPercentage)%)" : "\(messageUnder)(\(totalPercentage)%)"
        label.textColor = totalPercentage == 100 ? .systemGreen : totalPercentage > 100 ? .systemRed : .systemYellow
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var row1: UIView = {
        var view = UIView()
//        view.backgroundColor = .red
        return view
    }()
    
    private lazy var row2: UIView = {
        var view = UIView()
//        view.backgroundColor = .green
        return view
    }()
    
    private lazy var row3: UIView = {
        var view = UIView()
//        view.backgroundColor = .blue
        return view
    }()
    
    private lazy var row4: UIView = {
        var view = UIView()
//        view.backgroundColor = .blue
        return view
    }()
    
    private lazy var block2_1: UIView = {
        var view = UIView()
//        view.backgroundColor = .systemOrange
        return view
    }()
    
    private lazy var block2_2: UIView = {
        var view = UIView()
//        view.backgroundColor = .systemPurple
        return view
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
        addSubViews()
        configureLayout()
        // Do any additional setup after loading the view.
    }
    
    private func setNavBar() {
        self.navigationItem.title = pageTitle
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    private func addSubViews() {
        view.addSubview(row1)
        row1.free()
        row1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        row1.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
        row1.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true

        row1.addSubview(totalPointLabel)
        totalPointLabel.free()
        totalPointLabel.centerXAnchor.constraint(equalTo: row1.centerXAnchor).isActive = true
        totalPointLabel.centerYAnchor.constraint(equalTo: row1.centerYAnchor).isActive = true
        row1.addSubview(totalPointValue)
        totalPointValue.free()
        totalPointValue.centerXAnchor.constraint(equalTo: row1.centerXAnchor).isActive = true
        totalPointValue.topAnchor.constraint(equalTo: totalPointLabel.bottomAnchor).isActive = true

        view.addSubview(row2)
        row2.free()
        row2.topAnchor.constraint(equalTo: row1.bottomAnchor).isActive = true
        row2.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
        row2.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        
        row2.addSubview(block2_1)
        block2_1.free()
        block2_1.heightAnchor.constraint(equalTo: row2.heightAnchor).isActive = true
        block2_1.widthAnchor.constraint(equalTo: row2.widthAnchor, multiplier: 0.5).isActive = true
        block2_1.leadingAnchor.constraint(equalTo: row2.leadingAnchor).isActive = true
        block2_1.addSubview(highestPossibleLabel)
        highestPossibleLabel.free()
        highestPossibleLabel.centerXAnchor.constraint(equalTo: block2_1.centerXAnchor).isActive = true
        highestPossibleLabel.centerYAnchor.constraint(equalTo: block2_1.centerYAnchor).isActive = true
        highestPossibleLabel.widthAnchor.constraint(equalTo: block2_1.widthAnchor).isActive = true
        block2_1.addSubview(highestPossibleValue)
        highestPossibleValue.free()
        highestPossibleValue.centerXAnchor.constraint(equalTo: block2_1.centerXAnchor).isActive = true
        highestPossibleValue.topAnchor.constraint(equalTo: highestPossibleLabel.bottomAnchor).isActive = true
        
        row2.addSubview(block2_2)
        block2_2.free()
        block2_2.heightAnchor.constraint(equalTo: row2.heightAnchor).isActive = true
        block2_2.widthAnchor.constraint(equalTo: row2.widthAnchor, multiplier: 0.5).isActive = true
        block2_2.trailingAnchor.constraint(equalTo: row2.trailingAnchor).isActive = true
        block2_2.addSubview(pointLostLabel)
        pointLostLabel.free()
        pointLostLabel.centerXAnchor.constraint(equalTo: block2_2.centerXAnchor).isActive = true
        pointLostLabel.centerYAnchor.constraint(equalTo: block2_2.centerYAnchor).isActive = true
        pointLostLabel.widthAnchor.constraint(equalTo: block2_2.widthAnchor).isActive = true
        block2_2.addSubview(pointLostValue)
        pointLostValue.free()
        pointLostValue.centerXAnchor.constraint(equalTo: block2_2.centerXAnchor).isActive = true
        pointLostValue.topAnchor.constraint(equalTo: pointLostLabel.bottomAnchor).isActive = true

        view.addSubview(row3)
        row3.free()
        row3.topAnchor.constraint(equalTo: row2.bottomAnchor).isActive = true
        row3.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
        row3.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        
        row3.addSubview(percentageMessage)
        percentageMessage.free()
        percentageMessage.centerXAnchor.constraint(equalTo: row3.centerXAnchor).isActive = true
        percentageMessage.centerYAnchor.constraint(equalTo: row3.centerYAnchor).isActive = true
        percentageMessage.widthAnchor.constraint(equalTo: row3.widthAnchor, multiplier: 0.85).isActive = true
        
        
        view.addSubview(row4)
        row4.free()
        row4.topAnchor.constraint(equalTo: row3.bottomAnchor).isActive = true
        row4.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1).isActive = true
        row4.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
    }
    
    private func configureLayout() {
        
    }
    
    private func addSubViews_() {
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
    
    private func configureLayout_() {
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
