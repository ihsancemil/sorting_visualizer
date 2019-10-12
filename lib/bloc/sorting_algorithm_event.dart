import 'package:equatable/equatable.dart';

abstract class SortingAlgorithmEvent extends Equatable {
  const SortingAlgorithmEvent();
}

class ShuffleList extends SortingAlgorithmEvent {

  ShuffleList();
  
  @override
  List<Object> get props => [];

}

class BubbleSort extends SortingAlgorithmEvent {
  final List<double> list;

  BubbleSort(this.list);
  
  @override
  List<Object> get props => [this.list];
}

class MergeSort extends SortingAlgorithmEvent {
  final List<double> list;

  MergeSort(this.list);
  
  @override
  List<Object> get props => [this.list];
}