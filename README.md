# CQLBr Library for Delphi/Lazaruz

Criteria Query Language é uma Library que provê escritas através de uma interface permitindo mapear de forma orientada a objeto, toda sintaxe de comandos para realizar as operações de consulta, inclusão, alteração e exclusão em banco de dados.

Durante o desenvolvimento de software, é evidente a preocupação em que se tem em aumentar a produtividade e manter a compatibilidade. No que se refere a banco de dados, temos na maioria dos casos quebra de compatibilidade por necessidade de escrever sintaxe que acaba sendo particularidade de um determinado banco de dados, foi ai que CQLBr nasceu, ele foi projetado, para que a escrita de querys seja unica para todos os banco dados. Ao gerar uma query com CQLBr, ele irá te possibilitar mudar de banco de dados em um sistema, sem ter que refaturar querys com particularidades do banco substituído.

<p align="center">
  <a href="https://www.isaquepinheiro.com.br">
    <img src="https://github.com/HashLoad/CQLBr/blob/master/Images/cqlbr_framework.png" width="200" height="200">
  </a>
</p>

## 🏛 Delphi Versions
Embarcadero Delphi XE e superior.

## ⚙️ Instalação
Instalação usando o [`boss install`]
```sh
boss install "https://github.com/HashLoad/cqlbr"
```

## ⚡️ Como usar

### SELECT

```Delphi
  /// <summary>
  ///   SELECT * FROM CLIENTES WHERE (ID_CLIENTE = 1) AND (ID >= 10) AND (ID <= 20)
  /// </summary>
  TCQL.New(dbnFirebird)
      .Select
      .All
      .From('CLIENTES')
      .Where('ID_CLIENTE = 1')
      .&And('ID').GreaterEqThan(10)
      .&And('ID').LessEqThan(20)
    .AsString;
	
  
  /// <summary>
  ///   SELECT ID_CLIENTE, NOME_CLIENTE, (CASE TIPO_CLIENTE WHEN 0 THEN ''FISICA'' WHEN 1 THEN ''JURIDICA'' ELSE ''PRODUTOR'' END) AS TIPO_PESSOA FROM CLIENTES;
  /// </summary>
  TCQL.New(dbnFirebird)
      .Select
      .Column('ID_CLIENTE')
      .Column('NOME_CLIENTE')
      .Column('TIPO_CLIENTE')
        .&Case
          .When('0').&Then(CQL.Q('FISICA'))
          .When('1').&Then(CQL.Q('JURIDICA'))
                    .&Else('''PRODUTOR''')
        .&End
        .&As('TIPO_PESSOA')
        .From('CLIENTES')
    .AsString);
	
  /// <summary>
  ///   'SELECT * FROM CLIENTES WHERE (NOME LIKE ''%VALUE%'')';
  /// </summary>
  TCQL.New(dbnFirebird)
      .Select
      .All
      .From('CLIENTES')
      .Where('NOME').LikeFull('VALUE')
    .AsString);
	
  /// <summary>
  ///   'SELECT * FROM CLIENTES WHERE (VALOR IN (1, 2, 3))';
  /// </summary>
  TCQL.New(dbnFirebird)
      .Select
      .All
      .From('CLIENTES')
      .Where('VALOR').&In([1, 2, 3])
    .AsString);

  /// <summary>
  ///   'SELECT * FROM CLIENTES WHERE (NOT EXISTS (SELECT IDCLIENTE FROM PEDIDOS WHERE (PEDIDOS.IDCLIENTE = CLIENTES.IDCLIENTE)))';
  /// </summary>
  TCQL.New(dbnFirebird)
      .Select
      .All
      .From('CLIENTES')
      .Where.NotExists( TCQL.New(dbnFirebird)
                            .Select
                            .Column('IDCLIENTE')
                            .From('PEDIDOS')
                            .Where('PEDIDOS.IDCLIENTE').Equal('CLIENTES.IDCLIENTE')
                        .AsString)
    .AsString);
	
	
```

### INSERT

```Delphi
  /// <summary>
  ///   'INSERT INTO CLIENTES (ID_CLIENTE, NOME_CLIENTE) VALUES (''1'', ''MyName'')';
  /// </summary>
  TCQL.New(dbnFirebird)
      .Insert
      .Into('CLIENTES')
      .&Set('ID_CLIENTE', '1')
      .&Set('NOME_CLIENTE', 'MyName')
    .AsString);
```

### UPDATE

```Delphi
  /// <summary>
  ///   'UPDATE CLIENTES SET ID_CLIENTE = ''1'', NOME_CLIENTE = ''MyName'' WHERE ID_CLIENTE = 1';
  /// </summary>  
  TCQL.New(dbnFirebird)
      .Update('CLIENTES')
      .&Set('ID_CLIENTE', '1')
      .&Set('NOME_CLIENTE', 'MyName')
      .Where('ID_CLIENTE = 1')
    .AsString);
```

### DELETE

```Delphi
  /// <summary>
  ///   'DELETE FROM CLIENTES WHERE ID_CLIENTE = 1';
  /// </summary>  
  TCQL.New(dbnFirebird)
      .Delete
      .From('CLIENTES')
      .Where('ID_CLIENTE = 1')
    .AsString);
```

## ✍️ License
[![License](https://img.shields.io/badge/Licence-LGPL--3.0-blue.svg)](https://opensource.org/licenses/LGPL-3.0)

## ⛏️ Contribuição

Nossa equipe adoraria receber contribuições para este projeto open source. Se você tiver alguma ideia ou correção de bug, sinta-se à vontade para abrir uma issue ou enviar uma pull request.

[![Issues](https://img.shields.io/badge/Issues-channel-orange)](https://github.com/HashLoad/ormbr/issues)

Para enviar uma pull request, siga estas etapas:

1. Faça um fork do projeto
2. Crie uma nova branch (`git checkout -b minha-nova-funcionalidade`)
3. Faça suas alterações e commit (`git commit -am 'Adicionando nova funcionalidade'`)
4. Faça push da branch (`git push origin minha-nova-funcionalidade`)
5. Abra uma pull request

## 📬 Contato
[![Telegram](https://img.shields.io/badge/Telegram-channel-blue)](https://t.me/hashload)

## 💲 Doação
[![Doação](https://img.shields.io/badge/PagSeguro-contribua-green)](https://pag.ae/bglQrWD)
