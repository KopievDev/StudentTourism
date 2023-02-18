//
//  DataSource.swift
//  Festa
//
//  Created by Ivan Kopiev on 04.10.2022.
//

import UIKit

struct Cell {
    var reuseId: String
    var data: [String:Any?] = [:]
    
    static func createCellsFor(cell: ReusableCell.Type, elements: [[String : Any?]]) -> [Cell] {
        elements.map { Cell(reuseId: cell.reuseId, data: $0) }
    }
	
	static func createCellFor(cell: ReusableCell.Type, element: [String : Any?]) -> Cell {
		return Cell(reuseId: cell.reuseId, data: element)
	}
}

typealias Cells = [Cell]
typealias FloatBlock = (CGFloat?) -> Void

protocol Listable: UITableViewDataSource {
    var tableView: UITableView? { get set }
    var data: Cells { set get }
    var didReload: VoidBlock? { get set }
    var contentHeight: FloatBlock? { get set }
    func set(data: Cells?)
    func set(tableView: UITableView?)
    func data(for indexPath: IndexPath) -> Cell
}

    
extension Listable {
    func data(for indexPath: IndexPath) -> Cell { data[indexPath.row] }
    func set(data: Cells?) {
        guard let data = data else { return }
        self.data = data
//        tableView?.reloadData()
        UIView.performWithoutAnimation { self.tableView?.reloadData() }
        tableView?.layoutIfNeeded()
//        tableView?.isScrollEnabled = tableView?.contentSize.height ?? 0 >= tableView?.bounds.height ?? 0
        didReload?()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            self.contentHeight?(self.tableView?.contentSize.height ?? 0)
        }
    }
    
    func set(tableView: UITableView?) {
        self.tableView = tableView
        tableView?.dataSource = self
        UIView.performWithoutAnimation { self.tableView?.reloadData() }
//        tableView?.reloadData()
        didReload?()
        contentHeight?(tableView?.contentSize.height ?? 0)
    }
}

final class DataSource: NSObject, Listable {
    
    weak var tableView: UITableView?
    var data: Cells = []
    var didReload: VoidBlock?
    var contentHeight: FloatBlock?
    
    init(tableView: UITableView? = nil, data: Cells = []) {
        super.init()
        set(tableView: tableView)
        set(data: data)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { data.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: model.reuseId, for: indexPath)
        (cell as? ReusableCell)?.render(data: model.data)
        return cell
    }
}


class TableVC: BaseVC {
    @IBOutlet var tableView: UITableView!
    lazy var dataSource: Listable = DataSource(tableView: tableView, data: cells)
    var cells: Cells = [] {
        didSet { dataSource.set(data: cells) }
    }
}

class TableView: BaseView {
    @IBOutlet var tableView: UITableView!
    lazy var refresh = UIRefreshControl()
    let isNeedUpdate = Dinamic<Bool>(false)
    lazy var dataSource: Listable = DataSource(tableView: tableView, data: cells)
    var cells: Cells = [] {
        didSet { renderCell() }
    }
    
    func renderCell() {
        dataSource.set(data: cells)
    }
    
    func addRefresh() {
        refresh.addTarget(self, action: #selector(needUpdateContacts), for: .valueChanged)
        tableView.refreshControl = refresh
    }
    
    @objc func needUpdateContacts(_ refresh: UIRefreshControl) {
        isNeedUpdate.value = refresh.isRefreshing
    }
}

extension Dictionary {
    
    subscript(ac idx: Key) -> [Cell] {
        get {
            return self[idx] as? [Cell] ?? []
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(ac0 idx: Key) -> [Cell]? {
        get {
            return self[idx] as? [Cell]
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
}

final class ContentSizedTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height + 10)
    }
}
