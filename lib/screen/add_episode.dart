import 'package:read_novel/models/episode_model.dart';
import 'package:read_novel/models/novel_model.dart';
import 'package:read_novel/service/database.dart';
import 'package:read_novel/widgets/create.dart';
import 'package:read_novel/widgets/savefinish.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//หน้าเขียนนิยาย บันทึก เพยแพร่
class AddEpisodeWidget extends StatefulWidget {
  var index_novel;
  var index_episode;
  var idnovel;
  var idepisode;
  final chapterName;
  final episodecontent;
  AddEpisodeWidget(
      {Key? key,
      this.index_novel,
      this.index_episode,
      this.idnovel,
      this.idepisode,
      this.chapterName,
      this.episodecontent})
      : super(key: key);

  @override
  _AddEpisodeWidgetState createState() => _AddEpisodeWidgetState();
}

class _AddEpisodeWidgetState extends State<AddEpisodeWidget> {
  TextEditingController? textController1;
  TextEditingController? textController2;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Database db = Database.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Stream<List<NovelModel>> stream_novel = db.getNovel();
    textController1 = TextEditingController(text: '${widget.chapterName}');
    textController2 = TextEditingController(text: '${widget.episodecontent}');

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        actions: [
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: StreamBuilder<List<NovelModel>>(
                stream: stream_novel,
                builder: (context, snapshot1) {
                  Stream<List<EpisodeModel>> stream_episode =
                      db.getEpisode(novel: NovelModel(id: "${widget.idnovel}"));
                  return StreamBuilder<List<EpisodeModel>>(
                      stream: stream_episode,
                      builder: (context, snapshot2) {
                        return InkWell(
                          onTap: () async {
                            print(
                                'widget.index_novel == ${widget.index_novel}');
                            print(
                                'snapshot2.data?[widget.index_episode].chapterName == ${snapshot2.data?[widget.index_episode].chapterName}');
                            if (widget.index_novel != null) {
                              print('เพยเเพร่เเล้ว');
                              db.updateEpisodeState(
                                novel: NovelModel(
                                  id: '${widget.idnovel}',
                                ),
                                episode: EpisodeModel(
                                  chapterName:
                                      '${snapshot2.data?[widget.index_episode].chapterName}',
                                  chapternumber: '${widget.idepisode}',
                                  state: true,
                                  episodecontent:
                                      '${snapshot2.data?[widget.index_episode].episodecontent}',
                                ),
                              );
                              db.setReadNovel(
                                  // type 'Null' is not a subtype of type 'int'
                                  novel: NovelModel(
                                    id: '${widget.idnovel}',
                                    title:
                                        '${snapshot1.data?[widget.index_novel].title}',
                                    synopsis:
                                        '${snapshot1.data?[widget.index_novel].synopsis}',
                                    authorname:
                                        '${snapshot1.data?[widget.index_novel].authorname}',
                                    contact:
                                        '${snapshot1.data?[widget.index_novel].contact}',
                                  ),
                                  episode: EpisodeModel(
                                    chapternumber: '${widget.idepisode}',
                                    chapterName:
                                        '${snapshot2.data?[widget.index_episode].chapterName}',
                                    state: true,
                                    statelock: false,
                                    images:
                                        '${snapshot2.data?[widget.index_episode].images}',
                                    episodecontent:
                                        '${snapshot2.data?[widget.index_episode].episodecontent}',
                                  ));
                            }

                            // Navigator.pop(context);
                          },
                          child: Text(
                            'เพยแพร่',
                            style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Color(0xFF009A86)),
                          ),
                        );
                      });
                }),
          ),
          PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
                size: 30,
              ),
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text(
                        'บันทึก',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF5B5B5B),
                          fontSize: 16,
                        ),
                      ),
                      onTap: () {
                        if (textController1?.text != null) {
                          if (textController1!.text.length >= 1) {
                            print('object++${widget.idnovel}');
                            db.updateChapterName(
                                novel: NovelModel(id: widget.idnovel),
                                episode: EpisodeModel(
                                    chapternumber: "${widget.idepisode}",
                                    chapterName: "${textController1?.text}"));
                          }
                        }

                        if (textController2?.text != null) {
                          if (textController2!.text.length >= 1) {
                            db.updateEpisodecontent(
                                novel: NovelModel(id: widget.idnovel),
                                episode: EpisodeModel(
                                    chapternumber: "${widget.idepisode}",
                                    episodecontent:
                                        "${textController2?.text}"));
                          }
                        }
                        setState(() {});

                        // Navigator.pop(context);
                      },
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: Text(
                        'ลบตอน',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF5B5B5B),
                          fontSize: 16,
                        ),
                      ),
                      value: 2,
                      onTap: () {
                        db.deleteEpisode(
                            novel: NovelModel(id: widget.idnovel),
                            episode:
                                EpisodeModel(chapternumber: widget.idepisode));
                        Navigator.pop(context);
                      },
                    ),
                    PopupMenuItem(
                      child: Text(
                        'ล็อกตอน',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF5B5B5B),
                          fontSize: 16,
                        ),
                      ),
                      value: 2,
                    )
                  ]),
          // await showModalBottomSheet(
          //   isScrollControlled: true,
          //   context: context,
          //   builder: (context) {
          //     return Container(
          //       height: 248,
          //       child: CreatetestWidget(),
          //     );
          //   },
          // );
        ],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Align(
          alignment: AlignmentDirectional(0, 0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextFormField(
                    controller: textController1,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'ชื่อตอน',
                      hintStyle: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFFACACAC),
                        fontSize: 16,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Color(0xFFACACAC),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.9,
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                    ),
                    child: TextFormField(
                      controller: textController2,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'เริ่มเขียนที่นี่',
                        hintStyle: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFFACACAC),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(2),
                            bottomRight: Radius.circular(2),
                            topLeft: Radius.circular(2),
                            topRight: Radius.circular(0),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(2),
                            bottomRight: Radius.circular(2),
                            topLeft: Radius.circular(2),
                            topRight: Radius.circular(0),
                          ),
                        ),
                      ),
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFFACACAC),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
