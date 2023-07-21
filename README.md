# CQLBr Library for Delphi/Lazarus

Criteria Query Language is a library that provides writing through an interface, allowing the mapping of object-oriented syntax for performing database query, insert, update, and delete operations.

During software development, there is a clear concern about increasing productivity and maintaining compatibility. Regarding databases, in most cases, there is a compatibility break due to the need to write syntax that becomes specific to a particular database. This is where CQLBr comes in. It is designed so that query writing is unique for all databases. When generating a query with CQLBr, it allows you to switch between databases in a system without having to rewrite queries with specific details of the replaced database.

<p align="center">
  <a href="https://www.isaquepinheiro.com.br">
    <img src="https://github.com/HashLoad/CQLBr/blob/master/Images/cqlbr_framework.png" width="200" height="200">
  </a>
</p>

## 🏛 Delphi versions
Embarcadero Delphi XE and above.

## ⚙️ Install
Installation using [`boss install`]
```sh
boss install cqlbr
```

## ⚡️ How to use

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

## ⛏️ Contribution

Our team would love to receive contributions to this open-source project. If you have any ideas or bug fixes, feel free to open an issue or submit a pull request..

[![Issues](https://img.shields.io/badge/Issues-channel-orange)](https://github.com/HashLoad/ormbr/issues)

To submit a pull request, follow these steps:

1. Fork the project
2. Create a new branch (`git checkout -b my-new-feature`)
3. Make your changes and commit (`git commit -am 'Adding new feature'`)
4. Push the branch (`git push origin my-new-feature`)
5. Open a pull request.

## 📬 Contact
[![Telegram](https://img.shields.io/badge/Telegram-channel-blue)](https://t.me/hashload)

## 💲 Donation
[![Doação](https://img.shields.io/badge/PagSeguro-contribua-green)](https://pag.ae/bglQrWD)
