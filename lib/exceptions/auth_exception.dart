class AuthException implements Exception {
  static const Map<String, String> commonErrors = {
    'EMAIL_EXISTS': 'Email já cadastrado.',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida!',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        'Acesso bloqueado temporariamente. Tente mais tarde.',
    'EMAIL_NOT_FOUND': 'Email não encontrado.',
    'INVALID_PASSWORD': 'Senha inválida',
    'USER_DISABLED': 'A conta de usuário desabilitada.',
  };
  final String keyword;

  AuthException(this.keyword);

  @override
  String toString() {
    return commonErrors[keyword] ??
        'Ocorreu um erro no processo de autenticação.';
  }
}
