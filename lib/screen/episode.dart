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
//หน้าเเสดงรายละเอียดนิยาย ของคนอ่าน
class EpisodeWidget extends StatefulWidget {
  final index_novel;
  EpisodeWidget({Key? key, this.index_novel}) : super(key: key);

  @override
  _EpisodeWidgetState createState() => _EpisodeWidgetState();
}

class _EpisodeWidgetState extends State<EpisodeWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Database db = Database.instance;

  @override
  Widget build(BuildContext context) {
    Stream<List<NovelModel>> state = db.getReadNovel();

    return Scaffold(
      key: scaffoldKey,
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
                Stream<List<EpisodeModel>> state1 = db.getReadEpisode(
                    novel: NovelModel(id: snapshot.data?[widget.index_novel].id));
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
                                                        onTap: () async {
                                                          await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  EpisodeContentWidget(index_novel: widget.index_novel,index_episode:index_episode,),
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
                                                          child: Text(
                                                            'ตอนที่ ${index_episode + 1} ${snapshot1.data?[index_episode].chapterName}',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style:
                                                                FlutterFlowTheme
                                                                    .bodyText1,
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
