import 'package:flutter_svg/flutter_svg.dart';
import 'package:read_novel/models/episode_model.dart';
import 'package:read_novel/models/novel_model.dart';
import 'package:read_novel/screen/mywork.dart';
import 'package:read_novel/screen/profile.dart';
import 'package:read_novel/service/database.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'episode.dart';

class MainPageWidget extends StatefulWidget {
  MainPageWidget({Key? key}) : super(key: key);

  @override
  _MainPageWidgetState createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
      MainPage(),
      MyworkWidget(),
      ProfileWidget(),
    ];
    final _kBottmonNavBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
          icon: Icon(Icons.chrome_reader_mode), label: 'อ่าน'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.edit), label: 'ผนงานของฉัน'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.person), label: 'โปรไฟล์ของฉัน'),
    ];
    assert(_kTabPages.length == _kBottmonNavBarItems.length);
    final bottomNavBar = BottomNavigationBar(
      items: _kBottmonNavBarItems,
      currentIndex: _currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentTabIndex = index;
        });
      },
    );
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF00DCA7),
        bottomNavigationBar: bottomNavBar,
        body: _kTabPages[_currentTabIndex]);
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController? pageViewController;
  Database db = Database.instance;
  @override
  Widget build(BuildContext context) {
    Stream<List<NovelModel>> stream_novel = db.getReadNovel();
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.infinity,
            height: 217,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 50),
                  child: PageView(
                    controller: pageViewController ??=
                        PageController(initialPage: 0),
                    scrollDirection: Axis.horizontal,
                    children: [
                      Image.asset(
                        'assets/images/5f7aa1172sqzUZ8Y1.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        'assets/images/5f7aa1172sqzUZ8Y1.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        'assets/images/5f7aa1172sqzUZ8Y1.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, 1),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: SmoothPageIndicator(
                      controller: pageViewController ??=
                          PageController(initialPage: 0),
                      count: 3,
                      axisDirection: Axis.horizontal,
                      onDotClicked: (i) {
                        pageViewController!.animateToPage(
                          i,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      effect: ExpandingDotsEffect(
                        expansionFactor: 2,
                        spacing: 8,
                        radius: 16,
                        dotWidth: 16,
                        dotHeight: 16,
                        dotColor: Color(0xFF9E9E9E),
                        activeDotColor: Color(0xFF3F51B5),
                        paintStyle: PaintingStyle.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF80FFEE),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
              child: Text(
                'นิยายทั้งหมด',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  color: Color(0xFF4E4E4E),
                  fontSize: 18,
                ),
              ),
            ),
          ),
          StreamBuilder<List<NovelModel>>(
              stream: stream_novel,
              builder: (context, snapshot) {
                
                if (snapshot.hasData) {
                  if (snapshot.data?.length == 0) {
                    return Center(
                      child: Text('ยังไม่มีนิยาย'),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          Stream<List<EpisodeModel>> stream_episode = db.getReadEpisode(novel: NovelModel(id: snapshot.data?[index].id));
                          return StreamBuilder<List<EpisodeModel>>(
                              stream: stream_episode,
                              builder: (context, snapshot1) {
                                return InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EpisodeWidget(index_novel: index,),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 103,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFEEEEEE),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Image.network(
                                          'https://picsum.photos/seed/198/600',
                                          width: 66,
                                          height: 89,
                                          fit: BoxFit.cover,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  15, 0, 0, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${snapshot.data?[index].title}',
                                                textAlign: TextAlign.start,
                                                style: FlutterFlowTheme
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Text(
                                                '${snapshot1.data?.last.episodecontent}',
                                                textAlign: TextAlign.start,
                                                style: FlutterFlowTheme
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFF999999),
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                '30 ก.ย. 2564 / 22.57 น.',
                                                textAlign: TextAlign.start,
                                                style: FlutterFlowTheme
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFF999999),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }),
                  );
                }
                return Center(child: CircularProgressIndicator());
              })
        ],
      ),
    );
  }
}
