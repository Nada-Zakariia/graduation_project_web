class UserModel {
  String? name;
 // String? email;
 // String? phone;
 // String? image;
  String? uId;
  String? balance;
  //TicketModel ?tickets;
  UserModel({
    this.name,
   // this.email,
   // this.phone,
    //this.image,
    //this.token,
    this.uId,
    this.balance
    //this.tickets
  });

  UserModel.fromJason(Map<String, dynamic> json) {
    uId = json['uId'];
    name = json['name'];
   // phone = json['phone'];
   // image = json['image'];
   // email = json['email'];
    balance = json['balance'];
  }
  Map<String, dynamic> toMap() {
    return {
      "uId": uId,
      "name": name,
     // "phone": phone,
     // "image": image,
     // "email": email,
      "balance": balance,
    };
  }
}
