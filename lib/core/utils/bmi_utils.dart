

double calculateBMI(double weight, double heightCm) {
  double heightM = heightCm / 100;
  return weight / (heightM * heightM);
}

String getHealthyRange(double heightCm) {
  double heightM = heightCm / 100;
  double minWeight = 18.5 * heightM * heightM;
  double maxWeight = 24.9 * heightM * heightM;
  return "${minWeight.toStringAsFixed(1)} kg - ${maxWeight.toStringAsFixed(1)} kg";
}
