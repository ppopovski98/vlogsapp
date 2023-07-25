//
//  AlertScreenViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 12.6.23.
//

import UIKit
import SnapKit

class NotificationsScreenViewController: BaseUiNavigationBarAppearance, UITableViewDelegate, UITableViewDataSource {
    
    var tableViewData: [String] = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    "Quisque et neque metus. Phasellus tortor justo, elementum sed tincidunt in, venenatis sit amet nulla. Mauris libero massa, rhoncus et scelerisque a, interdum at orci. Pellentesque ac sodales turpis, nec porta enim. Sed quis blandit libero. Morbi ornare, est id aliquet eleifend, tortor augue vestibulum orci, ut rutrum dui odio eu mi. Etiam quis lacus enim.",
    "Aenean viverra rhoncus varius. Sed dolor nulla, dictum vitae elit eu, suscipit aliquet leo. Aliquam id ante et ipsum mollis pulvinar. Nullam dictum mi eu tellus molestie pellentesque. Proin ac neque pellentesque, dignissim arcu tristique, feugiat nibh. Quisque dictum nibh pellentesque, aliquet felis pharetra, dapibus dui. Vestibulum sit amet fermentum tellus. Sed nec odio sed dolor pharetra volutpat.",
    "Suspendisse potenti. Duis ac suscipit odio. Suspendisse ornare iaculis sem nec hendrerit. Suspendisse potenti. Nulla facilisi. Ut mattis a eros tristique scelerisque. Praesent aliquet eros non justo bibendum, non elementum nunc volutpat. Aliquam rhoncus ornare dolor, eu blandit leo rhoncus vel.",
    "Bla"
    ]
    
    lazy var notifTableView: UITableView = {
       var tableView = UITableView()
        tableView.register(NotifTableViewCell.self, forCellReuseIdentifier: NotifTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        notifTableView.delegate = self
        notifTableView.dataSource = self
        notifTableView.estimatedRowHeight = 44
        notifTableView.rowHeight = UITableView.automaticDimension
        view.backgroundColor = .white
        view.addSubview(notifTableView)
        alertConfigUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let tabBarVC = tabBarController as? TabBarViewController {
            tabBarVC.tabBar.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        notifTableView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview().inset(12)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
    func alertConfigUI() {
        
        title = "Notifications"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var tmpCell = NotifTableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: NotifTableViewCell.identifier, for: indexPath) as? NotifTableViewCell {
            cell.configure(with: tableViewData[indexPath.row])
            tmpCell = cell
        }
        return tmpCell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
}
