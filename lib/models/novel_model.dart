///users/buk04i3CxXcdEvmod5UhT9DMCbU2/novel/1X0QDMJO5q91SuYZ3RDy
class NovelModel {
  String? id;
  String? title;
  String? synopsis;
  String? authorname;
  String? contact;
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
