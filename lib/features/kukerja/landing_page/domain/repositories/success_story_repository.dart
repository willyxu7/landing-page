import 'package:kukerja_web/features/kukerja/landing_page/data/models/responses/success_story_response.dart';

abstract class SuccessStoryRepository {
  Future<List<SuccessStoryResponse>> getSuccessStory();
}
