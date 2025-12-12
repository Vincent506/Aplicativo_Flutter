// ==========================================================
//                      LOGGER
// ==========================================================
class Logger {
  static void log(String message) {
    final now = DateTime.now();
    log("[$now] $message");
  }
}

// ==========================================================
//            ENTIDADES DO SISTEMA
// ==========================================================

class Estudante {
  final int id;
  final String nome;

  Estudante(this.id, this.nome);
}

class Notificacao {
  final int id;
  final DateTime dataHora;
  final String mensagem;

  Notificacao(this.id, this.dataHora, this.mensagem);
}

class Servidor {
  final int id;
  final String nome;

  Servidor(this.id, this.nome);
}

class Ocorrencia {
  int idOcorr;
  DateTime dataHora;
  String categoria;
  String tipo;
  String nivel;
  String descricao;

  Estudante? estudante;
  Servidor? servidor;
  List<Notificacao> notificacoes = [];

  Ocorrencia({
    required this.idOcorr,
    required this.dataHora,
    required this.categoria,
    required this.tipo,
    required this.nivel,
    required this.descricao,
    this.estudante,
    this.servidor,
  });
}

//// ==========================================================
//                INTERFACE — CONTRATO
// ==========================================================

abstract class UsuarioSistema {
  void registrarOcorrencia(Ocorrencia ocorrencia);
  void editarOcorrencia(Ocorrencia ocorrencia);
  void excluirOcorrencia(Ocorrencia ocorrencia);
  void validarOcorrencia(Ocorrencia ocorrencia);
  void visualizarOcorrencias();
}

// ==========================================================
//      CLASSE BASE COM COMPORTAMENTO PADRÃO
// ==========================================================

abstract class UsuarioBase implements UsuarioSistema {
  @override
  void excluirOcorrencia(Ocorrencia ocorrencia) {
    throw Exception("Você não tem permissão para excluir ocorrências.");
  }

  @override
  void validarOcorrencia(Ocorrencia ocorrencia) {
    throw Exception("Você não tem permissão para validar ocorrências.");
  }
}

// ==========================================================
//             PROFESSOR / ASSISTENTE
// ==========================================================

class Professor extends UsuarioBase {
  @override
  void registrarOcorrencia(Ocorrencia ocorrencia) {
    Logger.log("Professor registrou uma nova ocorrência.");
  }

  @override
  void editarOcorrencia(Ocorrencia ocorrencia) {
    Logger.log("Professor editou sua ocorrência.");
  }

  @override
  void visualizarOcorrencias() {
    Logger.log("Professor visualizou suas ocorrências.");
  }
}

// ==========================================================
//                    COORDENADOR
// ==========================================================

class Coordenador extends UsuarioBase {
  @override
  void registrarOcorrencia(Ocorrencia ocorrencia) {
    Logger.log("Coordenador registrou uma ocorrência.");
  }

  @override
  void editarOcorrencia(Ocorrencia ocorrencia) {
    Logger.log("Coordenador editou uma ocorrência.");
  }

  @override
  void excluirOcorrencia(Ocorrencia ocorrencia) {
    Logger.log("Coordenador excluiu uma ocorrência.");
  }

  @override
  void validarOcorrencia(Ocorrencia ocorrencia) {
    Logger.log("Coordenador validou ocorrência.");
  }

  @override
  void visualizarOcorrencias() {
    Logger.log("Coordenador visualizou todas as ocorrências.");
  }
}

// ==========================================================
//                    RESPONSÁVEL
// ==========================================================

class Responsavel extends UsuarioBase {
  void confirmarLeitura(Ocorrencia ocorrencia) {
    Logger.log("Responsável confirmou a leitura da ocorrência.");
  }

  @override
  void registrarOcorrencia(Ocorrencia ocorrencia) {
    throw Exception("Responsáveis não podem registrar ocorrências.");
  }

  @override
  void editarOcorrencia(Ocorrencia ocorrencia) {
    throw Exception("Responsáveis não podem editar ocorrências.");
  }

  @override
  void visualizarOcorrencias() {
    Logger.log("Responsável visualizou as ocorrências do estudante.");
  }
}

// ==========================================================
//                       ESTUDANTE
// ==========================================================

class EstudanteUsuario extends UsuarioBase {
  @override
  void registrarOcorrencia(Ocorrencia ocorrencia) {
    throw Exception("Estudantes não podem registrar ocorrências.");
  }

  @override
  void editarOcorrencia(Ocorrencia ocorrencia) {
    throw Exception("Estudantes não podem editar ocorrências.");
  }

  @override
  void visualizarOcorrencias() {
    Logger.log("Estudante visualizou seu histórico.");
  }
}
