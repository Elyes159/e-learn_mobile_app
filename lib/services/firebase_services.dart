import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateUserXP(String userId, int xp) async {
    await usersCollection.doc(userId).update({'xp': xp});
  }

  Future<void> updateQuestionState(
      String userId, List<bool> questionState) async {
    await usersCollection.doc(userId).update({'questionState': questionState});
  }

  Future<void> createNewUser(String userId) async {
    await usersCollection.doc(userId).set({'xp': 0, 'questionState': []});
  }

  Future<Map<String, dynamic>> getUserData(String userId) async {
    DocumentSnapshot userSnapshot = await usersCollection.doc(userId).get();
    return userSnapshot.data() as Map<String, dynamic>? ?? {};
  }
}

class FirebaseService1 {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserXP(int xp, int level) async {
    try {
      // Vous pouvez ajuster le chemin vers votre collection et le document utilisateur
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String uid = user.uid;
        print('L\'UID de l\'utilisateur actuel est : $uid');
      } else {
        print('Aucun utilisateur actuellement authentifié.');
      } // Remplacez cela par l'ID réel de l'utilisateur
      DocumentReference userDocRef = _firestore.collection('users').doc();

      // Mettez à jour les données de l'utilisateur avec les nouveaux XP et le niveau
      await userDocRef.update({
        'xp': xp,
        'level': level,
      });

      print('XP enregistrées avec succès.');
    } catch (e) {
      print('Erreur lors de l\'enregistrement des XP : $e');
    }
  }
}
// class FirebaseService2{
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> saveUserXP(String uid, int xpLevel, double xpProgress) async {
//     try {
//       await _firestore.collection('users').doc(uid).update({
//         'xpLevel': xpLevel,
//         'xpProgress': xpProgress,
//       });
//     } catch (e) {
//       print("Erreur lors de la sauvegarde de l'XP de l'utilisateur : $e");
//       // Gérer l'erreur selon vos besoins
//     }
//   }
// }

// void getCurrentUserUid() {
//   User? user = FirebaseAuth.instance.currentUser;
//   if (user != null) {
//     String uid = user.uid;
//     print('L\'UID de l\'utilisateur actuel est : $uid');
//   } else {
//     print('Aucun utilisateur actuellement authentifié.');
//   }
// }