

enum HeaterStatus{
  off(0), auto(3), low(1), high(2);


  final int id;
  const HeaterStatus(this.id);

  bool get isOff => this == HeaterStatus.off;
  bool get isAuto => this == HeaterStatus.auto;
  bool get isLow => this == HeaterStatus.low;
  bool get isHigh => this == HeaterStatus.high;
}

class HeaterStatusUtil{
  HeaterStatusUtil._();


  static HeaterStatus getState(int id){
    if(id == HeaterStatus.auto.id){
      return HeaterStatus.auto;
    } else if(id == HeaterStatus.low.id){
      return HeaterStatus.low;
    } else if(id == HeaterStatus.high.id){
      return HeaterStatus.high;
    }


    return HeaterStatus.off;
  }

}