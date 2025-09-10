import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tickme/providers/tick_categories_provider.dart';
import 'package:tickme/views/widgets/home/tick_app_bar.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(tickCategoriesProvider);

    return repository.when(
        data: (categories) => Scaffold(
              appBar: TickAppBar(categories: categories),
              body: _buildBody(categories),
            ),
        error: (error, stack) => Scaffold(
              appBar: AppBar(title: Text('Error')),
              body: Center(child: Text('Error: $error')),
            ),
        loading: () => Scaffold(
              appBar: AppBar(title: Text('Loading')),
              body: Center(child: CircularProgressIndicator()),
            ));
  }

  Widget _buildBody(TickCategoriesState categories) {
    return Center(child: Text('Home'));
  }
}
