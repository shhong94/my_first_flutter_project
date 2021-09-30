import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'edit.dart';
import '../database/memo.dart';
import '../database/db.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 10, top: 30, bottom: 20),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "메모메모",
                  style: TextStyle(fontSize: 36, color: Colors.blue),
                ),
              )),
          Expanded(child: memoBuilder()),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => EditPage()));
        },
        label: Text("메모 추가"),
        tooltip: "메모 추가하려면 버튼을 누르세요",
        icon: Icon(Icons.add),
      ),
    );
  }

  List<Widget> loadMemo2() {
    List<Widget> memoList = [];
    memoList.add(Container(color: Colors.red, height: 100));
    return memoList;
  }

  Future<List<Memo>> loadMemo() async {
    DBHelper sd = DBHelper();
    return await sd.memos();
  }

  Widget memoBuilder() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        // 홈 화면에 메모가 없으면
        if (projectSnap.data.isEmpty) {
          return Container(
            alignment: Alignment.center,
            child: Text("메모를 추가해보세요"),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.all(10),
          physics: BouncingScrollPhysics(),
          itemCount: projectSnap.data.length,
          itemBuilder: (context, index) {
            Memo memo = projectSnap.data[index];
            return Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(10),
              height: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.blue,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        memo.title,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        memo.text,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        "최종 수정 시간: " + memo.editTime.split(".")[0],
                        style: TextStyle(fontSize: 12,),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                  // 화면에 표시할 데이터
                ],
              ),
            );
          },
        );
      },
      future: loadMemo(),
    );
  }
}
