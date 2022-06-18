class FurnitureModel {
  String? name;
  String? uid;
  String? image;
  String? namefurniture;
  String? description;
  List? furnitureImage;
  String? date;
  String? price;
  String? furnitureid;
  bool? isfav;
  bool? isnegotiate;
  String? furniture;
  String? type;

  FurnitureModel(
      {this.name,
        this.uid,
        this.image,
        this.namefurniture,
        this.description,
        this.furnitureImage,
        this.price,
        this.date,
        this.furnitureid,
        this.isfav,
        this.isnegotiate,
        this.furniture,
        this.type,
      });

  FurnitureModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
    image = json['image'];
    namefurniture = json['namePost'];
    description = json['description'];
    furnitureImage = json['furnitureImage'];
    price = json['price'];
    date = json['date'];
    furnitureid = json['postid'];
    isfav = json['isfav'];
    isnegotiate = json['isnegatiated'];
    furniture = json['furniture'];
    type = json['type'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'image': image,
      'namefurniture': namefurniture,
      'description': description,
      'furnitureImage': furnitureImage,
      'price': price,
      'date': date,
      'furnitureid': furnitureid,
      'isfav': isfav,
      'isnegotiate': isnegotiate,
      'furniture' : furniture,
      'type' : type,
    };
  }
}
