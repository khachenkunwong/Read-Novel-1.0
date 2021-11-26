import 'package:read_novel/models/episode_model.dart';
import 'package:read_novel/models/novel_model.dart';
import 'package:read_novel/screen/add_episode.dart';
import 'package:read_novel/service/database.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'edit_add.dart';
import 'episodecontent.dart';
import 'package:uuid/uuid.dart';

//หน้าเเสดงรายละเอียดนิยาย ของคนเขียน
class EpisodeWriteWidget extends StatefulWidget {
  final index_novel;
  EpisodeWriteWidget({Key? key, this.index_novel}) : super(key: key);

  @override
  _EpisodeWriteWidgetState createState() => _EpisodeWriteWidgetState();
}

class _EpisodeWriteWidgetState extends State<EpisodeWriteWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Database db = Database.instance;
  // ทำการ  random id เพื่อสร้าง id ตอน
  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    //
    Stream<List<NovelModel>> state = db.getNovel();
    var uid = uuid.v1();

    return Scaffold(
      key: scaffoldKey,
      bottomNavigationBar: StreamBuilder<List<NovelModel>>(
          stream: state,
          builder: (context, snapshot2) {
            // เรียกใช้ getEpisode ต้องมีการใส่ id ของ นิยายไปด้วยเพื่อที่จะได้ดูตอนได้ถูก
            Stream<List<EpisodeModel>> state = db.getEpisode(
                novel: NovelModel(id: snapshot2.data?[widget.index_novel].id));
            return Container(
              width: double.infinity,
              height: 50.0,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StreamBuilder<List<EpisodeModel>>(
                      stream: state,
                      builder: (context, snapshot3) {
                        return ElevatedButton.icon(
                          onPressed: () {
                            // เรียกใช้ setEpisode เพื่อสร้างนิยาย ลงใน firestore เมื่อกดปุ่มบวก
                            db.setEpisode(
                                novel: NovelModel(
                                    id: snapshot2.data?[widget.index_novel].id),
                                episode: EpisodeModel(
                                  chapterName: 'ชื่อตอน',
                                  chapternumber: '$uid',
                                  state: false,
                                  statelock: false,
                                  images: 'รูปภาพ',
                                  episodecontent: 'เนื้อหาตอน',
                                ));
                            setState(() {
                              print('relord');
                            });

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => AddEpisodeWidget(
                            //         idnovel: snapshot2.data?[widget.numbar].id,
                            //         idepisode: "$uid"),
                            //   ),
                            // );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF009A86),
                          ),
                          label: Text('เพิ่มตอนใหม่'),
                          icon: Icon(Icons.add),
                        );
                      }),
                  OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      'จัดเล่ม',
                      style: TextStyle(
                        color: Color(0xFF009A86),
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      //ไปยัง เเก้ไขเรื่องย่อกับชื่อเรื่อง เมื่อกดปุ่มแก้รายละเอียด
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditAddWidget(
                              page: 1,
                              index_novel: widget.index_novel,
                              data: snapshot2.data?[widget.index_novel].id),
                        ),
                      );
                    },
                    child: Text(
                      'แก้ไขรายละเอียด',
                      style: TextStyle(
                        color: Color(0xFF009A86),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
      appBar: AppBar(
        backgroundColor: Color(0xFF009A86),
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFF009A86),
      body: SafeArea(
        child: Align(
          alignment: AlignmentDirectional(0, 0),
          child: StreamBuilder<List<NovelModel>>(
              stream: state,
              builder: (context, snapshot) {
                Stream<List<EpisodeModel>> state1 = db.getEpisode(
                    novel:
                        NovelModel(id: snapshot.data?[widget.index_novel].id));
                return StreamBuilder<List<EpisodeModel>>(
                    stream: state1,
                    builder: (context, snapshot1) {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image.asset(
                            'assets/images/Lord_of_the_Mysteries_2.png',
                            width: 142,
                            height: 192,
                            fit: BoxFit.cover,
                          ),
                          Flexible(
                            flex: 0,
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Text(
                                '${snapshot.data?[widget.index_novel].title}',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(1, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                              child: Text(
                                'อัพเดตล่าสุด 36 ชั่วโมงที่แล้ว',
                                textAlign: TextAlign.end,
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFFD0D0D0),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 1,
                                decoration: BoxDecoration(
                                  color: Color(0xFF80FFEE),
                                ),
                                child: DefaultTabController(
                                  length: 2,
                                  initialIndex: 0,
                                  child: Column(
                                    children: [
                                      TabBar(
                                        labelColor: Color(0xFF009A86),
                                        unselectedLabelColor: Color(0xFFC2C2C2),
                                        labelStyle: GoogleFonts.getFont(
                                          'Roboto',
                                        ),
                                        indicatorColor: Color(0xFF089682),
                                        indicatorWeight: 2,
                                        tabs: [
                                          Tab(
                                            text: 'รายละเอียด',
                                          ),
                                          Tab(
                                            text: 'สารบัญ',
                                          )
                                        ],
                                      ),
                                      Expanded(
                                        child: TabBarView(
                                          children: [
                                            Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(10, 0, 10, 0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${snapshot.data?[widget.index_novel].synopsis}\n\nสถานะจบเเล้วมี 1154 ตอน\n\nกลุ่มติดตาม',
                                                      style: FlutterFlowTheme
                                                          .bodyText1
                                                          .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          Icons.link_outlined,
                                                          color: Colors.black,
                                                          size: 24,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(10,
                                                                      0, 0, 0),
                                                          child: Text(
                                                            '${snapshot.data?[widget.index_novel].contact}',
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText1,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )),
                                            Container(
                                              child: ListView.builder(
                                                  itemCount:
                                                      snapshot1.data?.length,
                                                  itemBuilder:
                                                      (context, index_episode) {
                                                    return Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10, 0, 10, 0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  AddEpisodeWidget(
                                                                index_novel: widget
                                                                    .index_novel,
                                                                index_episode:
                                                                    index_episode,
                                                                idnovel: snapshot
                                                                    .data?[widget
                                                                        .index_novel]
                                                                    .id,
                                                                idepisode: snapshot1
                                                                    .data?[
                                                                        index_episode]
                                                                    .chapternumber,
                                                                chapterName: snapshot1
                                                                    .data?[
                                                                        index_episode]
                                                                    .chapterName,
                                                                episodecontent: snapshot1
                                                                    .data?[
                                                                        index_episode]
                                                                    .episodecontent,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -0.85, 0),
                                                          child: Row(
                                                            children: [
                                                              Text("เพยเเพร์ ",style: TextStyle(color: snapshot1.data?[index_episode].state == true? Colors.green: Colors.grey),),
                                                              Text(
                                                                'ตอนที่ ${index_episode + 1} ${snapshot1.data?[index_episode].chapterName}',
                                                                textAlign:
                                                                    TextAlign.start,
                                                                style:
                                                                    FlutterFlowTheme
                                                                        .bodyText1,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    });
              }),
        ),
      ),
    );
  }
}
