table 50103 "Issued Request Header"
{
    Caption = 'Issued Request Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; "Requester No."; Code[20])
        {
            Caption = 'Meals Subscriber No.';
            DataClassification = CustomerContent;
            TableRelation = Contact;
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(4; "Name 2"; Text[100])
        {
            Caption = 'Name 2';
            DataClassification = CustomerContent;
        }
        field(5; "Kitchen Code"; Code[20])
        {
            Caption = 'Kitchen Center';
            DataClassification = CustomerContent;
            TableRelation = "AMA Kitchen" where("Responsibility Center" = field("Responsibility Center"));
        }
        field(6; Building; Text[30])
        {
            Caption = 'Building';
            DataClassification = CustomerContent;
        }
        field(7; Floor; Text[10])
        {
            Caption = 'Floor';
            DataClassification = CustomerContent;
        }
        field(8; Room; Text[10])
        {
            Caption = 'Room';
            DataClassification = CustomerContent;
        }
        field(9; "Meal Subscriber Type"; Option)
        {
            Caption = 'Subscriber Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Internal,Employee,Exernal';
            OptionMembers = " ",Internal,Employee,Exernal;
        }
        // field(10; Class; Option)
        // {
        //     Caption = 'Class';
        //     DataClassification = CustomerContent;
        // }
        field(11; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            DataClassification = CustomerContent;
            TableRelation = Language;
        }
        field(12; "Shortcut Dimension Code 1"; Code[20])
        {
            Caption = 'Shortcut Dimension Code 1';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = const(1));
        }
        field(13; "Shortcut Dimension Code 2"; Code[20])
        {
            Caption = 'Shortcut Dimension Code 2';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = const(2));
        }
        field(14; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            DataClassification = CustomerContent;
            TableRelation = "Reason Code";
        }
        field(15; "Request Date"; Date)
        {
            Caption = 'Request Date';
            DataClassification = CustomerContent;
        }
        field(16; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = CustomerContent;
        }
        field(17; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = CustomerContent;
        }
        field(18; "Posting Description"; Text[100])
        {
            Caption = 'Posting Description';
            DataClassification = CustomerContent;
        }
        field(19; "Comment "; Boolean)
        {
            CalcFormula = Exist("AMA Request Comment Line" WHERE(Type = const(Request), "No." = field("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Pre-Assigned No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(22; "Pre-Assigned Issuing No."; Code[20])
        {
            Caption = 'Issuing No. ';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(23; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Code';
            DataClassification = CustomerContent;
            TableRelation = "Responsibility Center";
        }
        field(24; "Restaurant Code"; Code[20])
        {
            Caption = 'Restaurant Code';
            DataClassification = CustomerContent;
            TableRelation = "AMA Restaurant" where("Production Kitchen Code" = field("Kitchen Code"));
        }
        field(25; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(26; "Type"; enum "Contact Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(27; "Company No."; Code[20])
        {
            Caption = 'Company No.';
            DataClassification = CustomerContent;
            TableRelation = Contact where(Type = const(Company));
        }
        field(28; "Company Name"; Text[100])
        {
            Caption = 'Company Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(30; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            DataClassification = SystemMetadata;
        }
        field(31; "User ID"; Code[50])
        {
            Caption = 'User Id';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
        field(32; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Requester No.", "Request Date")
        {
        }
    }

    trigger OnDelete()
    var
        RequestCommentLine: Record "AMA Request Comment Line";
    begin
        TestField("No. Printed");

        LockTable();
        // RequestIssue.DeleteIssuedRequestLines(Rec);

        RequestCommentLine.SETRANGE(Type, RequestCommentLine.Type::"Issued Request");
        RequestCommentLine.SETRANGE("No.", "No.");
        RequestCommentLine.DELETEALL;
    end;
}
