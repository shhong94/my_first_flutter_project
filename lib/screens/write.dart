import 'package:flutter/material.dart';
import 'package:my_first_flutter_project/database/db.dart';
import 'package:my_first_flutter_project/database/memo.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method


class WritePage extends StatelessWidget {
  String title = "";
  String text = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: saveDb,
          ),
        ],
      ),
      body:
      Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (String title){this.title = title;},
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              decoration: InputDecoration(
                // border: OutlineInputBorder(),
                hintText: '제목',
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            TextField(
              onChanged: (String text){this.text = text;},
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: '메모 내용'
              ),
            ),
          ],
        ),
      ),

    );
  }

  Future<void> saveDb() async {
    DBHelper sd = DBHelper();

    var fido = Memo(
      id: str2sha512(DateTime.now().toString()),
      title: this.title,
      text: this.text,
      createTime: DateTime.now().toString(),
      editTime: DateTime.now().toString(),
    );
    
    await sd.insertMemo(fido);
    print(await sd.memos());
  }


  String str2sha512(String text) {
    var bytes = utf8.encode(text); // data being hashed

    var digest = sha512.convert(bytes);
    return digest.toString();
  }


}
