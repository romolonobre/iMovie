abstract class BiometricsAuthState {}

class BiometricsIdleState extends BiometricsAuthState {}

class BiometricsAuthSucessState extends BiometricsAuthState {}

class BiometricsAuthErrorState extends BiometricsAuthState {
  final String errorMessage;

  BiometricsAuthErrorState({required this.errorMessage});
}
