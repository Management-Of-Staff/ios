//
//  PrivacyAgreeViewController.swift
//  App
//
//  Created by 이범준 on 4/5/23.
//  Copyright © 2023 Ozik. All rights reserved.
//

import UIKit

class PrivacyAgreeViewController: UIViewController {
    
    var termNumber: Int?
    var allAgree: Bool = false
    weak var delegate: ProtocolData?
    
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
    
    @objc func dismissButtonAction(sender: UIButton!) {
        print("닫기 버튼 눌림")
        dismiss(animated: true, completion: nil)
    }
    @objc func allAgreeAction(sender: UIButton!) {
        print("확인하고 전체동의 눌림")
        allAgree = true
        self.delegate?.protocolData(dataSent: allAgreeButton.currentTitle ?? "dkdh")
        print("다음")
        dismiss(animated: true, completion: nil)
    }
}

extension PrivacyAgreeViewController {
    
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DynamicHeightTableViewCell.reuseIdentifier,
                                                 for: indexPath) as? DynamicHeightTableViewCell
        else {
            return UITableViewCell()
        }
        let dataObject: DataObject
        if termNumber == 0 {
            dataObject = DataSet.data0[indexPath.row]
        } else if termNumber == 1 {
            dataObject = DataSet.data1[indexPath.row]
        } else {
            dataObject = DataSet.data2[indexPath.row]
        }
        cell.configureCell(with: dataObject.title, subtitle: dataObject.subtitle)
        cell.backgroundColor = .backgroundNeutral
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if termNumber == 0 {
            return DataSet.data0.count
        } else if termNumber == 1 {
            return DataSet.data1.count
        } else {
            return DataSet.data2.count
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
    
    // MARK: Overrides
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
        // wrapper to contain all the subviews for the UITableViewCell
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
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor,
                                            constant: 5.0),
            titleLabel.heightAnchor.constraint(equalToConstant: 18.0),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        constraints.append(contentsOf: [
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                               constant: 4.0),
            subtitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,
                                                  constant: -4.0),
            subtitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                   constant: 5),
            subtitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        return constraints
    }
    
    // function to configure the cells title and subtitle Text
    func configureCell(with title: String, subtitle: String, image: UIImage? = nil) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}

struct DataObject {
    let title: String
    let subtitle: String
}

class DataSet {
    static let data0: [DataObject] = [
        DataObject(title: "제 1 조 (목적",
                   subtitle: "본 약관은 오직(이하 '회사'라 함)이 제공하는 두잉(doing)에 관한 모든 제품 및 서비스(이하 '서비스'라 함)의 이용에 관한 조건에 대해 서비스를 이용하는 회원(이하 '회원'이라 함)과 회사간의 권리, 의무 및 책임사항, 기타 필요사항을 규정함을 목적으로 합니다."),
        DataObject(title: "Why does Appreciation matter?",
                   subtitle: "It motivates me to keep creating content, and helps improve the reach of the article. It also lets me know wether the quality of the content is decent or not"),
        DataObject(title: "Why am I writing this article?",
                   subtitle: "Right now as of 28th Aug,2021 i dont see any article or stackoverflow answering the question about making the UIlabels dynamically resize programatically. The issue is that we can easily do this with XiB, but the same implementation programatically is not giving the desired affect and the cells wont resize."),
        DataObject(title: "Is there any other way to do this if I dont wannt use a container view",
                   subtitle: "I think there is another way to do this by calculating the number of lines you require and deciding the height appropriately."),
        DataObject(title: "What is the advantage of this method?",
                   subtitle: "Quite a few of the folks complain that they cant use numberOfLines property in UILabel inside a TableViewCell but this shall allow you to do that.")
    ]
    
    static let data1: [DataObject] = [
        DataObject(title: "2번째 약관",
                   subtitle: "본 약관은 오직(이하 '회사'라 함)이 제공하는 두잉(doing)에 관한 모든 제품 및 서비스(이하 '서비스'라 함)의 이용에 관한 조건에 대해 서비스를 이용하는 회원(이하 '회원'이라 함)과 회사간의 권리, 의무 및 책임사항, 기타 필요사항을 규정함을 목적으로 합니다."),
        DataObject(title: "Why does Appreciation matter?",
                   subtitle: "It motivates me to keep creating content, and helps improve the reach of the article. It also lets me know wether the quality of the content is decent or not"),
        DataObject(title: "Why am I writing this article?",
                   subtitle: "Right now as of 28th Aug,2021 i dont see any article or stackoverflow answering the question about making the UIlabels dynamically resize programatically. The issue is that we can easily do this with XiB, but the same implementation programatically is not giving the desired affect and the cells wont resize."),
        DataObject(title: "Is there any other way to do this if I dont wannt use a container view",
                   subtitle: "I think there is another way to do this by calculating the number of lines you require and deciding the height appropriately."),
        DataObject(title: "What is the advantage of this method?",
                   subtitle: "Quite a few of the folks complain that they cant use numberOfLines property in UILabel inside a TableViewCell but this shall allow you to do that.")
    ]
    
    static let data2: [DataObject] = [
        DataObject(title: "3번째 약관",
                   subtitle: "본 약관은 오직(이하 '회사'라 함)이 제공하는 두잉(doing)에 관한 모든 제품 및 서비스(이하 '서비스'라 함)의 이용에 관한 조건에 대해 서비스를 이용하는 회원(이하 '회원'이라 함)과 회사간의 권리, 의무 및 책임사항, 기타 필요사항을 규정함을 목적으로 합니다."),
        DataObject(title: "Why does Appreciation matter?",
                   subtitle: "It motivates me to keep creating content, and helps improve the reach of the article. It also lets me know wether the quality of the content is decent or not"),
        DataObject(title: "Why am I writing this article?",
                   subtitle: "Right now as of 28th Aug,2021 i dont see any article or stackoverflow answering the question about making the UIlabels dynamically resize programatically. The issue is that we can easily do this with XiB, but the same implementation programatically is not giving the desired affect and the cells wont resize."),
        DataObject(title: "Is there any other way to do this if I dont wannt use a container view",
                   subtitle: "I think there is another way to do this by calculating the number of lines you require and deciding the height appropriately."),
        DataObject(title: "What is the advantage of this method?",
                   subtitle: "Quite a few of the folks complain that they cant use numberOfLines property in UILabel inside a TableViewCell but this shall allow you to do that.")
    ]
}

protocol ProtocolData: AnyObject {
    func protocolData(dataSent: String)
}
