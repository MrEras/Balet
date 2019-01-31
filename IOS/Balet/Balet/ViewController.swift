import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet var parkyList: UITableView!
    var parkings = [Parking]()
    @IBAction func sideMenu(_ sender: Any) {
        let menuVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuVC") as! SideMenuViewController
        self.addChild(menuVC)
        menuVC.view.frame = self.view.frame
        self.view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
    }
    var ref: DatabaseReference!
    override var preferredStatusBarStyle: UIStatusBarStyle {return .lightContent}
    override func viewDidLoad() {
        super.viewDidLoad()
        parkyList.delegate = self
        parkyList.dataSource = self
        parkyList.tableFooterView = UIView()
        ref = Database.database().reference(withPath: "Parkings")
        ref.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                
                self.parkings.removeAll()
                
                for parkings in snapshot.children.allObjects as! [DataSnapshot] {
                    let parkingObject = parkings.value as? [String: AnyObject]
                    let pName  = parkingObject?["name"] as! String
                    let pID  = parkingObject?["id"] as! String
                    let pImage = parkingObject?["image"] as! String
                    let pDesc = parkingObject?["description"] as! String
                    let pPrice = parkingObject?["price"] as! String
                    let pSpaces = parkingObject?["spaces"] as! String
                    let pLat = parkingObject?["latitude"] as! String
                    let pLong = parkingObject?["longitude"] as! String
//                    let pPrice = parkingObject?["category"] as! String
//                    let pSpaces = parkingObject?["zone"] as! String
                    self.parkings.append(
                        Parking(pImage,pName,pDesc,pSpaces,
                                pPrice,pID,
                                Double(pLat) ?? 0.0,Double(pLong) ?? 0.0)
                    )
                }
                
                self.parkyList.reloadData()
            }
        })
    }
}
extension ViewController : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int{return 1}
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Selecciona para ver detalles"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.parkings.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = parkyList.dequeueReusableCell(withIdentifier: "parks", for: indexPath) as! ParkingCell
        cell.configureCell(parkings[indexPath.row])
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
        return 125
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopDetails") as! DetailVC
        popOverVC.parking = parkings[indexPath.row]
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
}
