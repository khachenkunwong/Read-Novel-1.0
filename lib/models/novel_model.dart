//กำหนด class NovelModel เพื่อใช้เป็น model ในการเชื่อมต่อกับ firebase ใช้กับ นิยาย
class NovelModel {
  String? id; //เก๊บ id ตอนนิยาย
  String? title; //ชื่อเรื่อง
  String? synopsis; //เรื่องย่อ
  String? authorname; // ชื่อผู้เเต่ง
  String? contact; // ติดต่อ
  NovelModel({
     this.id,
     this.title,
     this.synopsis,
     this.authorname,
     this.contact,
  });
  factory NovelModel.fromMap(Map<String, dynamic>? users) {
    String id = users?['id'];
    String title = users?['title'];
    String synopsis = users?['synopsis'];
    String authorname = users?['authorname'];
    String contact = users?['contact'];
    return NovelModel(
        id: id,
        title: title,
        synopsis: synopsis,
        authorname: authorname,
        contact: contact);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'synopsis': synopsis,
      'authorname': authorname,
      'contact': contact,
    };
  }
}
