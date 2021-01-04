//
//  NewsVC.swift
//  iOS_basics
//
//  Created by Arnaud SCHEID on 09/12/2020.
//

import SafariServices
import UIKit

final class NewsVC: UITableViewController {
    private var presenter: NewsPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = NewsPresenter()

        self.view.backgroundColor = Colors.background

        tableView.reloadData()
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refresh
//        tableView.refreshControl = refreshControl
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppManager.news.news?.results.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsCell;
    
        cell.contentView.backgroundColor = Colors.background
        cell.txt.text = AppManager.news.news?.results[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: AppManager.news.news?.results[indexPath.row].url ?? "https://cryptonews.com") {
            let svc = SFSafariViewController(url: url)
            present(svc, animated: true, completion: nil)
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        AppManager.network.loadNews()
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
}
