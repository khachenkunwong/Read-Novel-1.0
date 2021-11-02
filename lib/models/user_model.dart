//ใช้เพื่อกำหนดเค้าโครงข้อมูลของสินค้า ซึ่งใช้เก็บข้อมูลที่ได้มาจากฐานข้อมูล และถูกนำมาใช้ในการแสดงผล
class UserModel {
  String? id; //เก็บรหัสสินค้า
  String? userName; //เก็บชื่อสินค้า
  bool? state;
  String? images;
  String? contact;
  UserModel({
    this.id,
    this.userName,
    this.state,
    this.images,
    this.contact,
  });
  factory UserModel.fromMap(Map<String, dynamic>? users) {
    // factory นำหน้า แสดงว่าภายในคอนสตรัคเตอร์ จะต้องรีเทิร์นค่ากลับมาเป็นออบเจ็กต์ของคลาส UserModel
    //ใส่ ? เเทนการเขียนโคต if (product == null) {return null;}
    String id =
        users?['id']; //ข้อมูล id เก็บค่าที่ได้มาจากฟิลด์ id ของฐานข้อมูล
    String userName = users?['userName'];
    bool state = users?['state'];
    String images = users?['images'];
    String contact = users?['contact'];
    return UserModel(
        id: id,
        userName: userName,
        state: state,
        images: images,
        contact: contact);
  }
  Map<String, dynamic> toMap() {
    //สร้างเพื่อเเปลง พร็อพเพอณ์ตี้ภายในออบเจ็กต์ ให้เป็น Map<String, dynamic>ซึ่งเป็นประเภทข้อมูลที่เหมาะสำหรับ Cloud Firestore
    return {
      'id': id,
      'userName': userName,
      'state': state,
      'images': images,
      'contact': contact,
    };
  }
}
