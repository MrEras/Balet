import UIKit
import MapKit

class DetailVC: UIViewController {
    @IBOutlet var nameLab: UILabel!
    @IBOutlet var imgV: UIImageView!
    @IBOutlet var dispLab: UILabel!
    @IBOutlet var descLab: UILabel!
    var parking : Parking?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.45)
        self.showAnimate()
        self.configure(self.parking!)
    }
    
    @IBAction func close(_ sender: Any) {removeAnimate()}
    
    @IBAction func openInMaps(_ sender: Any) {
        let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 102.323 , longitude: 34.5), addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeTransit]
        mapItem.openInMaps(launchOptions: launchOptions)
    }
    
}
extension DetailVC {
    func configure(_ park: Parking){
        imgV.downloadedFrom(link: park.URLImg!)
        nameLab.text = " " + park.name!
        descLab.text = " " + park.description!
        dispLab.text = "Hay \(park.disp) lugares disponibles"
    }
}
