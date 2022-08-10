import 'package:fino/presentation/common/extensions/build_context_extensions.dart';
import 'package:fino/presentation/common/ui/app_try_again_error.dart';
import 'package:fino/presentation/common/ui/loading/app_loading_overlay.dart';
import 'package:fino/presentation/features/count/count_cubit.dart';
import 'package:fino/presentation/features/count/count_state.dart';
import 'package:fino/service_locator/app_service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountScreen extends StatefulWidget {
  const CountScreen({Key? key}) : super(key: key);

  @override
  State<CountScreen> createState() => _CountScreenState();
}

class _CountScreenState extends State<CountScreen> {
  late final _screenBloc = getIt<CountCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountCubit, CountState>(
      bloc: _screenBloc,
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(context.strings.countTitle),
                    Text(
                      '${state.number}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              ),
              if (state.isLoading) ...{
                const AppLoadingOverlay(),
              } else if (state.loadingException != null) ...{
                AppTryAgainError(
                  message: state.loadingException.toString(),
                  onTryAgain: _screenBloc.loadNumber,
                ),
              },
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _screenBloc.incrementNumber,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
