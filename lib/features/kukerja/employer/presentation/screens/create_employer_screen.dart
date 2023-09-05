import 'package:flutter/material.dart';
import 'package:kukerja_web/features/kukerja/employer/presentation/providers/employer_provider.dart';
import 'package:kukerja_web/features/kukerja/employer/presentation/widgets/create_employer_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../core/domain/entities/api_status.dart';
import '../../../../../core/helpers/api_response.dart';
import '../../../../../core/widgets/app_loading_widget.dart';

class CreateEmployerScreen extends StatefulWidget {
  static const String route = "create";

  const CreateEmployerScreen({Key? key}) : super(key: key);

  @override
  State<CreateEmployerScreen> createState() => _CreateEmployerScreenState();
}

class _CreateEmployerScreenState extends State<CreateEmployerScreen> {
  @override
  void initState() {
    super.initState();

    context.read<EmployerProvider>().initData();
  }

  Widget _initWidget(BuildContext context) {
    late Widget readyWidget;

    APIResponse apiResponse = context.watch<EmployerProvider>().apiResponse;

    if (apiResponse.status == APIStatus.completed) {
      readyWidget = const CreateEmployerWidget();
    } else if (apiResponse.status == APIStatus.loading) {
      readyWidget = const AppLoadingWidget();
    } else {
      readyWidget = Center(child: Text(apiResponse.message!));
    }

    return readyWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _initWidget(context),
      ),
    );
  }
}
