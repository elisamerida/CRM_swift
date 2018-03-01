//
//  PrincipalTableViewController.swift
//  P5_CRM
//
//  Created by Sofia Vidal Urriza on 24/11/2017.
//  Copyright © 2017 Sofia Vidal Urriza. All rights reserved.
//

import UIKit

class PrincipalTableViewController: UITableViewController {
    
    // Fechas qeu recibo de DatePickerVC
    var firstDate: Date = Date()
    var lastDate: Date = Date ()
    var showAllVisitsReq: Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //print (" 2 secciones")
        return 2 // Parte Usuario (sus visitas y favs) y Parte general (Todas ls visitas)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            //print("seccion1 con dos filas")
            return 2
        }
        if section == 1 {
            //print ("seccion 2 con una fila")
            return 1
        }else{
            return 0
        }
        
    }

    // Metodo para poner titulos a las secciones de la tabla (Diapo 14)
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String?{
        if section == 0 {
            //print("seccion1 con titulo")
            return " My account"
        }
        if section == 1 {
            //print("seccion2 con titulo")
            return "General"
        } else {
            return ""
        }
    }
    
    // Metodo para dibujar las filas dentro de cada seccion
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VisitCell", for: indexPath)

        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.textLabel?.text = "My visits"
            }
            if indexPath.row == 1 {
                cell.textLabel?.text = "My favourite visits"
            }
        }
        if indexPath.section == 1{
            cell.textLabel?.text = "All visits"
        }

        return cell
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Dependiendo de la seccion y fila seleccionada en la tabla principal pasaremos al sigueitne VC una url distinta
        
        // Cargamos el token del usuario
        let myToken = "2071ed41fff101fb2bd5"
        // URL para mostrar visitas del usuario/vendedor
        // todas las visitas del propietario del token de acceso
        let myVisitsURL = "https://dcrmt.herokuapp.com/api/users/tokenOwner/visits/flattened?token=\(myToken)"
        // URL para mostrar visitias que el usuario marca como favs
        // Para que solo se descarguen las visitas marcadas como favoritas se añade la query
        let myFavVisitsURL = "" + myVisitsURL + "&favourites=1"
        // URL que muestra todas las visitas para los vendedores
        // Para descargar de golpe todas las visitas incluyendo los datos de vendedores, clientes, fabricas, objetivos y tipos de objetivos
        let allVisitsURL = "https://dcrmt.herokuapp.com/api/visits/flattened?token=\(myToken)"
        
        print ("firstDate \(firstDate)")
        let finalFirstDate = createDateFormat(firstDate)
        print ("finalFirstDate \(finalFirstDate)")
        
        print ("lastDate \(lastDate)")
        let finalLastDate = createDateFormat(lastDate)
        print ("finalLastDate \(finalLastDate)")
        
        if segue.identifier == "GoToShowVisits"{
            
            if let svvc = segue.destination as? ShowVisitsTableViewController {
                
                let indexPath = tableView.indexPathForSelectedRow
                // My Account
                if indexPath?.section == 0 {
                    if indexPath?.row == 0 { // My visits
                        //svvc.strurl = myVisitsURL
                        svvc.strurl = "\(myVisitsURL)&dateafter=\(finalFirstDate)&datebefore=\(finalLastDate)" // svvc = Show Visits VC
                        svvc.tableTitle = "My Visits"
                    }
                    
                    if indexPath?.row == 1 { // My fav visits
                        //svvc.strurl = myFavVisitsURL
                        svvc.strurl = "\(myFavVisitsURL)&dateafter=\(finalFirstDate)&datebefore=\(finalLastDate)"
                        svvc.tableTitle = "My Favourite Visits"
                    }
                }
                // General
                if indexPath?.section == 1{
                    //svvc.strurl = allVisitsURL
                    svvc.strurl = "\(allVisitsURL)&dateafter=\(finalFirstDate)&datebefore=\(finalLastDate)"
                    svvc.tableTitle = "All Visits"
                    svvc.showAllVisitsReq = true
                }
                
            } // if let
        }
        
    }
    
    // Para volver desde Date Picker -> UNWIND
    @IBAction func GoBackToVisitss (segue:UIStoryboardSegue) {
        self.tableView.reloadData()
    }

    func createDateFormat(_ date: Date) -> String {
        let df = ISO8601DateFormatter()
        df.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
        
        let s = df.string(from: date)
        let d = df.date(from: s)
        let str3 =  ISO8601DateFormatter.string(from: d!, timeZone: .current, formatOptions: [.withFullDate])
        return str3
    }

}
