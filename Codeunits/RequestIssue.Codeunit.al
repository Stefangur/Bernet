codeunit 50100 "Request Issue"
{
    trigger OnRun()
    var
        IssuedRequestHeader: Record "Issued Request Header";
        RequestCommentLine: Record "Request Comment Line";
        RequestCommentLine2: Record "Request Comment Line";
        RequestLine: Record "Request Line";
        IssuedRequestLine: Record "Issued Request Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    begin
        if (RequestHeader."Request Date" <> 0D) and (ReplaceRequestDate or (RequestHeader."Request Date" = 0D)) then
            RequestHeader.Validate("Request Date", RequestDate);

        RequestHeader.TestField("Requester No.");
        RequestHeader.TestField("Request Date");
        RequestHeader.TestField("Document Date");

        if (RequestHeader."Issuing No." = '') and (RequestHeader."No. Series" <> RequestHeader."Issuing No. Series") then begin
            RequestHeader.TestField("Issuing No. Series");
            RequestHeader."Issuing No." := NoSeriesMgt.GetNextNo(RequestHeader."Issuing No. Series", RequestHeader."Request Date", true);
            RequestHeader.Modify();
            Commit();
        end;

        if RequestHeader."Issuing No." <> '' then
            DocNo := RequestHeader."Issuing No."
        else
            DocNo := RequestHeader."No.";

        IssuedRequestHeader.TransferFields(RequestHeader);
        IssuedRequestHeader."No." := DocNo;
        IssuedRequestHeader."Pre-Assigned Issuing No." := RequestHeader."No.";
        IssuedRequestHeader."User ID" := USERID;
        IssuedRequestHeader.Insert(true);

        RequestCommentLine.SETRANGE("No.", RequestHeader."No.");
        IF RequestCommentLine.FIND('-') THEN
            REPEAT
                RequestCommentLine2.TransferFields(RequestCommentLine);
                RequestCommentLine2.Type := RequestCommentLine2.Type::"Issued Request";
                RequestCommentLine2."No." := IssuedRequestHeader."No.";
                RequestCommentLine2.Insert(true);
            UNTIL RequestCommentLine.Next() = 0;

        RequestLine.SETRANGE("Request No.", RequestHeader."No.");
        IF RequestLine.FIND('-') THEN
            REPEAT
                IssuedRequestLine.TransferFields(RequestLine);
                IssuedRequestLine."Request No." := IssuedRequestHeader."No.";
                IssuedRequestLine.Insert(true);
            UNTIL RequestLine.Next() = 0;

        RequestHeader.Delete(true);
    end;

    procedure Set(var NewRequestHeader: Record "Request Header"; NewReplaceRequestDate: Boolean; NewRequestDate: Date)
    var

    begin
        RequestHeader := NewRequestHeader;
        ReplaceRequestDate := NewReplaceRequestDate;
        RequestDate := NewRequestDate;
    end;

    // procedure GetIssuedRequest(var NewIssuedRequestHeader: Record "Issued Request Header")
    // begin
    //     NewIssuedRequestHeader := 

    // end;

    var
        RequestHeader: Record "Request Header";
        DocNo: Code[20];
        RequestDate: Date;
        ReplaceRequestDate: Boolean;
}
