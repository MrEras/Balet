import Foundation
import UIKit

class Parking{
    var URLImg: String?
    var name: String?
    var description: String?
    var disp: String = ""
    var price: String = ""
    var id: String = ""//no se usa
    var lat: Double = 0.0
    var long: Double = 0.0
//    var zone: Int = 0.0
//    var category: Double = 0.0
    
    init(_ inURL: String,
         _ inName: String,
         _ inDesc: String,
         _ dispo:String? = "",
         _ price:String? = "",
         _ id:String? = "",
         _ lat:Double = 0.0,
         _ long:Double = 0.0
        ) {
            self.URLImg = inURL
            self.name = inName
            self.description = inDesc
            self.disp = dispo!
            self.price = price!
            self.id = id!
            self.lat = lat
            self.long = long
    }
}
class ParkingCell : UITableViewCell{
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var nameLab: UILabel!
    @IBOutlet var descLab: UILabel!
    @IBOutlet var dispLab: UILabel!
    
    override func awakeFromNib() {super.awakeFromNib()}
    
    func configureCell(_ park: Parking){
        imgView.downloadedFrom(link: park.URLImg!)
        nameLab.text = park.name!
        descLab.text = park.description! + "\n Lugares disponibles: \(park.disp)"
        dispLab.text = "Precio: $\(park.price)"
    }
}
