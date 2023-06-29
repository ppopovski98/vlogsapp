//
//  AlertScreenViewController.swift
//  vlogsApp
//
//  Created by Petar Popovski on 12.6.23.
//

import UIKit

class NotificationsScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableViewData: [String] = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    "Quisque vel augue eget mi hendrerit faucibus. Pellentesque non eros lacinia, volutpat ligula eu, scelerisque lacus. Nunc ut mi nec nibh egestas aliquam et non sem. Ut dui risus, gravida in lorem a, accumsan mattis ante. Pellentesque placerat ipsum elit. Nulla sodales, mi vel iaculis maximus, nulla quam ullamcorper magna, ut consequat sapien turpis quis justo. Maecenas sed fermentum neque. In ut ligula quis justo tincidunt mattis eget sit amet eros.",
    "Aliquam et leo mi. Morbi ornare, tellus id auctor imperdiet, mi augue porttitor nisi, ut viverra lorem ipsum vitae dolor. ",
    "Integer sodales dolor vitae tellus vulputate, sit amet dictum felis lobortis. Sed consequat ante mauris, at iaculis felis placerat ut. Cras mollis quam at lorem molestie porta. Praesent luctus dui vitae est egestas, eu vehicula lorem consectetur. Nam ac consectetur ante, nec convallis lacus. Morbi urna arcu, fermentum ac congue in, lobortis at quam.",
    "Lorem ipsum"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        alertConfigUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let tabBarVC = tabBarController as? TabBarViewController {
            tabBarVC.tabBar.isHidden = false
        }
    }
    
    func alertConfigUI() {
        
        title = "Notifications"
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navBarAppearance.backgroundColor = UIColor.white
                
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        view.backgroundColor = .white
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: NotifTableViewCell.identifier)
        return footer
    }
}
