import 'dart:math';

class Pergunta {
  final String enunciado;
  final List<String> opcoes;
  final int indiceCorreto;
  final String explicacao;
  final String? imagemAsset;

  const Pergunta({
    required this.enunciado,
    required this.opcoes,
    required this.indiceCorreto,
    required this.explicacao,
    this.imagemAsset,
  });
}

class Exame {
  final String titulo;
  final int numeroPerguntas;

  const Exame({
    required this.titulo,
    this.numeroPerguntas = 20,
  });
}

const List<Pergunta> bancoDePerguntas = [
  // ==========================================
  // PERGUNTAS COM IMAGEM
  // ==========================================
  Pergunta(
    enunciado: 'O que indica a marca rodoviária branca na imagem?',
    opcoes: [
      'Indica a existência de bandas sonoras.',
      'Indica a redução de filas de trânsito.',
      'Indica a existência de lombas.',
      'Indica a proximidade de passadeira de peões.',
    ],
    indiceCorreto: 3,
    explicacao: 'As marcas em ziguezague indicam a proximidade de uma passadeira de peões.',
    imagemAsset: 'assets/sinais/marca_zigzag.png', 
  ),
  Pergunta(
    enunciado: 'O condutor do veículo está a cometer uma infração. Qual é a classificação desta contravenção?',
    opcoes: ['Leve.', 'Grave.', 'Média.', 'Muito grave.'],
    indiceCorreto: 1,
    explicacao: 'Transportar passageiros ou objetos de forma a comprometer a segurança é uma contravenção grave.',
    imagemAsset: 'assets/sinais/foto_carro_sacos.png', 
  ),
  Pergunta(
    enunciado: 'Circulando à noite nesta via, a que distância mínima deve acender os médios?',
    opcoes: ['Pelo menos 50 metros.', 'Pelo menos 200 metros.', 'Pelo menos 100 metros.', 'Pelo menos 25 metros.'],
    indiceCorreto: 2,
    explicacao: 'Em vias sem iluminação pública, os médios devem estar acesos a pelo menos 100 metros.',
    imagemAsset: 'assets/sinais/foto_veiculo_noite.png', 
  ),
  Pergunta(
    enunciado: 'O sinal representado na imagem significa:',
    opcoes: ['Sentido proibido.', 'Trânsito proibido.', 'Trânsito proibido a automóveis ligeiros de passageiros.', 'Trânsito proibido a todos os veículos.'],
    indiceCorreto: 1,
    explicacao: 'O sinal de círculo vermelho com barra diagonal significa trânsito proibido.',
    imagemAsset: 'assets/sinais/sinal_transito_proibido.png', 
  ),
  Pergunta(
    enunciado: 'Numa auto-estrada, como mostra a imagem, pode-se inverter o sentido de marcha?',
    opcoes: ['Sempre que possível.', 'Nunca.', 'Sim, se a manobra for feita lentamente.', 'Apenas em locais sinalizados.'],
    indiceCorreto: 1,
    explicacao: 'Nunca é permitido inverter o sentido de marcha numa auto-estrada.',
    imagemAsset: 'assets/sinais/foto_autoestrada.png', 
  ),
  Pergunta(
    enunciado: 'O sinal representado na imagem indica:',
    opcoes: [
      'Paragem proibida a veículos que transportam substâncias perigosas.',
      'Paragem obrigatória para veículos que transportam substâncias perigosas.',
      'Área reservada para veículos que transportam substâncias perigosas.',
      'Trânsito proibido a veículos com substâncias perigosas.',
    ],
    indiceCorreto: 1,
    explicacao: 'O sinal indica paragem obrigatória para veículos que transportam substâncias perigosas.',
    imagemAsset: 'assets/sinais/sinal_substancias_perigosas.png', 
  ),
  Pergunta(
    enunciado: 'O sinal representado na imagem (braço do condutor) indica:',
    opcoes: ['Que vai voltar para o lado esquerdo do volante.', 'Que vai voltar para o lado direito do volante.', 'Que vai reduzir a velocidade.', 'Que vai parar.'],
    indiceCorreto: 2,
    explicacao: 'O braço esticado horizontalmente indica que o condutor vai reduzir a velocidade.',
    imagemAsset: 'assets/sinais/foto_braco_condutor.png', 
  ),
  Pergunta(
    enunciado: 'O sinal representado na imagem indica:',
    opcoes: ['A presença de cancela motorizada ao centro.', 'A presença de ponte móvel.', 'A presença de entroncamento oblíquo à esquerda.', 'A presença de ponte estreita.'],
    indiceCorreto: 1,
    explicacao: 'O sinal indica a presença de ponte móvel.',
    imagemAsset: 'assets/sinais/sinal_ponte_movel.png', 
  ),
  Pergunta(
    enunciado: 'Nos veículos de mercadorias, como mostra a imagem, a carga deve ser disposta de modo a que:',
    opcoes: [
      'O principal peso fique sobre o eixo da retaguarda.',
      'Fique livre o maior espaço possível à retaguarda da caixa de carga.',
      'Seja assegurado o equilíbrio do veículo, parado ou em movimento.',
      'O peso fique distribuído apenas no lado direito.',
    ],
    indiceCorreto: 2,
    explicacao: 'A carga deve ser disposta de modo a assegurar o equilíbrio do veículo, parado ou em movimento.',
    imagemAsset: 'assets/sinais/foto_camiao_balanca.png', 
  ),
  Pergunta(
    enunciado: 'O sinal representado na imagem significa:',
    opcoes: [
      'Trânsito proibido a peões, animais e veículos automóveis.',
      'Trânsito proibido a peões, animais e veículos não automóveis.',
      'Trânsito proibido a animais e veículos não automóveis.',
      'Trânsito proibido a peões e animais.',
    ],
    indiceCorreto: 1,
    explicacao: 'O sinal significa trânsito proibido a peões, animais e veículos não automóveis.',
    imagemAsset: 'assets/sinais/sinal_proibicao_multipla.png', 
  ),
  Pergunta(
    enunciado: 'Na imagem, o veículo pesado desloca-se numa via com várias faixas. Os automóveis pesados de passageiros, fora das localidades, não devem exceder a velocidade instantânea de:',
    opcoes: ['80 km/h.', '120 km/h.', '100 km/h.', '90 km/h.'],
    indiceCorreto: 0,
    explicacao: 'Os automóveis pesados de passageiros, fora das localidades, não devem exceder 80 km/h.',
    imagemAsset: 'assets/sinais/foto_camiao_estrada.png', 
  ),

  // ==========================================
  // PERGUNTAS SEM IMAGEM (TEXTO)
  // ==========================================
  Pergunta(
    enunciado: 'Os automóveis classificam-se em:',
    opcoes: ['Ligeiros e Pesados.', 'Ligeiros, Pesados e Motociclos.', 'Motociclos, Ciclomotores, Triciclos, Quadriciclos, ligeiros e Pesados.', 'Ligeiros, Pesados e Mistos.'],
    indiceCorreto: 2,
    explicacao: 'Os automóveis classificam-se em motociclos, ciclomotores, triciclos, quadriciclos, ligeiros e pesados.',
  ),
  Pergunta(
    enunciado: 'É aconselhável viajar à noite para evitar a fadiga?',
    opcoes: ['Não, porque o sono aparece mais facilmente.', 'Sim, se a viagem é longa.', 'Sim, porque há menos tráfego.', 'Sim, viajar durante a noite é sempre mais seguro.'],
    indiceCorreto: 0,
    explicacao: 'Não é aconselhável, porque o sono aparece mais facilmente durante a noite.',
  ),
  Pergunta(
    enunciado: 'Que veículo deve retroceder para dar passagem ao outro, numa passagem estreita sem sinalização onde não seja possível efectuar o cruzamento?',
    opcoes: ['O veículo mais pesado.', 'O veículo com maior largura.', 'O veículo que está mais próximo do local em que o cruzamento seja possível.', 'O veículo que desce se for numa via de inclinação acentuada.'],
    indiceCorreto: 2,
    explicacao: 'Deve retroceder o veículo que está mais próximo do local onde o cruzamento seja possível.',
  ),
  Pergunta(
    enunciado: 'Deve utilizar-se as luzes de perigo...',
    opcoes: ['ao estacionar em segunda fila.', 'para avisar os outros utentes que o veículo vai fazer marcha atrás.', 'em caso de imobilização por acidente ou avaria, se origina perigo para os demais utentes da via.', 'apenas quando o veículo esteja a ser rebocado.'],
    indiceCorreto: 2,
    explicacao: 'As luzes de perigo devem usar-se em caso de imobilização por acidente ou avaria que origine perigo.',
  ),
  Pergunta(
    enunciado: 'O uso do cinto de segurança:',
    opcoes: ['melhora o tempo de reacção.', 'aumenta a gravidade das lesões em caso de acidente.', 'reduz a distância de travagem.', 'reduz as distracções.'],
    indiceCorreto: 1,
    explicacao: 'O uso do cinto de segurança reduz o risco de lesões graves em caso de acidente.',
  ),
  Pergunta(
    enunciado: 'Considera-se morte por acidente de viação:',
    opcoes: ['Aquela que ocorre até 30 dias após o registo do sinistro.', 'Só aquela que ocorre no local do sinistro.', 'Só aquela que ocorre à caminho da unidade sanitária.', 'Aquela que ocorre 30 dias depois do registo do sinistro.'],
    indiceCorreto: 0,
    explicacao: 'Considera-se morte por acidente de viação aquela que ocorre até 30 dias após o sinistro.',
  ),
  Pergunta(
    enunciado: 'Os peões, para atravessar a faixa de rodagem...',
    opcoes: ['podem fazê-lo sem utilizar as passagens para peões, se não existe nenhuma a uma distância inferior a 10 m.', 'estão sempre obrigados a utilizar a passagem desnivelada para peões.', 'têm sempre prioridade de passagem.', 'devem certificar-se de que a distância e velocidade dos veículos permite fazê-lo sem perigo de acidente.'],
    indiceCorreto: 3,
    explicacao: 'Os peões devem certificar-se de que a distância e velocidade dos veículos permitem atravessar sem perigo.',
  ),
  Pergunta(
    enunciado: 'Todos os condutores de veículos ou animais são obrigados a...',
    opcoes: ['abandonar os veículos nos locais de estacionamento sem motivo justificado.', 'reduzir ou suspender intencionalmente a circulação, formando filas de trânsito desnecessárias.', 'obedecer ao sinal de paragem feito pelas autoridades com competência para fiscalização do trânsito.', 'circular sempre à velocidade máxima permitida.'],
    indiceCorreto: 2,
    explicacao: 'Todos os condutores são obrigados a obedecer ao sinal de paragem das autoridades de fiscalização.',
  ),
];

const List<Exame> todosOsExames = [
  Exame(titulo: 'Exame 1 (Modo Teste)', numeroPerguntas: 21),
  Exame(titulo: 'Exame 2 (Modo Teste)', numeroPerguntas: 21),
];