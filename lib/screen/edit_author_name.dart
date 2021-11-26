import 'package:read_novel/models/novel_model.dart';
import 'package:read_novel/service/database.dart';

import '../flutter_flow/flutter_flow_theme.dart';

import 'package:flutter/material.dart';

//หน้าแก้ชื่อผู้แต่ง หรือนามปาก
class EditAuthorNameWidget extends StatefulWidget {
  final data;
  final authorname_novel;
  EditAuthorNameWidget({Key? key, this.data,this.authorname_novel}) : super(key: key);

  @override
  _EditAuthorNameWidgetState createState() => _EditAuthorNameWidgetState();
}

class _EditAuthorNameWidgetState extends State<EditAuthorNameWidget> {
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String title = '';
  Database db = Database.instance;
  String? text1;

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    Stream<List<NovelModel>> state = db.getNovel();
    textController = TextEditingController(text: "${widget.authorname_novel}");

    // print("nnnnnnn ${state.first..then((document) => document.map((docs) {print(docs.title);}))}");
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          'ผู้เเต่ง',
          style: FlutterFlowTheme.bodyText1,
        ),
        actions: [
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
              child: StreamBuilder<List<NovelModel>>(
                  stream: state,
                  builder: (context, snapshot) {
                    return InkWell(
                      onTap: () async {
                        print(title);
                        db.updateauthorname(
                            novel:
                                NovelModel(authorname: title, id: widget.data));
                        Navigator.pop(context);
                      },
                      child: Text(
                        'บันทึก',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF009A86),
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
          child: TextFormField(
            controller: textController,
            obscureText: false,
            onChanged: (text) {
              this.title = text;
            },
            decoration: InputDecoration(
              hintText: 'พิมพ์ที่นี้',
              hintStyle: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Poppins',
                color: Color(0xFF696969),
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
              color: Color(0xFF696969),
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}
