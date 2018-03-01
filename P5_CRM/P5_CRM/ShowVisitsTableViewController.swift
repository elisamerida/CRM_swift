//
//  ShowVisitsTableViewController.swift
//  P5_CRM
//
//  Created by Sofia Vidal Urriza on 25/11/2017.
//  Copyright © 2017 Sofia Vidal Urriza. All rights reserved.
//

import UIKit

class ShowVisitsTableViewController: UITableViewController {
    
    var strurl: String!
    var tableTitle: String!
    var showAllVisitsReq: Bool!
    // Array de visitas
    var visits: [Visit] = []
    // url session
    var session = URLSession.shared // Comparte todas las apps con la misma cahce 
    // cahce de fotos
     var cacheIMG = [String: UIImage]() //dic string url con la foto bajada
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = tableTitle
        
        downloadVisits()
        tableView.reloadData()
    }
    
    // Metodo que descarga las visitas con url session
    private func downloadVisits(){
        //print ("primero \(strurl)")
        let queue = DispatchQueue.global()
        queue.async {
            if let url = URL(string: self.strurl){
                if let data = try? Data(contentsOf: url) {
                //print ("segundo \(strurl)")
                    let decoder = JSONDecoder()
                    let v = try? decoder.decode([Visit].self, from: data)
                    //print("primero \(visits.count)")
                    DispatchQueue.main.async {
                        self.visits = v!
                        //print("segundo \(self.visits.count)")
                        self.tableView.reloadData()
                
                    }
                } else {
                   print ("Error al descargar")
                    let alert = UIAlertController(title: "ERROR", message: "Check your internet connection. Please introduce the again. ", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert,animated: true)
                }
        
            } else {
                print ("Error en la formacion de la url")
                print ("Error al descargar")
                let alert = UIAlertController(title: "ERROR", message: "URL formation error. Please try again. ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert,animated: true)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //print("\(visits.count)")
        return visits.count
        //return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell: CustomCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "showVisitCell", for: indexPath) as! CustomCellTableViewCell
        //let cell = tableView.dequeueReusableCell(withIdentifier: "showVisitCell", for: indexPath)
       
        // PRIMERO VACIO
        cell.mainTitleName.text = ""
        cell.subtitleDate.text = ""
        cell.targetName.text = ""
        //cell.textLabel?.text = ""
        //cell.detailTextLabel?.text = ""
        
      // Titulo Celda
        if (visits.count != 0){
            if showAllVisitsReq == true {
                cell.mainTitleName.text = visits[indexPath.row].Salesman.fullname
                //cell.textLabel?.text = visits[indexPath.row].Salesman.fullname
            } else {
                cell.mainTitleName.text = visits[indexPath.row].Customer.name
                //cell.textLabel?.text = visits[indexPath.row].Customer.name
            }
            // Subtitulo Celda
            let plannedDate = visits[indexPath.row].plannedFor
            let df = ISO8601DateFormatter()
            df.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
            if let d = df.date(from: plannedDate) {
               // Convertir una Date en un String solo con la fecha ISO8601:
                let str3 = ISO8601DateFormatter.string(from: d, timeZone: .current, formatOptions: [.withFullDate])
                cell.subtitleDate.text = str3
                //cell.detailTextLabel?.text = str3
            }
            
            // Imagen
            let salesman = visits[indexPath.row].Salesman
            if let sManImg = salesman.Photo {
                if let img = cacheIMG[sManImg.url]{
                    cell.visitImage.image = img
                    //cell.imageView?.image = img
                } else {
                    updatePhoto(sManImg.url, for: indexPath)
                }
            }
            
            let targetName = visits[indexPath.row].Salesman
                if let
        }
        
        return cell
    }
    // Funcion que descarga la imagen si no se encuentra en el Dicc cache
    func updatePhoto(_ strurl: String, for indexPath: IndexPath){
        DispatchQueue.global().async {
            if let url = URL(string: strurl), let data = try? Data(contentsOf: url), let img = UIImage(data: data){
                DispatchQueue.main.async {
                    self.cacheIMG[strurl] = img
                    self.tableView.reloadRows(at: [indexPath], with: .left)
                }
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
