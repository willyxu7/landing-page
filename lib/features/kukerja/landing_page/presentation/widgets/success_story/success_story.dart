import 'package:auto_size_text/auto_size_text.dart';
import 'package:kukerja_web/core/widgets/section_header.dart';
import 'package:kukerja_web/features/kukerja/landing_page/data/models/responses/success_story_response.dart';
import 'package:kukerja_web/features/kukerja/landing_page/data/repositories/success_story_repository_impl.dart';
import 'package:kukerja_web/features/kukerja/landing_page/domain/repositories/success_story_repository.dart';
import 'package:kukerja_web/core/config/responsive.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/success_story/layout/story_desktop.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/success_story/layout/story_mobile.dart';
import 'package:flutter/material.dart';

class SuccessStory extends StatefulWidget {
  const SuccessStory({Key? key}) : super(key: key);

  @override
  State<SuccessStory> createState() => _SuccessStoryState();
}

class _SuccessStoryState extends State<SuccessStory> {
  final SuccessStoryRepository _successStoryRepository =
      SuccessStoryRepositoryImpl();

  Future<List<SuccessStoryResponse>> getStories() async {
    return await _successStoryRepository.getSuccessStory();
  }

  Widget _buildCardView(AsyncSnapshot<List<SuccessStoryResponse>> snapshot,
      BuildContext context) {
    List<Widget> cards = [];
    for (var snapshot in snapshot.data!) {
      if (ResponsiveWidget.isSmallScreen(context)) {
        cards.add(StoryMobile(
            imagePath: snapshot.imagePath,
            name: snapshot.name,
            role: snapshot.role,
            description: snapshot.description));
      } else {
        cards.add(StoryDesktop(
            imagePath: snapshot.imagePath,
            name: snapshot.name,
            role: snapshot.role,
            description: snapshot.description));
      }
    }

    return Wrap(children: cards);
  }

  Widget _getStoryWidgets(BuildContext context) {
    return FutureBuilder(
      future: getStories(),
      builder: (context, AsyncSnapshot<List<SuccessStoryResponse>> snapshot) {
        if (snapshot.hasData) {
          return _buildCardView(snapshot, context);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 120),
      child: Column(
        children: [
          const SectionHeader(text: 'Jangan cuma mendengar dari kami'),
          const AutoSizeText('Dengarkan pengalaman mereka'),
          const SizedBox(
            height: 30,
          ),
          _getStoryWidgets(context),
        ],
      ),
    );
  }
}
