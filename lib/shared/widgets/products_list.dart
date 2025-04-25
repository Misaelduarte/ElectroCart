import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsList<B extends Bloc<dynamic, S>, S> extends StatelessWidget {
  final B bloc;
  final String title;
  final Widget Function(BuildContext context, S state) builder;
  final void Function(BuildContext context, S state)? listener;
  final bool Function(S previous, S current)? listenWhen;
  final bool Function(S previous, S current)? buildWhen;

  const ProductsList({
    Key? key,
    required this.bloc,
    required this.title,
    required this.builder,
    this.listener,
    this.listenWhen,
    this.buildWhen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.deepPurple.shade700,
      ),
      body: BlocConsumer<B, S>(
        bloc: bloc,
        listener: listener ?? (context, state) {},
        listenWhen: listenWhen,
        buildWhen: buildWhen,
        builder: builder,
      ),
    );
  }
}
