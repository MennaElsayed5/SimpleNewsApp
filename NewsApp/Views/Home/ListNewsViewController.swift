//
//  ListNewsViewController.swift
//  NewsApp
//
//  Created by Menna on 20/09/2022.
//

import UIKit

class ListNewsViewController: UIViewController {
    @IBOutlet weak var newsTb: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newsTb.delegate=self
             self.newsTb.dataSource=self
        let newsCell = UINib(nibName: "NewsTableViewCell", bundle: nil)
              newsTb.register(newsCell, forCellReuseIdentifier: "NewsTableViewCell")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ListNewsViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
            return 230
       }
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 60
       }
    
}
