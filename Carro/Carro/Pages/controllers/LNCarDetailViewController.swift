//
//  LNCarDetailViewController.swift
//  Carro
//
//  Created by MAC on 2020/12/7.
//

import UIKit

class LNCarDetailViewController: LNBaseViewController {
    
    private let carInfoIdentifier = "carInfoIdentifier"
    private let carFormIdentifier = "carFormIdentifier"
    private let managerIdentifier = "managerIdentifier"
    private let EnhanceIdentifier = "EnhanceIdentifier"
    
    fileprivate var isSingapore = false
    fileprivate var resource: LNCarInfoModel! {
        didSet {
            resource.isSingapore = self.isSingapore
            self.mainTableView.reloadData()
        }
    }
    
    //tableview
    lazy var mainTableView: UITableView = {
        let tableView = UITableView.init(frame: self.contentView.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = .clear
        tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.width, height: 16))
        
        tableView.register(LNCarInfoCell.self, forCellReuseIdentifier: carInfoIdentifier)
        tableView.register(LNCarFormCell.self, forCellReuseIdentifier: carFormIdentifier)
        tableView.register(LNCarManagerCell.self, forCellReuseIdentifier: managerIdentifier)
        tableView.register(LNCarEnhanceCell.self, forCellReuseIdentifier: EnhanceIdentifier)
        return tableView
    }()
    
    //Determine the type when initializing
    public init(isSingapore:Bool = false) {
        super.init(nibName: nil, bundle: nil)
        
        self.isSingapore = isSingapore
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    internal override func configSubViews() {
        self.contentView.addSubview(self.mainTableView)
    }
    
    internal override func requestData() {
        
        self.ly_showLoadingHUD(text: nil, autoHideDelay: 0)
        HttpService<LNCarInfoModel>.get(route: .carDetailInfo) { (result) in
            if result.isSucceess, let data = result.data {
                
                self.ly_hideHud(afterDelay: 0)
                self.resource = data
            }else{
                
                self.ly_showFailureHud(text: result.fail?.message)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.5) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LNCarDetailViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if resource != nil {
            return 4
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        var identifier = ""
        switch indexPath.section {
        case 0:
            identifier = carInfoIdentifier
        case 1:
            identifier = carFormIdentifier
        case 2:
            identifier = managerIdentifier
        default:
            identifier = EnhanceIdentifier
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! LNCarCell
        cell.resource = self.resource
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return resource.carInfoHeight
        case 1:
            return resource.carFormHeight
        case 2:
            return resource.managerHeight
        default:
            return resource.EnhanceHeight
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.width, height: 40))
        sectionView.backgroundColor = .white
        let sectionLabel = UILabel.init(frame: CGRect.init(x: 16, y: 0, width: UIScreen.width-16*2, height: 40))
        sectionLabel.text = (section == 2 ? "Manager your subscription":"Enhance your subscription").local
        sectionLabel.font = UIFont.boldSystemFont(ofSize: 22)
        sectionLabel.textColor = UIColor.black
        sectionLabel.textAlignment = .center
        sectionView.addSubview(sectionLabel)
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section < 2 {
            return 0
        }
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
