class User {
  final String? uid;
  bool? active;
  bool? isDeleted;
  String? name;
  String? matricule;
  String? profile;
  String? email;
  String? entitieId;
  String? serviceId;
  String? espaceConfineId;
  User(
      {this.uid,
      this.active,
      this.isDeleted,
      this.matricule,
      this.name,
      this.profile,
      this.email,
      this.entitieId,
      this.serviceId,
      this.espaceConfineId});
  Future createUser() async {
    /*try {
      DatabaseServices().userscollection.document(uid).setData({
        'active': active,
        'isDeleted': isDeleted,
        "name": name,
        'matricule': matricule,
        "profile": profile,
        "email": email,
        "entitieId": entitieId,
        "serviceId": serviceId,
        "espaceConfineId": espaceConfineId,
      });
    } catch (e) {
      print(e.toString());
    }*/
  }

  Future updateUserdata(var data) async {
    /*try {
      DatabaseServices().userscollection.document(uid).updateData(data);
    } catch (e) {
      return null;
    }*/
  }

  Future<User?> getUserData({String? uid}) async {
    /* try {
      User u = await DatabaseServices()
          .userscollection
          .document(uid)
          .get()
          .then((doc) {
        return User(
          uid: uid,
          active: doc['active'],
          isDeleted: doc['isDeleted'],
          matricule: doc['matricule'],
          name: doc['name'],
          profile: doc['profile'],
          email: doc['email'],
          entitieId: doc['entitieId'],
          serviceId: doc['serviceId'],
          espaceConfineId: doc['espaceConfineId'],
        );
      });
      return u;
    } catch (e) {
      return null;
    }*/
  }
}
