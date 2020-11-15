import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';

class FireAuth {  
// Get current User // FireAuth.getCurrentUser()
static Future<String> getCurrentUser() async{   
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  return user?.uid;
}

static Future<String> signInWithEmailAndPassword(String email, String password) async{   
  FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  return user?.uid;
}

static Future<String> createUserWithEmailAndPassword(String email, String password) async{   
  FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  return user?.uid;
}

static Future<String> signOut() async{   
  await FirebaseAuth.instance.signOut();
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  print(user?.uid);
  return user?.uid;
}

static void createRecord(String collectionName, var data) async {
  final databaseReference = Firestore.instance;
  DocumentReference ref = await databaseReference.collection(collectionName).add(data);
  print(ref.documentID);
}

static Future<Null> uploadPic(File _image) async{
  String fileName = basename(_image.path);
  StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
  StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
  StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
  String fileUrl= await firebaseStorageRef.getDownloadURL();

}

static Future<String> uploadPicdata(File _image) async{
  String fileName = basename(_image.path);
  StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
  StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
  StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
  String fileUrl= await firebaseStorageRef.getDownloadURL();
  return fileUrl;
}

}

// Test class
class TestPrint {
  static void foo() {
    print("1234");
  }
  // TestPrint.foo();
}

