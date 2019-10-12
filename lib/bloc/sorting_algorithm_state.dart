import 'package:equatable/equatable.dart';

abstract class SortingAlgorithmState extends Equatable {
  const SortingAlgorithmState();
}

class ListChangedState extends SortingAlgorithmState {
  final List<double> list;

  ListChangedState(this.list);

  @override
  List<Object> get props => [this.list];
}
