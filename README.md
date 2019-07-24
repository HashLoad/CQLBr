# CQLBr [![License](https://img.shields.io/badge/License-Apache%202.0-yellowgreen.svg)](https://opensource.org/licenses/Apache-2.0)

## CQLBr Framework for Delphi/Lazaruz
Criteria Query Language é um framework que provê escritas através de uma interface que permite mapear de forma orientada a objeto gerando toda sintaxe do comandos para realizar as operações de consulta, inclusão, alteração e exclusão em banco de dados, o MCQ só gera o comando mas não o executa.

```Delphi
// SELECT * FROM CLIENTES WHERE (ID_CLIENTE = 1) AND (ID >= 10) AND (ID <= 20)
TCQL.New(dbnFirebird)
    .Select
    .All
    .From('CLIENTES')
    .Where('ID_CLIENTE = 1')
    .&And('ID').GreaterEqThan(10)
    .&And('ID').LessEqThan(20)
.AsString;
	
// SELECT * FROM CLIENTES WHERE (ID_CLIENTE = 1) AND ((ID >= 10) OR (ID <= 20))
TCQL.New(dbnFirebird)
    .Select
    .All
    .From('CLIENTES')
    .Where('ID_CLIENTE = 1')
    .&And('ID').GreaterEqThan(10)
    .&Or('ID').LessEqThan(20)
.AsString	
```