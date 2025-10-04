class Triple<T, E, V> {
  T first;
  E second;
  V third;

  Triple(this.first, this.second, this.third);

  @override
  String toString() => 'Triple[$first, $second, $third]';
}
