{
         CQL Brasil - Criteria Query Language for Delphi/Lazarus


                   Copyright (c) 2019, Isaque Pinheiro
                          All rights reserved.

                    GNU Lesser General Public License
                      Versão 3, 29 de junho de 2007

       Copyright (C) 2007 Free Software Foundation, Inc. <http://fsf.org/>
       A todos é permitido copiar e distribuir cópias deste documento de
       licença, mas mudá-lo não é permitido.

       Esta versão da GNU Lesser General Public License incorpora
       os termos e condições da versão 3 da GNU General Public License
       Licença, complementado pelas permissões adicionais listadas no
       arquivo LICENSE na pasta principal.
}

{ @abstract(CQLBr Framework)
  @created(18 Jul 2019)
  @author(Isaque Pinheiro <isaquesp@gmail.com>)
  @author(Site : https://www.isaquepinheiro.com.br)
}

unit cqlbr.reg;

interface

uses
  SysUtils,
  Windows,
  Graphics,
  ToolsApi;

implementation

const
  cCQLBrSOBRETITULO = 'CQLBr Framework for Delphi/Lazarus';
  cCQLBrVERSION = '1.0';
  cCQLBrRELEASE = '2019';
  cCQLBrSOBREDESCRICAO = 'CQLBr Framework https://www.isaquepinheiro.com.br/' + sLineBreak +
                               'Path Library ' + sLineBreak +
                               'Version : ' + cCQLBrVERSION + '.' + cCQLBrRELEASE;
  cCQLBrSOBRELICENCA = 'LGPL Version 3';

var
 GAboutBoxServices: IOTAAboutBoxServices = nil;
 GAboutBoxIndex: Integer = 0;

procedure RegisterAboutBox;
var
  LImage: HBITMAP;
begin
  if Supports(BorlandIDEServices, IOTAAboutBoxServices, GAboutBoxServices) then
  begin
    LImage  := LoadBitmap(FindResourceHInstance(HInstance), 'CQLBr');
    GAboutBoxIndex := GAboutBoxServices.AddPluginInfo(cCQLBrSOBRETITULO + ' ' + cCQLBrVERSION,
                                                      cCQLBrSOBREDESCRICAO,
                                                      LImage,
                                                      False,
                                                      cCQLBrSOBRELICENCA,
                                                      '',
                                                      otaafIgnored);
  end;
end;

procedure UnregisterAboutBox;
begin
 if (GAboutBoxIndex <> 0) and Assigned(GAboutBoxServices) then
 begin
   GAboutBoxServices.RemovePluginInfo(GAboutBoxIndex);
   GAboutBoxIndex := 0;
   GAboutBoxServices := nil;
  end;
end;

procedure AddSplash;
var
  LImage : HBITMAP;
  LSSS: IOTASplashScreenServices;
begin
  if Supports(SplashScreenServices, IOTASplashScreenServices, LSSS) then
  begin
    LImage := LoadBitmap(HInstance, 'CQLBr');
    LSSS.AddPluginBitmap(cCQLBrSOBRETITULO,
                         LImage,
                         False,
                         cCQLBrSOBRELICENCA,
                         '');
  end;
end;

initialization
  RegisterAboutBox;
  AddSplash;

finalization
  UnregisterAboutBox;

end.
