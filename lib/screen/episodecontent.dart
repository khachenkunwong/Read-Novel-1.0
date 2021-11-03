// import '../flutter_flow/flutter_flow_drop_down.dart';
import 'package:read_novel/models/episode_model.dart';
import 'package:read_novel/models/novel_model.dart';
import 'package:read_novel/service/database.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//หน้าอ่านเนื้อหานิยาย ของคนอ่าน
class EpisodeContentWidget extends StatefulWidget {
  var index_episode;
  var index_novel;
  EpisodeContentWidget({Key? key, this.index_novel,this.index_episode}) : super(key: key);

  @override
  _EpisodeContentWidgetState createState() => _EpisodeContentWidgetState();
}

class _EpisodeContentWidgetState extends State<EpisodeContentWidget> {
  String? dropDownValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Database db = Database.instance;

  @override
  Widget build(BuildContext context) {
    Stream<List<NovelModel>> stream_novel = db.getReadNovel();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF009A86),
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
        title: StreamBuilder<List<NovelModel>>(
            stream: stream_novel,
            builder: (context, snapshot1) {
              Stream<List<EpisodeModel>> stream_episode = db.getReadEpisode(
                  novel:
                      NovelModel(id: snapshot1.data?[widget.index_novel].id));
              return StreamBuilder<List<EpisodeModel>>(
                  stream: stream_episode,
                  builder: (context, snapshot2) {
                    return Text(
                      '${snapshot2.data?[widget.index_episode].chapterName}',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    );
                  });
            }),
        actions: [],
        centerTitle: false,
        elevation: 4,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder<List<NovelModel>>(
              stream: stream_novel,
              builder: (context, snapshot1) {
                Stream<List<EpisodeModel>> stream_episode = db.getReadEpisode(
                    novel:
                        NovelModel(id: snapshot1.data?[widget.index_novel].id));
                return StreamBuilder<List<EpisodeModel>>(
                    stream: stream_episode,
                    builder: (context, snapshot2) {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              '${snapshot2.data?[widget.index_episode].episodecontent}',
                              style: FlutterFlowTheme.bodyText1,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                iconSize: 60,
                                icon: Icon(
                                  Icons.chevron_left_outlined,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                              // FlutterFlowDropDown(
                              //   options: ['1', '2', '3', '4'].toList(),
                              //   onChanged: (val) => setState(() => dropDownValue = val),
                              //   width: 80,
                              //   height: 50,
                              //   textStyle: FlutterFlowTheme.bodyText1.override(
                              //     fontFamily: 'Lexend Deca',
                              //     color: Colors.black,
                              //     fontSize: 14,
                              //     fontWeight: FontWeight.normal,
                              //   ),
                              //   icon: Icon(
                              //     Icons.keyboard_arrow_down_rounded,
                              //     color: Color(0xFF95A1AC),
                              //     size: 15,
                              //   ),
                              //   fillColor: Colors.white,
                              //   elevation: 3,
                              //   borderColor: Colors.transparent,
                              //   borderWidth: 0,
                              //   borderRadius: 8,
                              //   margin: EdgeInsetsDirectional.fromSTEB(20, 4, 8, 4),
                              //   hidesUnderline: true,
                              // ),
                              IconButton(
                                iconSize: 60,
                                icon: Icon(
                                  Icons.navigate_next,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              )
                            ],
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
