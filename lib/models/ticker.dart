class Ticker {
  /// Stream to emit values for count down timer.
  /// 
  
  const Ticker();
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(
        const Duration(
          seconds: 1,
        ),
        (x) => ticks - x - 1).take(ticks);
  }
}
