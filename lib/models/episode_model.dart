//กำหนด class EpisodeModel เพื่อใช้เป็น model ในการเชื่อมต่อกับ firebase ใช้กับตอนนิยาย
class EpisodeModel {
  String? chapternumber; //เก็บรหัสตอน
  String? chapterName; //เก็บชื่อตอน
  bool? state; 
  bool? statelock; // เอาไว้เช็คว่า lockตอนหรือไม่
  String? images; // ภาพของตอน
  String? episodecontent; //เนื้อหาตอน
  EpisodeModel({
    this.chapternumber,
    this.chapterName,
    this.state,
    this.statelock,
    this.images,
    this.episodecontent,
  });
  factory EpisodeModel.fromMap(Map<String, dynamic>? users) {
    // factory นำหน้า แสดงว่าภายในคอนสตรัคเตอร์ จะต้องรีเทิร์นค่ากลับมาเป็นออบเจ็กต์ของคลาส EpisodeModel
    
    String chapternumber =
        users?['chapternumber']; //ข้อมูล chapternumber เก็บค่าที่ได้มาจากฟิลด์ chapternumber ของฐานข้อมูล
    String chapterName = users?['chapterName'];
    bool state = users?['state'];
    bool statelock = users?['statelock'];
    String images = users?['images'];
    String episodecontent = users?['episodecontent'];
    return EpisodeModel(
        chapternumber: chapternumber,
        chapterName: chapterName,
        state: state,
        statelock: statelock,
        images: images,
        episodecontent: episodecontent);
  }
  Map<String, dynamic> toMap() {
    //สร้างเพื่อเเปลง พร็อพเพอณ์ตี้ภายในออบเจ็กต์ ให้เป็น Map<String, dynamic>ซึ่งเป็นประเภทข้อมูลที่เหมาะสำหรับ Cloud Firestore
    return {
      'chapternumber': chapternumber,
      'chapterName': chapterName,
      'state': state,
      'statelock':statelock,
      'images': images,
      'episodecontent': episodecontent,
    };
  }
}
