//
//  CMPlayerListViewController.swift
//  Colour Memory
//
//  Created by MOHD IMRAN on 25/02/17.
//  Copyright © 2017 MOHD IMRAN. All rights reserved.
//

import UIKit

class CMPlayerListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblPlayer:UITableView?
    var arrPlayers:Array<Player> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Player List"
        self.navigationController?.navigationBar.backItem?.title = ""
        
        if let arr = CMDataBaseManager.sharedManager.getPlayerList(){
            
            self.arrPlayers = arr
            self.tblPlayer?.reloadData()
        }
        
        self.tblPlayer?.allowsSelection = false
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -  TableView Delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as? CMPlayerTableViewCell{
            
            cell.fillUI(obj: arrPlayers[indexPath.row],indexRow: indexPath.row)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrPlayers.count
    }
    
}
