import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../database/memo.dart';
import '../database/db.dart';

class ViewPage extends StatefulWidget {
  ViewPage({Key key, this.id}) : super(key: key);
  final String id;
  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: loadBuilder()
      ),
    );
  }


  Future<List<Memo>> loadMemo(String id) async {
    DBHelper sd = DBHelper();
    return await sd.findMemo(id);
  }

  loadBuilder() {
    return FutureBuilder<List<Memo>>(
      future: loadMemo(widget.id),
      builder: (BuildContext context, AsyncSnapshot<List<Memo>> snapshot){
        if (snapshot.data.isEmpty) {
          return Container(
            child: Text("데이터 불러오기 실패"),
          );
        } else {
          Memo memo = snapshot.data[0];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 100,
                child: SingleChildScrollView(
                  child: Text(memo.title, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
                )
              ),

              Padding(padding: EdgeInsets.all(10)),
              Expanded(child: SingleChildScrollView(child: Text(memo.text))),
              Text("최종 수정 시간: " + memo.editTime.split(".")[0], style: TextStyle(fontSize: 11), textAlign: TextAlign.end,)
            ],
          );
        }
    }
    );
  }


}





