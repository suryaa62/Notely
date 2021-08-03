class UserModel {
  String userID;
  String name;
  String phoneNo;
  String email;
  String imageURL;

  UserModel({this.userID, this.email, this.imageURL, this.name, this.phoneNo});

  UserModel.fromMap(Map<String, dynamic> data) {
    userID = data['userID'];
    name = data['name'];
    phoneNo = data['phoneNo'];
    email = data['email'];
    imageURL = data['imageURL'];
  }

  Map<String, dynamic> toMap() {
    return {
      "userID": userID,
      "name": name,
      "phoneNo": phoneNo,
      "email": email,
      "imageURL": imageURL,
    };
  }
}
