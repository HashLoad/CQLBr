 |  | 
:----------------------------------------------------------------------| ----------------------------------------------------------------------------------------:| :-:
![CQLBr Framework](https://www.isaquepinheiro.com.br/imagens/cqlbrbitucket.png)  | [![pageseguro.png](http://www.ormbr.com.br/imagens/pagseguro.png)](https://pag.ae/bglQrWD)|


# CQLBr Framework for Delphi/Lazaruz   [![License](https://img.shields.io/badge/Licence-LGPL--3.0-blue.svg)](https://opensource.org/licenses/LGPL-3.0)

**Criteria Query Language** é um framework que provê escritas através de uma interface permitindo mapear de forma orientada a objeto, toda sintaxe de comandos para realizar as operações de consulta, inclusão, alteração e exclusão em banco de dados.

Durante o desenvolvimento de software, é evidente a preocupação em que se tem em aumentar a produtividade e manter a compatibilidade. No que se refere a banco de dados, temos na maioria dos casos quebra de compatibilidade por necessidade de escrever sintaxe que acaba sendo particularidade de um determinado banco de dados, foi ai que CQLBr nasceu, ele foi projetado, para que a escrita de querys para todos os banco dados seja unica. Ao gerar uma query com CQLBr, ele irá te possibilitar mudar de banco de dados em um sistema, sem ter que refaturar querys com particularidades do banco substituído.


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