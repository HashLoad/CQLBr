# CQLBr [![License](https://img.shields.io/cran/l/gnulesser.svg)](https://opensource.org/licenses/LGPL-3.0)

## CQLBr Framework for Delphi/Lazaruz
Criteria Query Language é um framework que provê escritas através de uma interface que permite mapear de forma orientada a objeto gerando toda sintaxe do comandos para realizar as operações de consulta, inclusão, alteração e exclusão em banco de dados, o MCQ só gera o comando mas não o executa.

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