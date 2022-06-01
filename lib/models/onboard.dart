import 'package:equatable/equatable.dart';

class Onboard extends Equatable {
  final String image;
  final String title;
  final String description;
  const Onboard({
    required this.image,
    required this.title,
    required this.description,
  });



  @override
  List<Object> get props => [image, title, description];

  @override
  String toString() => 'Onboard(image: $image, title: $title, description: $description)';
}
