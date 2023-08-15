void main() {
  int num = 10;

  if (num > 0) {
    print("Number is positive");

    if (num % 2 == 0) {
      print("Number is even");
    } else {
      print("Number is odd");
    }
  } else if (num < 0) {
    print("Number is negative");
  } else {
    print("Number is zero");
  }
}