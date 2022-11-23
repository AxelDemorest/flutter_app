import 'package:mongo_dart/mongo_dart.dart';

class Horse {
  final ObjectId id;
  final String name;
  final int age;
  final String robe;
  final String race;
  final String sex;
  final String speciality;
  final String image;

  Horse(this.id, this.name, this.age, this.robe, this.race, this.sex, this.speciality, this.image );

  @override
  String toString() {
    return ('Id : $id, Name : $name, Age : $age, Robe : $robe, Race : $race, Sex : $sex, Speciality : $speciality, ImageFile : $image');
  }

}