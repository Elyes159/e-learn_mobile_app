import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('users').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<DocumentSnapshot> users = snapshot.data!.docs;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                String userId = users[index].id;
                String userName = users[index]['email'];
                return ListTile(
                  title: Text(userName),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userId)
                          .delete();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('User $userName deleted'),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
