import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    try {
      String uid = _auth.currentUser!.uid;
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String uniqueFileName = '$uid-$timestamp.jpg'; // Assuming images are JPEG format

      Reference ref = _storage.ref().child(childName).child(uniqueFileName);

      UploadTask uploadTask = ref.putData(file);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image to storage: $e');
      throw e;
    }
  }
}

// class StorageMethods {
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   // adding image to firebase storage
//   Future<String> uploadImageToStorage(String childName, Uint8List file,) async{
//     Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);
//
//     UploadTask uploadTask = ref.putData(file);
//
//     TaskSnapshot snapshot = await uploadTask;
//     String downloadUrl = await snapshot.ref.getDownloadURL();
//     return downloadUrl;
//   }
// }