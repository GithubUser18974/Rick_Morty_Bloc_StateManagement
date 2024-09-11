class Character {
  late int id;
  late String name;
  late String status;
  late String gender;
  late List<dynamic> episode;
  late String image;
  late String species;
  late String created;
  Character.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    status = json["status"];
    gender = json["gender"];
    image = json["image"];
    created = json["created"];
    episode = json["episode"];
    species = json["species"];
  }
}
