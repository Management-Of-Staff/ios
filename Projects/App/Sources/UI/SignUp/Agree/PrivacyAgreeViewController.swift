//
//  PrivacyAgreeViewController.swift
//  App
//
//  Created by 이범준 on 4/29/23.
//  Copyright © 2023 com.Ozik. All rights reserved.
//

import UIKit

class PrivacyAgreeViewController: UIViewController {

    var termNumber: Int?
    weak var delegate: SecondViewControllerDelegate?
    
    private let termsTitle: UILabel = {
        let label = UILabel()
        label.text = "'두잉' 이용약관"
        label.font = .doingFont(size: .subtitle, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.backgroundColor = .backgroundNeutral
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let privacyAgreeDetailView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundNeutral
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let allAgreeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("확인하고 전체동의", for: .normal)
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .backgroundNeutral
        tableView.estimatedRowHeight = 100
        tableView.register(DynamicHeightTableViewCell.self,
                           forCellReuseIdentifier: DynamicHeightTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundNeutral
        configureUI()
        createLayout()
    }
}

extension PrivacyAgreeViewController {
    
    @objc func dismissButtonAction(sender: UIButton!) {
        print("닫기 버튼 눌림")
        dismiss(animated: true, completion: nil)
    }
    
    @objc func allAgreeAction(sender: UIButton!) {
        delegate?.dismissSecondViewController()
        print("확인하고 전체동의 눌림")
        dismiss(animated: true, completion: nil)
    }
    
    private func configureUI() {
        view.addSubview(privacyAgreeDetailView)
        privacyAgreeDetailView.addSubview(termsTitle)
        privacyAgreeDetailView.addSubview(dismissButton)
        privacyAgreeDetailView.addSubview(scrollView)
        privacyAgreeDetailView.addSubview(allAgreeButton)
        dismissButton.addTarget(self, action: #selector(dismissButtonAction), for: .touchUpInside)
        
        allAgreeButton.addTarget(self, action: #selector(allAgreeAction), for: .touchUpInside)
        scrollView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    private func createLayout() {
        
        NSLayoutConstraint.activate([
            privacyAgreeDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            privacyAgreeDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            privacyAgreeDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            privacyAgreeDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            termsTitle.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            termsTitle.topAnchor.constraint(equalTo: privacyAgreeDetailView.topAnchor, constant: 12),
            
            dismissButton.trailingAnchor.constraint(equalTo: privacyAgreeDetailView.trailingAnchor, constant: -20),
            dismissButton.centerYAnchor.constraint(equalTo: termsTitle.centerYAnchor),
            dismissButton.heightAnchor.constraint(equalTo: termsTitle.heightAnchor, multiplier: 28/24),
            dismissButton.widthAnchor.constraint(equalTo: termsTitle.heightAnchor, multiplier: 28/24),
            
            scrollView.leadingAnchor.constraint(equalTo: privacyAgreeDetailView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: privacyAgreeDetailView.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: termsTitle.bottomAnchor, constant: 38),
            scrollView.bottomAnchor.constraint(equalTo: allAgreeButton.topAnchor, constant: -26),
            
            tableView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 2000),
            tableView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 326/375),
            tableView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            allAgreeButton.widthAnchor.constraint(equalTo: privacyAgreeDetailView.widthAnchor, multiplier: 327/375),
            allAgreeButton.heightAnchor.constraint(equalTo: privacyAgreeDetailView.heightAnchor, multiplier: 52/812),
            allAgreeButton.centerXAnchor.constraint(equalTo: privacyAgreeDetailView.centerXAnchor),
            allAgreeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}

extension PrivacyAgreeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DynamicHeightTableViewCell.reuseIdentifier, for: indexPath) as? DynamicHeightTableViewCell
        else {
            return UITableViewCell()
        }
        let dataObject: TermsContentDataObject
        if termNumber == 0 {
            dataObject = TermsContentDataSet.data0[indexPath.row]
        } else if termNumber == 1 {
            dataObject = TermsContentDataSet.data1[indexPath.row]
        } else {
            dataObject = TermsContentDataSet.data2[indexPath.row]
        }
        cell.configureCell(with: dataObject.title, subtitle: dataObject.subtitle)
        cell.backgroundColor = .backgroundNeutral
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if termNumber == 0 {
            return TermsContentDataSet.data0.count
        } else if termNumber == 1 {
            return TermsContentDataSet.data1.count
        } else {
            return TermsContentDataSet .data2.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

class MultilineLabelCell: UITableViewCell {

    var subTitle: UILabel!
    var content: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
    
class DynamicHeightTableViewCell: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
  
    private func commonInit() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate(staticConstraints())
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .doingFont(size: .body, weight: .medium)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .doingFont(size: .button, weight: .regular)
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 100
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func staticConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        //Set the constraints of the containerView view to the contentView of the Cell
        constraints.append(contentsOf: [
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        constraints.append(contentsOf: [
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5.0),
            titleLabel.heightAnchor.constraint(equalToConstant: 18.0),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        constraints.append(contentsOf: [
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.0),
            subtitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4.0),
            subtitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            subtitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        return constraints
    }
    
    func configureCell(with title: String, subtitle: String, image: UIImage? = nil) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
