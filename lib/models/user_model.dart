//กำหนด class NovelModel เพื่อใช้เป็น model ในการเชื่อมต่อกับ firebase ใช้กับ การ login เเละสมัครสมาชิก
class UserModel {
  String? id; //เก็บรหัสสินค้า
  String? userName; //ชื่อ user
  bool? state;
  String? images; //ภาพ profile user
  String? contact; //ติดต่อ
  UserModel({
    this.id,
    this.userName,
    this.state,
    this.images,
    this.contact,
  });
  factory UserModel.fromMap(Map<String, dynamic>? users) {
    String id = users?['id'];
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
    return {
      'id': id,
      'userName': userName,
      'state': state,
      'images': images,
      'contact': contact,
    };
  }
}
