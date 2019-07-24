<p align="center">
  <a href="https://www.isaquepinheiro.com.br/">
    <img src="http://wirl.delphiblocks.com/assets/images/wirl-300.png" alt="Delphi RESTful Library" width="200" />
  </a>
</p>

# CQLBr [![License](https://img.shields.io/badge/License-Apache%202.0-yellowgreen.svg)](https://opensource.org/licenses/Apache-2.0)

## CQLBr Framework for Delphi/Lazaruz
Criteria Query Language é um framework que provê escritas através de uma interface que permite mapear de forma orientada a objeto gerando toda sintaxe do comandos para realizar as operações de consulta, inclusão, alteração e exclusão em banco de dados, o MCQ só gera o comando mas não o executa.

```Delphi
[Path('customers')]
TCustomerResource = class
public
  [GET]
  [Produces('TMediaType.APPLICATION_JSON')]
  function SelectCustomers: TCustomerList;

  [POST]
  [Consumes('TMediaType.APPLICATION_JSON')]
  [Produces('TMediaType.APPLICATION_JSON')]
  function InsertCustomer(ACustomer: TCustomer): TCustomer;
end;
```