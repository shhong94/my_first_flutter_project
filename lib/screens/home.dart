import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'edit.dart';

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
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding (
                padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                child: Text("메모메모", style: TextStyle(fontSize: 36, color: Colors.blue),),
              )
            ],
          ),
          ...loadMemo()
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.push(context, CupertinoPageRoute(builder: (context) => EditPage()));
          },
          label: Text("메모 추가"),
          tooltip: "메모 추가하려면 버튼을 누르세요",
          icon: Icon(Icons.add),),

    );
  }

  List<Widget> loadMemo() {
    List<Widget> memoList = [];
    memoList.add(Container(color: Colors.red, height: 100));
    return memoList;
  }
}
