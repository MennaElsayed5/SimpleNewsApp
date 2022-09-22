//
//  CatgoryOnboardingViewController.swift
//  NewsApp
//
//  Created by Menna on 21/09/2022.
//

import UIKit
class CatgoryOnboardingViewController: UIViewController {
    @IBOutlet weak var catgoryTb: UITableView!
    var catgoryArr = ["business","entertainment","general","health","science","sports","technology"]
    var items=[String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.catgoryTb.delegate=self
        self.catgoryTb.dataSource=self
        let catgoryCell = UINib(nibName: "CatgoryTableViewCell", bundle: nil)
        catgoryTb.register(catgoryCell, forCellReuseIdentifier: "CatgoryTableViewCell")
        catgoryTb.allowsSelectionDuringEditing=true
    }
 
    var arr = [String]()
    @IBAction func stattBtn(_ sender: Any) {
          let home = self.storyboard?.instantiateViewController(identifier: "TabBarViewController") as! TabBarViewController
        items.removeAll()
        if let selectedRow = catgoryTb.indexPathsForSelectedRows{
            for iPath in selectedRow{
               items.append(catgoryArr[iPath.row])
                Utilities.utilities.addArrCotgory(userCotgory: items)
            }
        }
          self.navigationController?.pushViewController(home, animated: true)
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
extension CatgoryOnboardingViewController: UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catgoryArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatgoryTableViewCell") as! CatgoryTableViewCell
        cell.name.text = catgoryArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        catgoryTb.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        catgoryTb.cellForRow(at: indexPath)?.accessoryType = .none

    }
    func tableView(_ tableView: UITableView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
        true
    }
    func tableView(_ tableView: UITableView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath) {
        catgoryTb.setEditing(true, animated: true)
    }
    func tableViewDidEndMultipleSelectionInteraction(_ tableView: UITableView) {
        print("\(#function)")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
