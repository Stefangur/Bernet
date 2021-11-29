table 50100 "Reg. Meal Subscr. Plan Lin"
{
    Caption = 'Reg. Meal Subscr. Plan Lin';
    // DrillDownPageID = "AMA Meal Subscriber Plan Line";
    // LookupPageID = "AMA Meal Subscriber Plan Line";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Subscriber Plan Code"; Code[20])
        {
            Caption = 'Plan Code';
            DataClassification = CustomerContent;
            TableRelation = "AMA Meal Subscriber Plan Code";
        }
        field(4; Type; enum "Contact Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(5; "Subscriber No."; Code[20])
        {
            Caption = 'Subscriber No.';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = Contact."No." where("AMA Meal Subscriber" = const(true));
        }
        field(6; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "Upper Subscriber No."; Code[20])
        {
            Caption = 'Upper Subscriber No.';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = Contact."No." where(Type = const(Company),
                                          "AMA Meal Subscriber" = const(true));
        }
        field(10; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; Quantity; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantity';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
            FieldClass = Normal;
        }
        field(12; "Menu Type"; Code[10])
        {
            Caption = 'Menu Line';
            DataClassification = CustomerContent;
            TableRelation = "AMA Menu Type";
        }
        field(13; "Dish Type"; Code[10])
        {
            Caption = 'Dish Type';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "AMA Dish Type";
        }
        field(14; "Kitchen Code"; Code[20])
        {
            Caption = 'Kitchen Code';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "AMA Kitchen";
        }
        field(15; "Menu Line Type"; Code[10])
        {
            Caption = 'Menu Dish Type';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "AMA Menu Line Type".Code where("Menu Line Type Group" = field("Menu Line Type Group"));
        }
        field(16; "Menu Line Type Group"; Code[10])
        {
            Caption = 'Menu Line Type Group';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "AMA Menu Line Type Group";
        }
        field(17; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(18; "Item Description"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Caption = 'Item Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Qty. to Ship"; Decimal)
        {
            BlankZero = true;
            Caption = 'Qty. to Ship';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(20; "Quantity Shipped"; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantity Shipped';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(21; "Serving Size Group"; Code[10])
        {
            Caption = 'Serving Size Group';
            DataClassification = CustomerContent;
            TableRelation = "AMA Serving Size Group";
        }
        field(23; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
        }
        field(24; "Sort Printout"; Code[10])
        {
            CalcFormula = lookup("AMA Menu Line Type"."Sort Printout" where(Code = field("Menu Line Type")));
            Caption = 'Sort Printout';
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; "Per Day Billing Code"; Code[10])
        {
            Caption = 'Per Day Billing Code';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "AMA Billing per Billing Item";
        }
        field(30; Indentation; Integer)
        {
            Caption = 'Indentation';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(40; Address; Text[100])
        {
            CalcFormula = lookup(Contact.Address where("No." = field("Subscriber No.")));
            Caption = 'Address';
            Editable = false;
            FieldClass = FlowField;
        }
        field(41; "Address 2"; Text[50])
        {
            CalcFormula = lookup(Contact."Address 2" where("No." = field("Subscriber No.")));
            Caption = 'Address 2';
            Editable = false;
            FieldClass = FlowField;
        }
        field(42; "Post Code"; Code[20])
        {
            CalcFormula = lookup(Contact."Post Code" where("No." = field("Subscriber No.")));
            Caption = 'Post Code';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = if ("Country/Region Code" = const('')) "Post Code"
            else
            if ("Country/Region Code" = filter(<> '')) "Post Code" where("Country/Region Code" = field("Country/Region Code"));
        }
        field(43; City; Text[30])
        {
            CalcFormula = lookup(Contact.City where("No." = field("Subscriber No.")));
            Caption = 'City';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = if ("Country/Region Code" = const('')) "Post Code".City
            else
            if ("Country/Region Code" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("Country/Region Code"));
        }
        field(44; County; Text[30])
        {
            CalcFormula = lookup(Contact.County where("No." = field("Subscriber No.")));
            Caption = 'County';
            Editable = false;
            FieldClass = FlowField;
        }
        field(45; "Country/Region Code"; Code[10])
        {
            CalcFormula = lookup(Contact."Country/Region Code" where("No." = field("Subscriber No.")));
            Caption = 'Country/Region Code';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Country/Region";
        }
        field(46; "Territory Code"; Code[10])
        {
            CalcFormula = lookup(Contact."Territory Code" where("No." = field("Subscriber No.")));
            Caption = 'Territory Code';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Territory;
        }
        field(47; "Phone No."; Text[30])
        {
            CalcFormula = lookup(Contact."Phone No." where("No." = field("Subscriber No.")));
            Caption = 'Phone No.';
            Editable = false;
            ExtendedDatatype = PhoneNo;
            FieldClass = FlowField;
        }
        field(48; "E-Mail"; Text[80])
        {
            CalcFormula = lookup(Contact."E-Mail" where("No." = field("Subscriber No.")));
            Caption = 'Email';
            Editable = false;
            ExtendedDatatype = EMail;
            FieldClass = FlowField;
        }
        field(49; "Tour Code"; Code[10])
        {
            Caption = 'Tour';
            DataClassification = CustomerContent;
            TableRelation = "AMA Tour";
        }
        field(50; "Tour Sequence"; Integer)
        {
            BlankZero = true;
            Caption = 'Tour Sequence';
            DataClassification = CustomerContent;
        }
        field(60; "Calc. Unit Cost (actual)"; Decimal)
        {
            Caption = 'Calc. Unit Cost (actual)';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(61; "Calc. Unit Cost Amt. (actual)"; Decimal)
        {
            Caption = 'Calc. Unit Amount (actual)';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(62; "Unit Price excl. VAT"; Decimal)
        {
            Caption = 'Unit Price excl. VAT';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(63; "Unit Amount excl. VAT"; Decimal)
        {
            Caption = 'Unit Amount excl. VAT';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(64; Margin; Decimal)
        {
            BlankZero = true;
            Caption = 'Margin';
            DataClassification = CustomerContent;
        }
        field(65; "Unit Price incl. VAT"; Decimal)
        {
            Caption = 'Unit Price incl. VAT';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(66; "Unit Amount incl. VAT"; Decimal)
        {
            Caption = 'Unit Amount incl. VAT';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Subscriber Plan Code", "Subscriber No.", "Menu Type", "Menu Line Type", Date)
        {
            Clustered = true;
        }
        key(Key3; "Kitchen Code", "Upper Subscriber No.", "Subscriber No.", Date)
        {
        }
        key(Key6; "Item No.", "Upper Subscriber No.", Date)
        {
            MaintainSiftIndex = true;
            SumIndexFields = Quantity, "Unit Amount excl. VAT", "Calc. Unit Cost Amt. (actual)";
        }
        key(Key8; "Subscriber No.", Date)
        {
        }
    }

    fieldgroups
    {
    }
}