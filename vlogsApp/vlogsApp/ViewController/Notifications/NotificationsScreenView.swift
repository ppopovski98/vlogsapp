//
//  NotificationsScreenView.swift
//  vlogsApp
//
//  Created by Petar Popovski on 15.8.23.
//

import UIKit
import SnapKit

class NotificationsScreenView: UIView {
    
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
    
    override init (frame: CGRect){
        super.init(frame: .zero)
        
        alertConfigUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func alertConfigUI() {
        
        backgroundColor = UIColor(named: "background".localized())
        
        addSubview(notifTableView)

        notifTableView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview().inset(12)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
}
