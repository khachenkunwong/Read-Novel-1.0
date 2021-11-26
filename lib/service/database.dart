// ใช้เพื่อติดต่อและจัดการข้อมูลไปยังฐานข้อมูลไปยังฐานข้อมูล Cloud Firestore เช้นการติดตามข้อมูลสินค้า การเพิ่มข้อมูล
// การแก้ไขข้อมูล และการลบข้อมูลสินค้า
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:read_novel/models/episode_model.dart';
import 'package:read_novel/models/novel_model.dart';
import 'package:read_novel/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

//ติดต่อกับ firebase
class Database {
  static Database instance = Database._();
  Database._();
  Future getFirebaseStore() async {
    firebase_storage.Reference ref = await firebase_storage
        .FirebaseStorage.instance
        .ref('folderName/imageName.png');
    return ref;
// or
    //  firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
    // .ref()
    // .child('images')
    // .child('defaultProfile.png');
  }

  // Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
  //     Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  // Future<List<FirebaseFile>> listAll() async {
  //   final _auth = firebase_auth.FirebaseAuth.instance;
  //   firebase_auth.User? _user;
  //   _user = _auth.currentUser;
  //   final ref = FirebaseStorage.instance.ref('${_user?.uid}/');
  //   final result = await ref.listAll();

  //   final urls = await _getDownloadLinks(result.items);
  //   print(urls[0]);
  //   updateStateUser(users: UserModel(images: urls[0]));

  //   return urls
  //       .asMap()
  //       .map((index, url) {
  //         final ref = result.items[index];
  //         final name = ref.name;
  //         final file = FirebaseFile(ref: ref, name: name, url: url);

  //         return MapEntry(index, file);
  //       })
  //       .values
  //       .toList();
  // }

  Future<void> updateStateUser({UserModel? users}) {
    final reference = FirebaseFirestore.instance.collection('users');
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;

    return reference
        .doc(_user?.uid)
        .update({
          'images': users?.images,
        })
        .then((value) => print("อัพรูป"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> deleteNovel({NovelModel? novel}) async {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    final reference0 = FirebaseFirestore.instance
        .collection('users')
        .doc('${_user?.uid}')
        .collection('novel')
        .doc('${novel?.id}')
        .collection('episode');
    final reference1 = FirebaseFirestore.instance
        .collection('users')
        .doc('${_user?.uid}')
        .collection('novel')
        .doc('${novel?.id}');

    print('novel?.id = ${novel?.id}');
    final reference2 = FirebaseFirestore.instance
        .collection('read')
        .doc('${novel?.id}')
        .collection('novel');
    final reference3 =
        FirebaseFirestore.instance.collection('read').doc('${novel?.id}');

    // final reference = FirebaseFirestore.instance.doc('Order/${order?.id}');
    try {
      reference0.snapshots().forEach((element) {
        for (QueryDocumentSnapshot snapshot in element.docs) {
          snapshot.reference.delete();
        }
      });
      await reference1.delete();
      reference2.snapshots().forEach((element) {
        for (QueryDocumentSnapshot snapshot in element.docs) {
          snapshot.reference.delete();
        }
      });

      await reference3.delete();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> deleteEpisode({NovelModel? novel, EpisodeModel? episode}) async {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    final reference = FirebaseFirestore.instance
        .collection('users')
        .doc('${_user?.uid}')
        .collection('novel')
        .doc('${novel?.id}')
        .collection('episode')
        .doc('${episode?.chapternumber}');
    // final reference = FirebaseFirestore.instance.doc('Order/${order?.id}');
    try {
      await reference.delete();
    } catch (err) {
      rethrow;
    }
  }
  // Stream searchID() {
  //   final reference = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc('HbhZH0dOJ9gCPPEDP8rMal1c9rB2')
  //       .snapshots();
  //   // referenct = Stream<DocumentSnapshot<Map<String, dynamic>>>
  //   // show data in document
  //   var aa = reference.listen((data) {
  //     print(data.data());
  //   });
  //   print('reference = ${reference}');
  //   return reference;

  //   // .document(documentId)
  //   // .snapshots();
  // }

  Stream<List<NovelModel>> getNovel() {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    final reference = FirebaseFirestore.instance
        .collection('users')
        .doc('${_user?.uid}')
        .collection('novel');
    //เรียงเอกสารจากมากไปน้อย โดยใช้ ฟิลด์ id
    final snapshots = reference.snapshots();
    //QuerySnapshot<Map<String, dynamic>> snapshot
    //QuerySnapshot<Object?> snapshot
    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        return NovelModel.fromMap(doc.data());
      }).toList();
    });
  }

  Stream<List<EpisodeModel>> getEpisode({NovelModel? novel}) {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    final reference = FirebaseFirestore.instance
        .collection('users')
        .doc('${_user?.uid}')
        .collection('novel')
        .doc('${novel?.id}')
        .collection('episode');
    //เรียงเอกสารจากมากไปน้อย โดยใช้ ฟิลด์ id
    final snapshots = reference.snapshots();
    //QuerySnapshot<Map<String, dynamic>> snapshot
    //QuerySnapshot<Object?> snapshot
    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        return EpisodeModel.fromMap(doc.data());
      }).toList();
    });
  }

  Stream<List<NovelModel>> getReadNovel() {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    final reference = FirebaseFirestore.instance.collection('read');

    //เรียงเอกสารจากมากไปน้อย โดยใช้ ฟิลด์ id
    final snapshots = reference.snapshots();
    //QuerySnapshot<Map<String, dynamic>> snapshot
    //QuerySnapshot<Object?> snapshot
    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        return NovelModel.fromMap(doc.data());
      }).toList();
    });
  }

  Stream<List<EpisodeModel>> getReadEpisode({NovelModel? novel}) {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    final reference = FirebaseFirestore.instance
        .collection('read')
        .doc('${novel?.id}')
        .collection('novel');

    //เรียงเอกสารจากมากไปน้อย โดยใช้ ฟิลด์ id
    final snapshots = reference.snapshots();
    //QuerySnapshot<Map<String, dynamic>> snapshot
    //QuerySnapshot<Object?> snapshot
    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        return EpisodeModel.fromMap(doc.data());
      }).toList();
    });
  }

  Future<void> updatetitle({NovelModel? novel}) {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    final reference = FirebaseFirestore.instance
        .collection('users')
        .doc('${_user?.uid}')
        .collection('novel');

    return reference
        .doc('${novel?.id}')
        .update({
          'title': novel?.title,
        })
        .then((value) => print("อัพ ชื่อเรื่องนิยาย"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updateSynopsis({NovelModel? novel}) {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    final reference = FirebaseFirestore.instance
        .collection('users')
        .doc('${_user?.uid}')
        .collection('novel');

    return reference
        .doc('${novel?.id}')
        .update({
          'synopsis': novel?.synopsis,
        })
        .then((value) => print("อัพ เรื่องย่อเเล้ว"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updateauthorname({NovelModel? novel}) {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    final reference = FirebaseFirestore.instance
        .collection('users')
        .doc('${_user?.uid}')
        .collection('novel');

    return reference
        .doc('${novel?.id}')
        .update({
          'authorname': novel?.authorname,
        })
        .then((value) => print("อัพ ชื่อผู้แต่งเเล้ว"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updatecontact({NovelModel? novel}) {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    final reference = FirebaseFirestore.instance
        .collection('users')
        .doc('${_user?.uid}')
        .collection('novel');

    return reference
        .doc('${novel?.id}')
        .update({
          'contact': novel?.contact,
        })
        .then((value) => print("อัพ ติดต่อแล้ว"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updateChapterName({NovelModel? novel, EpisodeModel? episode}) {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    final reference = FirebaseFirestore.instance
        .collection('users')
        .doc('${_user?.uid}')
        .collection('novel')
        .doc('${novel?.id}')
        .collection('episode');

    return reference
        .doc('${episode?.chapternumber}')
        .update({
          'chapterName': episode?.chapterName,
        })
        .then((value) => print("อัพ ชื่อตอนเเล้ว"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updateEpisodecontent(
      {NovelModel? novel, EpisodeModel? episode}) {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    final reference = FirebaseFirestore.instance
        .collection('users')
        .doc('${_user?.uid}')
        .collection('novel')
        .doc('${novel?.id}')
        .collection('episode');

    return reference
        .doc('${episode?.chapternumber}')
        .update({
          'episodecontent': episode?.episodecontent,
        })
        .then((value) => print("อัพ เนื้อหาในตอนเเล้ว"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updateEpisodeState(
      {NovelModel? novel, EpisodeModel? episode}) {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    final reference = FirebaseFirestore.instance
        .collection('users')
        .doc('${_user?.uid}')
        .collection('novel')
        .doc('${novel?.id}')
        .collection('episode');

    return reference
        .doc('${episode?.chapternumber}')
        .update({
          'chapterName': episode?.chapterName,
          'episodecontent': episode?.episodecontent,
          'state': episode?.state,
          
          
        })
        .then((value) => print("อัพ สถานว่าเพยแพร่หรือยัง"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updateNameUser({UserModel? users}) {
    final reference = FirebaseFirestore.instance.collection('users');
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;

    return reference
        .doc(_user?.uid)
        .update({
          'userName': users?.userName,
        })
        .then((value) => print("อัพชื่อ"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updateContactUser({UserModel? users}) {
    final reference = FirebaseFirestore.instance.collection('users');
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;

    return reference
        .doc(_user?.uid)
        .update({
          'contact': users?.contact,
        })
        .then((value) => print("อัพ ติดต่อ"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Stream<DocumentSnapshot> getProfile() {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    final reference =
        FirebaseFirestore.instance.collection('users').doc('${_user?.uid}');
    //เรียงเอกสารจากมากไปน้อย โดยใช้ ฟิลด์ id
    final snapshots = reference.snapshots();
    // Stream<DocumentSnapshot<Map<String, dynamic>>> snapshots
    return snapshots.map((snapshot) {
      return snapshot;
    });
  }

  Stream<List<UserModel>> getStateUser() {
    final reference = FirebaseFirestore.instance.collection('users');
    //เรียงเอกสารจากมากไปน้อย โดยใช้ ฟิลด์ id
    final snapshots = reference.snapshots();
    //QuerySnapshot<Map<String, dynamic>> snapshot
    //QuerySnapshot<Object?> snapshot
    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserModel.fromMap(doc.data());
      }).toList();
    });
  }

  Future<void> setNovel({NovelModel? novel}) async {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    final reference = FirebaseFirestore.instance
        .collection('users')
        .doc('${_user?.uid}')
        .collection('novel')
        .doc('${novel?.id}');
    // doc('users/SGxI1a2Zq9MKsTFvlGYzffd9aBn2/novel')
    try {
      await reference.set(novel!.toMap());
    } catch (err) {
      rethrow;
    }
  }

  Future<void> setReadNovel({NovelModel? novel, EpisodeModel? episode}) async {
    final reference_novel =
        FirebaseFirestore.instance.collection('read').doc('${novel?.id}');
    final reference_episode = FirebaseFirestore.instance
        .collection('read')
        .doc('${novel?.id}')
        .collection('novel')
        .doc('${episode?.chapternumber}');

    // doc('users/SGxI1a2Zq9MKsTFvlGYzffd9aBn2/novel')
    try {
      await reference_novel.set(novel!.toMap());
      await reference_episode.set(episode!.toMap());
    } catch (err) {
      rethrow;
    }
  }

  Future<void> setEpisode({NovelModel? novel, EpisodeModel? episode}) async {
    final _auth = firebase_auth.FirebaseAuth.instance;
    firebase_auth.User? _user;
    _user = _auth.currentUser;
    final reference = FirebaseFirestore.instance
        .collection('users')
        .doc('${_user?.uid}')
        .collection('novel')
        .doc('${novel?.id}')
        .collection('episode')
        .doc('${episode?.chapternumber}');
    // doc('users/SGxI1a2Zq9MKsTFvlGYzffd9aBn2/novel/novel.id/episode')
    try {
      print('สร้างตอนนิยาย');
      await reference.set(episode!.toMap());
    } catch (err) {
      rethrow;
    }
  }

  Future<void> setUser({UserModel? users}) async {
    final reference = FirebaseFirestore.instance.doc('users/${users?.id}');
    try {
      await reference.set(users!.toMap());
    } catch (err) {
      rethrow;
    }
  }
}
