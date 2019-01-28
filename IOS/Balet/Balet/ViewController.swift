import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet var parkyList: UITableView!
    // Dictionary ->  "Name":"Description"
//    var cat1 = [Parking]()
    var cat1 = [
        Parking(webURL: "https://www.google.com/maps/about/images/mymaps/mymaps-desktop-16x9.png", name: "San Marcos 1", desc: "Justo frente al jardin ! O UNA DESCR chida",2)
    ]
    var cat2 = [
        Parking(webURL: "https://upload.wikimedia.org/wikipedia/en/b/b5/Apple_iOS_Maps.png", name: "San Marcos 2", desc: "Justo en la plaza men",5)
    ]
    var cat3 = [
        Parking(webURL: "https://upload.wikimedia.org/wikipedia/en/b/b5/Apple_iOS_Maps.png", name: "San Marcos 3", desc: "Justo en donde necesitas"),
        Parking(webURL: "https://hey.com/wp-content/uploads/heycom-logo-1200x600.jpg", name: "ISLA 1", desc: "Lado Norte, cajona D30 a D40 ?? ",1)
    ]
    //
    @IBAction func sideMenu(_ sender: Any) {
        let menuVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuVC") as! SideMenuViewController
        self.addChild(menuVC)
        menuVC.view.frame = self.view.frame
        self.view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
    }
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        parkyList.delegate = self
        parkyList.dataSource = self
        parkyList.tableFooterView = UIView()
        
        ref = Database.database().reference(withPath: "Parkings")
        ref.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                
                self.cat1.removeAll()
                
                for parkings in snapshot.children.allObjects as! [DataSnapshot] {
                    let parkingObject = parkings.value as? [String: AnyObject]
                    let pName  = parkingObject?["Name"] as! String
//                    let pID  = parkingObject?["id"] as! String
                    let pImage = parkingObject?["Image"] as! String
                    let pDesc = parkingObject?["Description"] as! String
                    
                    self.cat1.append(Parking(webURL:pImage, name:pName, desc:pDesc,1))
                }
                
                self.parkyList.reloadData()
            }
        })
    }
}
extension ViewController : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int{return 3}
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "1º    Categoria ($140/día O $30/hr)"
        case 1:
            return "2º    Categoria ($100/día O $20/hr)"
        case 2:
            return "3º    Categoria ($80/día O $10/hr)"
        default:
            return "Fail"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return cat1.count
        case 1:
            return cat2.count
        case 2:
            return cat3.count
        default:
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = parkyList.dequeueReusableCell(withIdentifier: "parks", for: indexPath) as! ParkingCell
        
        
        switch indexPath.section {
        case 0:
            cell.configureCell(cat1[indexPath.row])
        case 1:
            cell.configureCell(cat2[indexPath.row])
        case 2:
            cell.configureCell(cat3[indexPath.row])
        default:
            cell.textLabel?.text = "Fail"
        }
        
        cell.textLabel?.tintColor = #colorLiteral(red: 0.1757, green: 0.4306, blue: 0.9257, alpha: 1)
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        headerView.textLabel!.textColor = #colorLiteral(red: 0.1757, green: 0.4306, blue: 0.9257, alpha: 1)
        headerView.textLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        headerView.tintColor = .groupTableViewBackground
        headerView.backgroundColor = .clear
        headerView.textLabel?.textAlignment = .center
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopDetails") as! DetailVC
//        popOverVC.parking = indexPath.row //switch eso ?
        switch indexPath.section {
        case 0:
            popOverVC.parking = cat1[indexPath.row]
        case 1:
            popOverVC.parking = cat2[indexPath.row]
        case 2:
            popOverVC.parking = cat3[indexPath.row]
        default:
            popOverVC.parking = Parking(webURL: "htthgt", name: "fe", desc: "deerf")
        }
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
}
