import 'package:equatable/equatable.dart';

class JobRole extends Equatable {
  final String id;
  final String imageUrl;
  final String name;
  final Map<String, String> labels;

  const JobRole({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.labels
  });

  @override
  List<Object> get props => [id, imageUrl, name, labels];
}
