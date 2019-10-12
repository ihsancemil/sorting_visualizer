import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorting_visualizer/widgets/list_widget.dart';

import 'bloc/bloc.dart';

void main() => runApp(SortingApp());

class SortingApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sorting Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SortingPage(),
    );
  }
}

class SortingPage extends StatefulWidget {
  SortingPage({Key key}) : super(key: key);


  @override
  _SortingState createState() => _SortingState();
}

class _SortingState extends State<SortingPage> {

  final SortingAlgorithmBloc _bloc = new SortingAlgorithmBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          actions: <Widget>[
            PopupMenuButton<Function>(
              onSelected: (selected) {selected();},
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<Function>(
                    child: Text("Buble sort"),
                    value: () => state is ListChangedState ? _bloc.dispatch(BubbleSort(state.list)): () => {}
                  ),
                  PopupMenuItem<Function>(
                    child: Text("Merge sort"),
                    value: () => state is ListChangedState ? _bloc.dispatch(MergeSort(state.list)): () => {}
                  )
                ];
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            _bloc.dispatch(ShuffleList());
          },
        ),
        body: Container(
          alignment: Alignment.bottomCenter,
          child: Container (
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: state is ListChangedState ? ListWidget(list: state.list): Container(),
          ) 
        )
      ),
    );
  }
}
