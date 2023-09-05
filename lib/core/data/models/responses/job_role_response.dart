import '../../../domain/entities/job_role.dart';

class JobRoleResponse extends JobRole {
  const JobRoleResponse(
      {required String id,
      required String name,
      required String imageUrl,
      required Map<String, String> labels})
      : super(id: id, name: name, imageUrl: imageUrl, labels: labels);

  factory JobRoleResponse.fromJson(Map<String, dynamic> json) {
    return JobRoleResponse(
        id: json['_id'],
        name: json['name'],
        imageUrl: json['imageUrl'],
        labels: Map.from(json['labels']));
  }

}
