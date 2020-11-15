import '../widget/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'customer_info.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Visit extends StatefulWidget {
  @override
  _VisitState createState() {
    return _VisitState();
  }
}

class _VisitState extends State<Visit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Baby Name Votes')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('visit').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 10.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    // final record = Record.fromSnapshot(data);
    final cardId = data.documentID;
    final carddata = data.data;

    return TimelineTile(alignment: TimelineAlign.manual,lineXY: 0.05,indicatorStyle: IndicatorStyle(width: 20,height: 20,drawGap: true,), endChild:Padding(
        key: ValueKey(carddata['name']),
        padding: const EdgeInsets.fromLTRB(5, 8, 15, 8),
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          child: InkWell(
            onTap: () {
              // Function is executed on tap.
            },
            child:Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(  
                    shape: BoxShape.circle,
                    
                    color: color1,
                    image: DecorationImage(
                      image: NetworkImage( carddata['imageURL']),
                      fit: BoxFit.cover,
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  //height: 120,
                  child: Text(""),
                ),
                flex: 2,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                        //height: 600,
                        alignment: Alignment.topLeft,
                        child: Text(
                          carddata['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black),
                        )),
                    Container(
                        margin: EdgeInsets.fromLTRB(20, 5, 5, 0),
                        alignment: Alignment.topLeft,
                        //height: 600,
                        child: Text(carddata['mobileNo'],
                            style: TextStyle(
                              fontSize: 16,
                            ))),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 10, 5),
                      alignment: Alignment.bottomRight,
                      //height: 600,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,  MaterialPageRoute(builder: (context) => CustomerInfo(id: cardId, data: carddata)),
                          );
                        },
                        child:Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xfff7892b),
                              Color(0xfffbb448),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: const Text('Select',
                            style: TextStyle(color: Colors.white)),
                      ),)
                    )
                  ],
                ),
                flex: 4,
              ),
            ],
          ),
        ))));
  }
}
/*

class Record {
  final String name;
  final String mobileNo;
  final String imageURL;
// final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['mobileNo'] != null),
        assert(map['imageURL'] != null),
        //  assert(map['votes'] != null),
        name = map['name'],
        mobileNo = map['mobileNo'],
        imageURL = map['imageURL'];
  //  votes = map['votes'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$mobileNo:$imageURL>";
}
*/
