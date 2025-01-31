unit Main.Data.Types;

interface

uses
  Cmon.DataStorage;

type
  TSubData = class
  private
    [Storage, Default(100)]
    FSomeInteger: Integer;
    [Storage, Default('Bar')]
    FSomeString: string;
  public
    property SomeInteger: Integer read FSomeInteger write FSomeInteger;
    property SomeString: string read FSomeString write FSomeString;
  end;

type
  [StorageKey('Settings')]
  TMainData = class
  private
    [Storage, Default(10)]
    FSomeInteger: Integer;
    [Storage, Default('Foo')]
    FSomeString: string;
    [Storage('Sub'), Default]
    FSubData: TSubData;
  public
    constructor Create;
    destructor Destroy; override;
    property SomeInteger: Integer read FSomeInteger write FSomeInteger;
    property SomeString: string read FSomeString write FSomeString;
    property SubData: TSubData read FSubData;
  end;

var
  MainData: TMainData = nil;

implementation

constructor TMainData.Create;
begin
  inherited Create;
  FSubData := TSubData.Create();
end;

destructor TMainData.Destroy;
begin
  FSubData.Free;
  inherited Destroy;
end;

initialization
  MainData := TMainData.Create;
finalization
  MainData.Free;
  MainData := nil;
end.
