import 'package:hive/hive.dart';

part 'diary_model.g.dart';


@HiveType(typeId: 0)
class DiaryModel{

  @HiveField(0)
  late final int id;

  @HiveField(1)
  late final String tittle;

  @HiveField(2)
  late final String note;

  @HiveField(3)
  late final String image;

  @HiveField(4)
  late final String date;

  DiaryModel({required this.id, required this.tittle, required this.note, required this.image,required this.date});
}