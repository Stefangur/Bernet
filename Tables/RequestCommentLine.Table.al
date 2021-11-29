table 50105 "Request Comment Line"
{
    Caption = 'Request Comment Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Type"; Option)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            OptionMembers = Request,"Issued Request";
            OptionCaption = 'Request,IssuesRequest';
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            TableRelation = if (Type = const(Request)) "Request Header"
            else
            if (type = const("Issued Request")) "Issued Request Header";
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(4; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(5; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(6; Comment; Text[80])
        {
            Caption = 'Comment';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Type", "No.", "Line No.")
        {
            Clustered = true;
        }
    }

    procedure SetUpNewLine()
    var
        RequestCommentLine: Record "Request Comment Line";
    begin
        RequestCommentLine.SetRange(Type, Type);
        RequestCommentLine.SetRange("No.", "No.");
        RequestCommentLine.SetRange(Date, WorkDate());
        if not RequestCommentLine.Find('-') then
            Date := WorkDate();
    end;

}
