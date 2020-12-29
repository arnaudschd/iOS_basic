//
//  NewsVC.swift
//  iOS_basics
//
//  Created by Arnaud SCHEID on 09/12/2020.
//

import Foundation
import UIKit

final class NewsVC: UITableViewController {

    private var presenter: NewsPresenter!
    
    override func viewDidLoad() {
        presenter = NewsPresenter()

        self.view.backgroundColor = Colors.background

        tableView.reloadData()
        
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
            UIApplication.shared.open(url)
        }
    }
}
