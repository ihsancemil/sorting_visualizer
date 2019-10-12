import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class SortingAlgorithmBloc extends Bloc<SortingAlgorithmEvent, SortingAlgorithmState> {
  @override
  SortingAlgorithmState get initialState => ListChangedState(_generateRandomList(20));

  @override
  Stream<SortingAlgorithmState> mapEventToState(
    SortingAlgorithmEvent event,
  ) async* {
    if (event is BubbleSort) {
      yield* _bubbleSort(event.list);
    } else if (event is ShuffleList){
      yield ListChangedState(_generateRandomList(20));
    } else if (event is MergeSort) {
      yield* _mergeSort(event.list, 0, event.list.length);
    }
  }

  Stream<SortingAlgorithmState> _bubbleSort(List<double> list) async* {
    for (int i = 0; i < list.length-1; i++) {
      for (int j = 0; j < list.length-i-1; j++){
        if (list[j] > list[j+1]) {
          var temp = list[j];
          list[j] = list[j+1];
          list[j+1] = temp; 
          yield ListChangedState(list);
          await Future.delayed(Duration(milliseconds: 50));
        }
      }
    }
  }

  Stream<SortingAlgorithmState> _mergeSort(List<double> list, int startIndex, int endIndex) async* {
    if (endIndex - startIndex > 1) {
      var midIndex = ((endIndex - startIndex) / 2).floor();

      yield* _mergeSort(list, startIndex, midIndex);
      yield* _mergeSort(list, midIndex, endIndex);

      var leftIndex = startIndex;
      var rightIndex = midIndex;
      var index = startIndex;

      var cloneList = list.toList();
      while (leftIndex < midIndex || rightIndex < endIndex){
        if (leftIndex == midIndex || cloneList[rightIndex] > cloneList[leftIndex]){
          list[index] = cloneList[rightIndex];
          rightIndex += 1;
          index += 1; 
        } else {
          list[index] = cloneList[leftIndex];
          leftIndex += 1;
          index += 1;
        }
        yield ListChangedState(list);
        Future.delayed(Duration(microseconds:50));
      }
    }
  }

  List<double> _generateRandomList(int size) {
    return List<double>.generate(size, (i) => Random().nextDouble());
  }
}
