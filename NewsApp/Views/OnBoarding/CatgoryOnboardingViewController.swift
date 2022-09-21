//
//  CatgoryOnboardingViewController.swift
//  NewsApp
//
//  Created by Menna on 21/09/2022.
//

import UIKit
struct selectModel{
    var name: String
    var isSelected: Bool
    
}
class CatgoryOnboardingViewController: UIViewController {
    @IBOutlet weak var catgoryTb: UITableView!
    var countaryName : String?
    var catgoryArr = [selectModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.catgoryTb.delegate=self
        self.catgoryTb.dataSource=self
        print("countaryName\(countaryName)")
        let catgoryCell = UINib(nibName: "CatgoryTableViewCell", bundle: nil)
        catgoryTb.register(catgoryCell, forCellReuseIdentifier: "CatgoryTableViewCell")
        appendData()
        // Do any additional setup after loading the view.
    }
 
    func appendData(){
        catgoryArr = [selectModel(name: "business", isSelected: false),
                      selectModel(name: "entertainment", isSelected: false),
                      selectModel(name: "general", isSelected: false),
                      selectModel(name: "health", isSelected: false),
                      selectModel(name: "science", isSelected: false),
                      selectModel(name: "sports", isSelected: false),
                      selectModel(name: "technology", isSelected: false),
        ]
    }
    @IBAction func stattBtn(_ sender: Any) {
          let home = self.storyboard?.instantiateViewController(identifier: "ListNewsVC") as! ListNewsViewController
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

        cell.name.text = catgoryArr[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let home = self.storyboard?.instantiateViewController(identifier: "ListNewsVC") as! ListNewsViewController
       //  catgory.countaryName = lableCountry.text
        home.countryName = countaryName
        home.catgory = catgoryArr[indexPath.row].name
         self.navigationController?.pushViewController(home, animated: true)
    }
}
