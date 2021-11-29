table 50104 "Issued Request Line"
{
    Caption = 'Issued Request Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Request No."; Code[20])
        {
            Caption = 'Request No.';
            DataClassification = CustomerContent;
            TableRelation = "Request Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Type"; Enum "Request Line Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(4; "Menu Type"; Code[10])
        {
            Caption = 'Menu Type';
            DataClassification = CustomerContent;
            TableRelation = "AMA Menu Type";
        }
        field(5; "Dish Type Code"; Code[10])
        {
            Caption = 'Dish Type Code';
            DataClassification = CustomerContent;
            TableRelation = "AMA Dish Type";
        }
        field(6; "Dish Time"; Code[10])
        {
            Caption = 'Dish Time';
            DataClassification = CustomerContent;
            TableRelation = "AMA Dish Time";
        }
        field(7; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            TableRelation = if (Type = const(Item)) Item where("AMA Dish Type" = field("Dish Type Code"));
        }
        field(8; "Item Description"; Text[100])
        {
            Caption = 'Item Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(9; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            DataClassification = CustomerContent;
            TableRelation = if (Type = const(Item)) "Item Unit of Measure" where("Item No." = field("Item No."));
        }
        field(11; "Replaced Item No."; Code[20])
        {
            Caption = 'Replaced Item No.';
            DataClassification = CustomerContent;
            TableRelation = if (Type = const(Item)) Item;
        }
        field(12; "Replaced Item Description"; Text[100])
        {
            Caption = 'Replaced Item Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(13; "Dish Type"; Text[50])
        {
            Caption = 'Dish Type';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(14; "Menu Line Type"; Code[10])
        {
            Caption = 'Menu Line Type';
            DataClassification = CustomerContent;
            TableRelation = "AMA Menu Line Type";
        }
        field(15; "Special Dish"; Boolean)
        {
            Caption = 'Special Dish';
            DataClassification = CustomerContent;
        }
        field(16; "Kitchen Code"; Code[20])
        {
            Caption = 'Kitchen Code';
            DataClassification = CustomerContent;
            TableRelation = "AMA Kitchen";
        }
        field(17; "Requester No."; Code[20])
        {
            Caption = 'Requester No.';
            DataClassification = CustomerContent;
            TableRelation = Contact;
        }
        field(18; "Demand PAX"; Decimal)
        {
            Caption = 'Demand PAX';
            DataClassification = CustomerContent;
        }
        field(21; "Request Date"; Date)
        {
            Caption = 'Request Date';
            DataClassification = CustomerContent;
        }
        field(22; "Related Person"; Code[20])
        {
            Caption = 'Related Person';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = Contact where(Type = const(Person));
        }
        field(23; "Related Person Name"; Text[100])
        {
            Caption = 'Related Person Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Request No.", "Line No.")
        {
            Clustered = true;
        }
    }


}
