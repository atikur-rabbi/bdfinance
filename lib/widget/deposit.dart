import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../pages/customer_create.dart';

class DepositPage extends StatefulWidget {
  final BuildContext context;

  const DepositPage({
    Key key,
    this.context,
  });

  @override
  _DepositPageState createState() {
    return _DepositPageState();
  }
}

class _DepositPageState extends State<DepositPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Baby Name Votes')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('deposit').snapshots(),
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
    final record = Record.fromSnapshot(data);

    return Padding(
        key: ValueKey(record.name),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  height: 120,
                  child: Image.asset("images/" + record.image),
                ),
                flex: 2,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                        //height: 600,
                        alignment: Alignment.topLeft,
                        child: Text(
                          record.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black),
                        )),
                    Container(
                        margin: EdgeInsets.fromLTRB(20, 5, 5, 0),
                        alignment: Alignment.topLeft,
                        //height: 600,
                        child: Text(record.details,
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
                        context,  MaterialPageRoute(builder: (context) => CustomerCreate()),
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
                      )),
                    )
                  ],
                ),
                flex: 4,
              ),
            ],
          ),
        ));
  }
}

class Record {
  final String name;
  final String details;
  final String image;
// final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['details'] != null),
        assert(map['image'] != null),
        //  assert(map['votes'] != null),
        name = map['name'],
        details = map['details'],
        image = map['image'];
  //  votes = map['votes'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$details:$image>";
}
