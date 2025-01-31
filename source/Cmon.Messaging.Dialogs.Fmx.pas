unit Cmon.Messaging.Dialogs.Fmx;

interface

uses
  System.Messaging,
  Cmon.Messaging.Dialogs;

type
  TDlgMessageHandlerVcl = class(TDlgMessageHandler)
  strict private
  class var
    FAutoRegisterHandler: Boolean;
  strict protected
    procedure DlgMessage(const Sender: TObject; const M: TMessage); override;
  public
    class property AutoRegisterHandler: Boolean read FAutoRegisterHandler write FAutoRegisterHandler;
  end;

implementation

uses
  System.UITypes, System.SysUtils, System.Classes,
  FMX.Dialogs,
  Cmon.Messaging, Cmon.Initializing;

procedure TDlgMessageHandlerVcl.DlgMessage(const Sender: TObject; const M: TMessage);
begin
  var msg := M as TDlgMessage;
  msg.Answer := MessageDlg(msg.MessageText, msg.MsgDlgType, msg.Buttons, msg.HelpContext);
end;

var
  Instance: TDlgMessageHandlerVcl = nil;

{ will be called in Application.Initialize after all other initialization code has been executed }
procedure InitHandler;
begin
  if TDlgMessage.AutoRegisterHandler and TDlgMessageHandlerVcl.AutoRegisterHandler then
    Instance := TDlgMessageHandlerVcl.Create;
end;

initialization
  TDlgMessageHandlerVcl.AutoRegisterHandler := True;
  TInitialize.AddInitProc(InitHandler);
finalization
  Instance.Free;
end.
