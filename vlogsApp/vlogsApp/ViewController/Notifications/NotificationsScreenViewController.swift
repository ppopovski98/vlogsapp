//
//  NotificationsScreenViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 12.6.23.
//

import UIKit
import SnapKit

class NotificationsScreenViewController: BaseUiNavigationBarAppearance, UITableViewDelegate, UITableViewDataSource {
    
    var notificationsScreenView = NotificationsScreenView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notifications"
        
        view.addSubview(notificationsScreenView)
        
        notificationsScreenView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        notificationsScreenView.notifTableView.delegate = self
        notificationsScreenView.notifTableView.dataSource = self
        notificationsScreenView.notifTableView.estimatedRowHeight = 44
        notificationsScreenView.notifTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let tabBarVC = tabBarController as? TabBarViewController {
            tabBarVC.tabBar.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notificationsScreenView.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var tmpCell = NotifTableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: NotifTableViewCell.identifier, for: indexPath) as? NotifTableViewCell {
            cell.configure(with: notificationsScreenView.tableViewData[indexPath.row])
            tmpCell = cell
        }
        return tmpCell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
}
