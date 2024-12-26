class SqfliteDemoScreenDl{
  int? id;
  String? name;
  String? mobile;
  String? img;

  SqfliteDemoScreenDl(this.name, this.mobile, this.img,{this.id});

  SqfliteDemoScreenDl.fromJson(Map<String,dynamic> map){
    id = map["id"];
    name = map["name"];
    mobile = map["mobile"];
    img = map["img"];
  }

  Map<String,dynamic> toJson(){
    return{
      "name" : name,
      "mobile" : mobile,
      "img" : img,
    };
  }


}