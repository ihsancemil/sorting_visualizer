import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import './bloc.dart';


class SimpleBlocDelegate extends BlocDelegate{
  @override
  void onTransition(Bloc bloc, Transition transition){
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

class SortingAlgorithmBloc extends Bloc<SortingAlgorithmEvent, SortingAlgorithmState> {

  SortingAlgorithmBloc() {
    BlocSupervisor.delegate = SimpleBlocDelegate();
  }

  @override
  SortingAlgorithmState get initialState => ListChangedState(_generateRandomList(10));

  @override
  Stream<SortingAlgorithmState> mapEventToState(
    SortingAlgorithmEvent event,
  ) async* {
    if (event is BubbleSort) {
      final list = _clone(event.list);
      yield*_bubbleSort(list);
    } else if (event is ShuffleList){
      yield ListChangedState(_generateRandomList(10));
    } else if (event is MergeSort) {
      final list = _clone(event.list);
      yield*_mergeSort(list, 0, list.length);
    }
  }

  Stream<SortingAlgorithmState> _bubbleSort(List<double> list) async* {
    for (int i = 0; i < list.length-1; i++) {
      for (int j = 0; j < list.length-i-1; j++){
        if (list[j] < list[j+1]) {
          var temp = list[j];
          list[j] = list[j+1];
          list[j+1] = temp;
          yield ListChangedState(_clone(list));
          await Future.delayed(Duration(milliseconds: 50));
        }
      }
    }
  }

  Stream<SortingAlgorithmState> _mergeSort(List<double> list, int startIndex, int endIndex) async* {
    if (endIndex - startIndex > 1) {
      var midIndex = ((endIndex - startIndex) / 2).floor();

      yield* _mergeSort(_clone(list), startIndex, midIndex);
      yield* _mergeSort(_clone(list), midIndex, endIndex);

      var leftIndex = startIndex;
      var rightIndex = midIndex;
      var index = startIndex;

      var cloneList = _clone(list);
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
        yield ListChangedState(_clone(list));
        await Future.delayed(Duration(microseconds:50));
      }
    }
  }

  List<double> _clone(List<double> list){
    return List.from(list).cast<double>();
  }

  List<double> _generateRandomList(int size) {
    return List<double>.generate(size, (i) => Random().nextDouble());
  }
}
