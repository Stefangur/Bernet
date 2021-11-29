table 50101 "Request Header"
{
    Caption = 'Request Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    KitCatSetup.Get();
                    NoSeriesMgt.TestManual(KitCatSetup."Request Nos.");
                    "No. Series" := '';
                END;
                "Posting Description" := STRSUBSTNO(Text000, "No.");
            end;
        }
        field(2; "Requester No."; Code[20])
        {
            Caption = 'Meals Subscriber No.';
            DataClassification = CustomerContent;
            TableRelation = Contact;

            trigger OnValidate()
            var
                RequestMgmt: Codeunit "Request Management";
            begin
                IF Requester.GET("Requester No.") THEN BEGIN
                    Type := Requester.Type;
                    "Company No." := Requester."Company No.";
                    "Company Name" := Requester."Company Name";
                    Name := Requester.Name;
                    "Responsibility Center" := Requester."AMA Responsibility Center";
                    "Kitchen Code" := Requester."AMA Kitchen Code";
                    Building := Requester."AMA Building";
                    Floor := Requester."AMA Floor";
                    Room := Requester."AMA Room";
                    "Meal Subscriber Type" := Requester."AMA Subscriber Type";
                    // Class := Requester."AMA Invoice Type";
                    "Language Code" := Requester."Language Code";
                END;

                DeleteLines(Rec);

                CASE Type OF
                    Type::Person:
                        RequestMgmt.InsertLinesPerson(Rec);
                    Type::Company:
                        RequestMgmt.InsertLinesCompany(Rec);
                END;
            end;
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

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension Code 1");
            end;
        }
        field(13; "Shortcut Dimension Code 2"; Code[20])
        {
            Caption = 'Shortcut Dimension Code 2';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension Code 2");
            end;
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
            CalcFormula = Exist("Request Comment Line" WHERE(Type = const(Request), "No." = field("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(21; "Issuing No. Series"; Code[10])
        {
            Caption = 'Issuing No. Series';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                begin
                    KitCatSetup.Get();
                    KitCatSetup.TESTFIELD("Request Nos.");
                    KitCatSetup.TESTFIELD("Issued Request Nos.");
                    NoSeriesMgt.TestSeries(KitCatSetup."Issued Request Nos.", "Issuing No. Series");
                END;
                TESTFIELD("Issuing No.", '');
            end;

            trigger OnLookup()
            var
                RequestHeader: Record "Request Header";
            begin
                WITH RequestHeader DO BEGIN
                    RequestHeader := Rec;
                    KitCatSetup.GET;
                    KitCatSetup.TESTFIELD("Request Nos.");
                    KitCatSetup.TESTFIELD("Issued Request Nos.");
                    IF NoSeriesMgt.LookupSeries(KitCatSetup."Issued Request Nos.", "Issuing No. Series") THEN
                        VALIDATE("Issuing No. Series");
                    Rec := RequestHeader;
                END;
            end;
        }
        field(22; "Issuing No."; Code[20])
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
        key(KKey3; "Kitchen Code", Building, Floor, Room, "Request Date")
        {
        }
    }

    trigger OnInsert()
    begin
        KitCatSetup.GET;
        IF "No." = '' THEN BEGIN
            KitCatSetup.TESTFIELD("Request Nos.");
            KitCatSetup.TESTFIELD("Issued Request Nos.");
            NoSeriesMgt.InitSeries(
              KitCatSetup."Request Nos.", xRec."No. Series", "Request Date",
              "No.", "No. Series");
        END;

        "Posting Description" := STRSUBSTNO(Text000, "No.");

        IF ("No. Series" <> '') AND
           (KitCatSetup."Request Nos." = KitCatSetup."Issued Request Nos.")
        THEN
            "Issuing No. Series" := "No. Series"
        ELSE
            NoSeriesMgt.SetDefaultSeries("Issuing No. Series", KitCatSetup."Issued Request Nos.");

        IF "Request Date" = 0D THEN
            "Request Date" := WORKDATE;
        "Document Date" := WORKDATE;
        "Due Date" := WORKDATE;

        IF GETFILTER("Requester No.") <> '' THEN
            IF GETRANGEMIN("Requester No.") = GETRANGEMAX("Requester No.") THEN
                VALIDATE("Requester No.", GETRANGEMIN("Requester No."));
    end;

    trigger OnDelete()
    var
        RequestCommentLine: Record "Request Comment Line";
        IssuedRequestHeader: Record "AMA Issued Request Header";
    begin
        RequestLine.SETRANGE("Request No.", "No.");
        RequestLine.DELETEALL;

        RequestCommentLine.SETRANGE(Type, RequestCommentLine.Type::Request);
        RequestCommentLine.SETRANGE("No.", "No.");
        RequestCommentLine.DeleteAll(true);
    end;

    var
        KitCatSetup: Record "AMA KitCat Setup";
        Requester: Record Contact;
        RequestLine: Record "Request Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text000: Label 'Request %1';
        QstRecoverGroupReqLines: Label 'Do you want to recover the default group request lines?';

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        IF "No." <> '' THEN
            MODIFY;

        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
            MODIFY;
            IF RequestLinesExist() THEN
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        END;

    end;

    local procedure RequestLinesExist(): Boolean
    var
        RequestLine: Record "Request Line";
    begin
        RequestLine.SetRange("Request No.", "No.");
        exit(RequestLine.FindFirst());
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        NewDimSetID: Integer;
    begin
        // IF NewParentDimSetID = OldParentDimSetID THEN
        //     EXIT;
        // IF NOT HideValidationDialog OR NOT GUIALLOWED THEN
        //     IF NOT CONFIRM(Text064) THEN
        //         EXIT;

        // RequestLine.RESET;
        // RequestLine.SETRANGE("Document No.", "No.");
        // RequestLine.LOCKTABLE;
        // IF RequestLine.FIND('-') THEN
        //     REPEAT
        //         NewDimSetID := DimMgt.GetDeltaDimSetID(RequestLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
        //         IF RequestLine."Dimension Set ID" <> NewDimSetID THEN BEGIN
        //             RequestLine."Dimension Set ID" := NewDimSetID;
        //             DimMgt.UpdateGlobalDimFromDimSetID(
        //               RequestLine."Dimension Set ID", RequestLine."Shortcut Dimension 1 Code", RequestLine."Shortcut Dimension 2 Code");
        //             RequestLine.MODIFY;
        //         END;
        //     UNTIL RequestLine.NEXT = 0;
    end;

    local procedure DeleteLines(RequestHeader: Record "Request Header")
    begin
        RequestLine.Reset();
        RequestLine.SetRange("Request No.", RequestHeader."No.");
        RequestLine.DeleteAll();
    end;
}
