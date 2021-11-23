import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:read_novel/models/novel_model.dart';
import 'package:read_novel/service/database.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'edit_add.dart';
import 'episode_write.dart';
import 'package:uuid/uuid.dart';
//หน้าผลงานของฉัน
class MyworkWidget extends StatefulWidget {
  MyworkWidget({Key? key}) : super(key: key);

  @override
  _MyworkWidgetState createState() => _MyworkWidgetState();
}

class _MyworkWidgetState extends State<MyworkWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Database db = Database.instance;
  // ทำการสุ่ม id เพื่อนำไปใส่ id สร้างนิยาย
  var uuid = Uuid();

  // Future upNovel()async {

  // }

  @override
  Widget build(BuildContext context) {
    print('uuid === ${uuid.v4()}');
    // เรื่อกใช้ getNovel เพื่อจะได้เอาไปใส่ StreamBuilder ตรง stream
    Stream<List<NovelModel>> state = db.getNovel();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                flex: 0,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ผลงานของฉัน',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        iconSize: 60,
                        icon: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 30,
                        ),
                        onPressed: () async {
                          try {
                            // ทำการสร้างนิยาย โดยเรียกใช้ setNovel
                            await db.setNovel(
                              //กำหนดรายละเดียดของนิยายลงใน NovelModel
                              novel: NovelModel(
                                id: '${uuid.v4()}',
                                title: 'ชื่อเรื่อง',
                                synopsis: 'เรื่องย่อ',
                                authorname: 'ชื่อผู้แต่ง',
                                contact: 'ติอต่อ',
                              ),
                            );
                          } catch (err) {
                            print(err);
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: StreamBuilder<List<NovelModel>>(
                  stream: state,
                  builder: (context, snapshot1) {
                    if (snapshot1.hasData) {
                      if (snapshot1.data?.length == 0) {
                        return Center(
                          child: Text('ยังไม่มีนิยายของคุณ'),
                        );
                      }

                      return Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: double.infinity,
                          //แสดง นิยายทั้งหมด
                          child: ListView.builder(
                              itemCount: snapshot1.data?.length,
                              itemBuilder: (context, index) {
                                // Slidable คือตัวเลื่อนเเล้วมีตัวเลือก
                                return Slidable(
                                  actionPane: SlidableScrollActionPane(),
                                  actions: [
                                    IconSlideAction(
                                      caption: 'ลบ',
                                      color: Colors.red,
                                      icon: Icons.delete,
                                      // ลบ
                                      onTap: () => db.deleteNovel(
                                          novel: NovelModel(
                                        id: snapshot1.data?[index].id,
                                      )),
                                    ),
                                    IconSlideAction(
                                      caption: 'เเก้ไข',
                                      color: Colors.green,
                                      icon: Icons.edit_outlined,
                                      // ไปยังหน้าแก้ไข
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          // ส่ง index ของนิยายกับ id ไป
                                          builder: (context) => EditAddWidget(
                                              page: 2,
                                              index_novel: index,
                                              data: snapshot1.data?[index].id),
                                        ),
                                      ),
                                    ),
                                  ],
                                  child: Container(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          1, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 2, 0, 0),
                                            child: InkWell(
                                              onTap: () async {
                                                //เมื่อกดตัวนิยายเเล้วก็ไปหน้า ตอนทั้งหมด
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EpisodeWriteWidget(
                                                            index_novel: index),
                                                  ),
                                                );
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Flexible(
                                                    flex: 1,
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            8,
                                                                            8,
                                                                            8,
                                                                            8),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/Lord_of_the_Mysteries_2.png',
                                                                    width: 66,
                                                                    height: 80,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          2,
                                                                          1,
                                                                          0,
                                                                          0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    '${snapshot1.data?[index].title}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: FlutterFlowTheme
                                                                        .subtitle1
                                                                        .override(
                                                                      fontFamily:
                                                                          'Lexend Deca',
                                                                      color: Color(
                                                                          0xFF15212B),
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '1154 ตอน',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: FlutterFlowTheme
                                                                        .bodyText2
                                                                        .override(
                                                                      fontFamily:
                                                                          'Lexend Deca',
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          8,
                                                                          0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .chevron_right_outlined,
                                                                    color: Color(
                                                                        0xFF95A1AC),
                                                                    size: 24,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
