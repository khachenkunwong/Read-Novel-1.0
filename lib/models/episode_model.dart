//ใช้เพื่อกำหนดเค้าโครงข้อมูลของสินค้า ซึ่งใช้เก็บข้อมูลที่ได้มาจากฐานข้อมูล และถูกนำมาใช้ในการแสดงผล
class EpisodeModel {
  String? chapternumber; //เก็บรหัสสินค้า
  String? chapterName; //เก็บชื่อสินค้า
  bool? state;
  bool? statelock;
  String? images;
  String? episodecontent;
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
    //ใส่ ? เเทนการเขียนโคต if (product == null) {return null;}
    String chapternumber =
        users?['chapternumber']; //ข้อมูล id เก็บค่าที่ได้มาจากฟิลด์ id ของฐานข้อมูล
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
