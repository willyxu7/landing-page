import 'dart:convert';

import 'package:kukerja_web/features/kukerja/landing_page/data/models/responses/success_story_response.dart';
import 'package:kukerja_web/features/kukerja/landing_page/domain/repositories/success_story_repository.dart';
import 'package:flutter/services.dart';

class SuccessStoryRepositoryImpl implements SuccessStoryRepository {
  @override
  Future<List<SuccessStoryResponse>> getSuccessStory() async {
    List<SuccessStoryResponse> successStoriesResponses = [];
    final String response = await rootBundle.loadString(
        'lib/features/kukerja/landing_page/data/datasources/local_data/success_story.json');

    final data = await json.decode(response);
    final successStories = data['data'];

    for (var successStory in successStories) {
      SuccessStoryResponse successStoryResponse = SuccessStoryResponse(
          imagePath: successStory['image'],
          name: successStory['name'],
          job: successStory['job'],
          role: successStory['role'],
          description: successStory['description']);

      successStoriesResponses.add(successStoryResponse);
    }

    return successStoriesResponses;
  }
}
