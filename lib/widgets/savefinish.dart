import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SaveFinishWidget extends StatefulWidget {
  SaveFinishWidget({Key? key}) : super(key: key);

  @override
  _SaveFinishWidgetState createState() => _SaveFinishWidgetState();
}

class _SaveFinishWidgetState extends State<SaveFinishWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/finished.png',
            width: 140,
            height: 140,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
            child: Text(
              'บันทึกเเล้ว',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
