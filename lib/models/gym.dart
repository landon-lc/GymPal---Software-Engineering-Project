import 'package:cloud_firestore/cloud_firestore.dart';

class Gym {
  final String name;
  final double latitude;
  final double longitude;
  
  Gym({required this.name, required this.latitude, required this.longitude});

  // Class specific methods
  String displayName() {
    return name;
  }

  // Factory method to create a Gym from Firestore document.
  factory Gym.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Gym(
      name: data['name'],
      latitude: data['latitude'],
      longitude: data['longitude'],
    );
  }
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<List<Gym>> getGyms() async {
  CollectionReference gymsCollection = _firestore.collection('gyms');

  // This is a simple query that fetches all documents from the 'gyms' collection.
  QuerySnapshot querySnapshot = await gymsCollection.get();

  // Iterating over the documents and converting them to Gym objects.
  List<Gym> gyms = querySnapshot.docs.map((doc) {
    return Gym.fromFirestore(doc);
  }).toList();

  return gyms;
}