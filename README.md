# CQLBr Framework for Delphi/Lazaruz  -  [![License](https://img.shields.io/badge/Licence-LGPL--3.0-blue.svg)](https://opensource.org/licenses/LGPL-3.0)

**Criteria Query Language** é um framework que provê escritas através de uma interface permitindo mapear de forma orientada a objeto, toda sintaxe de comandos para realizar as operações de consulta, inclusão, alteração e exclusão em banco de dados.

O CQLBr nasceu, e foi projetado, para unificar a escrita de banco dados. Ao gerar uma query com CQLBr, ele irá te possibilitar mudar de banco de dados em um sistema, sem ter que refaturar querys com particularidades do banco substituído.

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
```