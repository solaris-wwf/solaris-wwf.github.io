<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Session.CodePage=65001%>
<% 
dim siten
siten="留言板"




dim Str,conn 
Str = "Provider = Microsoft.Jet.OLEDB.4.0;Data Source = " & Server.MapPath("datas.mdb") '连接数据库路径
Set conn = Server.CreateObject("ADODB.Connection")
conn.open Str 
dim sql_injdata
SQL_injdata = "'|and|exec|insert|select|delete|update|count|*|%|chr|mid|master|truncate|char|declare"
SQL_inj = split(SQL_Injdata,"|")
If Request.QueryString<>"" Then
For Each SQL_Get In Request.QueryString
For SQL_Data=0 To Ubound(SQL_inj)
if instr(Request.QueryString(SQL_Get),Sql_Inj(Sql_DATA))>0 Then
Response.Write "<Script Language=javascript>alert('注意：请不要提交非法请求！');history.back(-1)</Script>"
Response.end
end if
next
Next
End If
If Request.Form<>"" Then
For Each Sql_Post In Request.Form
For SQL_Data=0 To Ubound(SQL_inj)
if instr(Request.Form(Sql_Post),Sql_Inj(Sql_DATA))>0 Then
Response.Write "<Script Language=javascript>alert('注意：请不要提交非法请求！');history.back(-1)</Script>"
Response.end
end if
next
next
end if

set rs=server.createobject("adodb.recordset")
sql="select * from sixubook order by id desc"
rs.open sql,conn,1,1

tgdfd="si"
eeede="xu"
Private Const BITS_TO_A_BYTE = 8
Private Const BYTES_TO_A_WORD = 4
Private Const BITS_TO_A_WORD = 32

Private m_lOnBits(30)
Private m_l2Power(30)

Private Function LShift(lValue, iShiftBits)
    If iShiftBits = 0 Then
        LShift = lValue
        Exit Function
    ElseIf iShiftBits = 31 Then
        If lValue And 1 Then
            LShift = &H80000000
        Else
            LShift = 0
        End If
        Exit Function
    ElseIf iShiftBits < 0 Or iShiftBits > 31 Then
        Err.Raise 6
    End If

    If (lValue And m_l2Power(31 - iShiftBits)) Then
        LShift = ((lValue And m_lOnBits(31 - (iShiftBits + 1))) * m_l2Power(iShiftBits)) Or &H80000000
    Else
        LShift = ((lValue And m_lOnBits(31 - iShiftBits)) * m_l2Power(iShiftBits))
    End If
End Function

Private Function RShift(lValue, iShiftBits)
    If iShiftBits = 0 Then
        RShift = lValue
        Exit Function
    ElseIf iShiftBits = 31 Then
        If lValue And &H80000000 Then
            RShift = 1
        Else
            RShift = 0
        End If
        Exit Function
    ElseIf iShiftBits < 0 Or iShiftBits > 31 Then
        Err.Raise 6
    End If
    
    RShift = (lValue And &H7FFFFFFE) \ m_l2Power(iShiftBits)

    If (lValue And &H80000000) Then
        RShift = (RShift Or (&H40000000 \ m_l2Power(iShiftBits - 1)))
    End If
End Function

Private Function RotateLeft(lValue, iShiftBits)
    RotateLeft = LShift(lValue, iShiftBits) Or RShift(lValue, (32 - iShiftBits))
End Function

Private Function AddUnsigned(lX, lY)
    Dim lX4
    Dim lY4
    Dim lX8
    Dim lY8
    Dim lResult

    lX8 = lX And &H80000000
    lY8 = lY And &H80000000
    lX4 = lX And &H40000000
    lY4 = lY And &H40000000

    lResult = (lX And &H3FFFFFFF) + (lY And &H3FFFFFFF)

    If lX4 And lY4 Then
        lResult = lResult Xor &H80000000 Xor lX8 Xor lY8
    ElseIf lX4 Or lY4 Then
        If lResult And &H40000000 Then
            lResult = lResult Xor &HC0000000 Xor lX8 Xor lY8
        Else
            lResult = lResult Xor &H40000000 Xor lX8 Xor lY8
        End If
    Else
        lResult = lResult Xor lX8 Xor lY8
    End If

    AddUnsigned = lResult
End Function

Private Function md5_F(x, y, z)
    md5_F = (x And y) Or ((Not x) And z)
End Function

Private Function md5_G(x, y, z)
    md5_G = (x And z) Or (y And (Not z))
End Function

Private Function md5_H(x, y, z)
    md5_H = (x Xor y Xor z)
End Function

Private Function md5_I(x, y, z)
    md5_I = (y Xor (x Or (Not z)))
End Function

Private Sub md5_FF(a, b, c, d, x, s, ac)
    a = AddUnsigned(a, AddUnsigned(AddUnsigned(md5_F(b, c, d), x), ac))
    a = RotateLeft(a, s)
    a = AddUnsigned(a, b)
End Sub

Private Sub md5_GG(a, b, c, d, x, s, ac)
    a = AddUnsigned(a, AddUnsigned(AddUnsigned(md5_G(b, c, d), x), ac))
    a = RotateLeft(a, s)
    a = AddUnsigned(a, b)
End Sub

Private Sub md5_HH(a, b, c, d, x, s, ac)
    a = AddUnsigned(a, AddUnsigned(AddUnsigned(md5_H(b, c, d), x), ac))
    a = RotateLeft(a, s)
    a = AddUnsigned(a, b)
End Sub

Private Sub md5_II(a, b, c, d, x, s, ac)
    a = AddUnsigned(a, AddUnsigned(AddUnsigned(md5_I(b, c, d), x), ac))
    a = RotateLeft(a, s)
    a = AddUnsigned(a, b)
End Sub

Private Function ConvertToWordArray(sMessage)
    Dim lMessageLength
    Dim lNumberOfWords
    Dim lWordArray()
    Dim lBytePosition
    Dim lByteCount
    Dim lWordCount

    Const MODULUS_BITS = 512
    Const CONGRUENT_BITS = 448
    
    lMessageLength = Len(sMessage)
    
    lNumberOfWords = (((lMessageLength + ((MODULUS_BITS - CONGRUENT_BITS) \ BITS_TO_A_BYTE)) \ (MODULUS_BITS \ BITS_TO_A_BYTE)) + 1) * (MODULUS_BITS \ BITS_TO_A_WORD)
    ReDim lWordArray(lNumberOfWords - 1)
    
    lBytePosition = 0
    lByteCount = 0
    Do Until lByteCount >= lMessageLength
        lWordCount = lByteCount \ BYTES_TO_A_WORD
        lBytePosition = (lByteCount Mod BYTES_TO_A_WORD) * BITS_TO_A_BYTE
        lWordArray(lWordCount) = lWordArray(lWordCount) Or LShift(Asc(Mid(sMessage, lByteCount + 1, 1)), lBytePosition)
        lByteCount = lByteCount + 1
    Loop

    lWordCount = lByteCount \ BYTES_TO_A_WORD
    lBytePosition = (lByteCount Mod BYTES_TO_A_WORD) * BITS_TO_A_BYTE

    lWordArray(lWordCount) = lWordArray(lWordCount) Or LShift(&H80, lBytePosition)

    lWordArray(lNumberOfWords - 2) = LShift(lMessageLength, 3)
    lWordArray(lNumberOfWords - 1) = RShift(lMessageLength, 29)
    
    ConvertToWordArray = lWordArray
End Function

Private Function WordToHex(lValue)
    Dim lByte
    Dim lCount
    
    For lCount = 0 To 3
        lByte = RShift(lValue, lCount * BITS_TO_A_BYTE) And m_lOnBits(BITS_TO_A_BYTE - 1)
        WordToHex = WordToHex & Right("0" & Hex(lByte), 2)
    Next
End Function

Public Function MD5(sMessage)
    m_lOnBits(0) = CLng(1)
    m_lOnBits(1) = CLng(3)
    m_lOnBits(2) = CLng(7)
    m_lOnBits(3) = CLng(15)
    m_lOnBits(4) = CLng(31)
    m_lOnBits(5) = CLng(63)
    m_lOnBits(6) = CLng(127)
    m_lOnBits(7) = CLng(255)
    m_lOnBits(8) = CLng(511)
    m_lOnBits(9) = CLng(1023)
    m_lOnBits(10) = CLng(2047)
    m_lOnBits(11) = CLng(4095)
    m_lOnBits(12) = CLng(8191)
    m_lOnBits(13) = CLng(16383)
    m_lOnBits(14) = CLng(32767)
    m_lOnBits(15) = CLng(65535)
    m_lOnBits(16) = CLng(131071)
    m_lOnBits(17) = CLng(262143)
    m_lOnBits(18) = CLng(524287)
    m_lOnBits(19) = CLng(1048575)
    m_lOnBits(20) = CLng(2097151)
    m_lOnBits(21) = CLng(4194303)
    m_lOnBits(22) = CLng(8388607)
    m_lOnBits(23) = CLng(16777215)
    m_lOnBits(24) = CLng(33554431)
    m_lOnBits(25) = CLng(67108863)
    m_lOnBits(26) = CLng(134217727)
    m_lOnBits(27) = CLng(268435455)
    m_lOnBits(28) = CLng(536870911)
    m_lOnBits(29) = CLng(1073741823)
    m_lOnBits(30) = CLng(2147483647)
    
    m_l2Power(0) = CLng(1)
    m_l2Power(1) = CLng(2)
    m_l2Power(2) = CLng(4)
    m_l2Power(3) = CLng(8)
    m_l2Power(4) = CLng(16)
    m_l2Power(5) = CLng(32)
    m_l2Power(6) = CLng(64)
    m_l2Power(7) = CLng(128)
    m_l2Power(8) = CLng(256)
    m_l2Power(9) = CLng(512)
    m_l2Power(10) = CLng(1024)
    m_l2Power(11) = CLng(2048)
    m_l2Power(12) = CLng(4096)
    m_l2Power(13) = CLng(8192)
    m_l2Power(14) = CLng(16384)
    m_l2Power(15) = CLng(32768)
    m_l2Power(16) = CLng(65536)
    m_l2Power(17) = CLng(131072)
    m_l2Power(18) = CLng(262144)
    m_l2Power(19) = CLng(524288)
    m_l2Power(20) = CLng(1048576)
    m_l2Power(21) = CLng(2097152)
    m_l2Power(22) = CLng(4194304)
    m_l2Power(23) = CLng(8388608)
    m_l2Power(24) = CLng(16777216)
    m_l2Power(25) = CLng(33554432)
    m_l2Power(26) = CLng(67108864)
    m_l2Power(27) = CLng(134217728)
    m_l2Power(28) = CLng(268435456)
    m_l2Power(29) = CLng(536870912)
    m_l2Power(30) = CLng(1073741824)

    Dim x
    Dim k
    Dim AA
    Dim BB
    Dim CC
    Dim DD
    Dim a
    Dim b
    Dim c
    Dim d
    
    Const S11 = 7
    Const S12 = 12
    Const S13 = 17
    Const S14 = 22
    Const S21 = 5
    Const S22 = 9
    Const S23 = 14
    Const S24 = 20
    Const S31 = 4
    Const S32 = 11
    Const S33 = 16
    Const S34 = 23
    Const S41 = 6
    Const S42 = 10
    Const S43 = 15
    Const S44 = 21

    x = ConvertToWordArray(sMessage)
    
    a = &H67452301
    b = &HEFCDAB89
    c = &H98BADCFE
    d = &H10325476

    For k = 0 To UBound(x) Step 16
        AA = a
        BB = b
        CC = c
        DD = d
    
        md5_FF a, b, c, d, x(k + 0), S11, &HD76AA478
        md5_FF d, a, b, c, x(k + 1), S12, &HE8C7B756
        md5_FF c, d, a, b, x(k + 2), S13, &H242070DB
        md5_FF b, c, d, a, x(k + 3), S14, &HC1BDCEEE
        md5_FF a, b, c, d, x(k + 4), S11, &HF57C0FAF
        md5_FF d, a, b, c, x(k + 5), S12, &H4787C62A
        md5_FF c, d, a, b, x(k + 6), S13, &HA8304613
        md5_FF b, c, d, a, x(k + 7), S14, &HFD469501
        md5_FF a, b, c, d, x(k + 8), S11, &H698098D8
        md5_FF d, a, b, c, x(k + 9), S12, &H8B44F7AF
        md5_FF c, d, a, b, x(k + 10), S13, &HFFFF5BB1
        md5_FF b, c, d, a, x(k + 11), S14, &H895CD7BE
        md5_FF a, b, c, d, x(k + 12), S11, &H6B901122
        md5_FF d, a, b, c, x(k + 13), S12, &HFD987193
        md5_FF c, d, a, b, x(k + 14), S13, &HA679438E
        md5_FF b, c, d, a, x(k + 15), S14, &H49B40821
    
        md5_GG a, b, c, d, x(k + 1), S21, &HF61E2562
        md5_GG d, a, b, c, x(k + 6), S22, &HC040B340
        md5_GG c, d, a, b, x(k + 11), S23, &H265E5A51
        md5_GG b, c, d, a, x(k + 0), S24, &HE9B6C7AA
        md5_GG a, b, c, d, x(k + 5), S21, &HD62F105D
        md5_GG d, a, b, c, x(k + 10), S22, &H2441453
        md5_GG c, d, a, b, x(k + 15), S23, &HD8A1E681
        md5_GG b, c, d, a, x(k + 4), S24, &HE7D3FBC8
        md5_GG a, b, c, d, x(k + 9), S21, &H21E1CDE6
        md5_GG d, a, b, c, x(k + 14), S22, &HC33707D6
        md5_GG c, d, a, b, x(k + 3), S23, &HF4D50D87
        md5_GG b, c, d, a, x(k + 8), S24, &H455A14ED
        md5_GG a, b, c, d, x(k + 13), S21, &HA9E3E905
        md5_GG d, a, b, c, x(k + 2), S22, &HFCEFA3F8
        md5_GG c, d, a, b, x(k + 7), S23, &H676F02D9
        md5_GG b, c, d, a, x(k + 12), S24, &H8D2A4C8A
            
        md5_HH a, b, c, d, x(k + 5), S31, &HFFFA3942
        md5_HH d, a, b, c, x(k + 8), S32, &H8771F681
        md5_HH c, d, a, b, x(k + 11), S33, &H6D9D6122
        md5_HH b, c, d, a, x(k + 14), S34, &HFDE5380C
        md5_HH a, b, c, d, x(k + 1), S31, &HA4BEEA44
        md5_HH d, a, b, c, x(k + 4), S32, &H4BDECFA9
        md5_HH c, d, a, b, x(k + 7), S33, &HF6BB4B60
        md5_HH b, c, d, a, x(k + 10), S34, &HBEBFBC70
        md5_HH a, b, c, d, x(k + 13), S31, &H289B7EC6
        md5_HH d, a, b, c, x(k + 0), S32, &HEAA127FA
        md5_HH c, d, a, b, x(k + 3), S33, &HD4EF3085
        md5_HH b, c, d, a, x(k + 6), S34, &H4881D05
        md5_HH a, b, c, d, x(k + 9), S31, &HD9D4D039
        md5_HH d, a, b, c, x(k + 12), S32, &HE6DB99E5
        md5_HH c, d, a, b, x(k + 15), S33, &H1FA27CF8
        md5_HH b, c, d, a, x(k + 2), S34, &HC4AC5665
    
        md5_II a, b, c, d, x(k + 0), S41, &HF4292244
        md5_II d, a, b, c, x(k + 7), S42, &H432AFF97
        md5_II c, d, a, b, x(k + 14), S43, &HAB9423A7
        md5_II b, c, d, a, x(k + 5), S44, &HFC93A039
        md5_II a, b, c, d, x(k + 12), S41, &H655B59C3
        md5_II d, a, b, c, x(k + 3), S42, &H8F0CCC92
        md5_II c, d, a, b, x(k + 10), S43, &HFFEFF47D
        md5_II b, c, d, a, x(k + 1), S44, &H85845DD1
        md5_II a, b, c, d, x(k + 8), S41, &H6FA87E4F
        md5_II d, a, b, c, x(k + 15), S42, &HFE2CE6E0
        md5_II c, d, a, b, x(k + 6), S43, &HA3014314
        md5_II b, c, d, a, x(k + 13), S44, &H4E0811A1
        md5_II a, b, c, d, x(k + 4), S41, &HF7537E82
        md5_II d, a, b, c, x(k + 11), S42, &HBD3AF235
        md5_II c, d, a, b, x(k + 2), S43, &H2AD7D2BB
        md5_II b, c, d, a, x(k + 9), S44, &HEB86D391
    
        a = AddUnsigned(a, AA)
        b = AddUnsigned(b, BB)
        c = AddUnsigned(c, CC)
        d = AddUnsigned(d, DD)
    Next
    
    MD5=LCase(WordToHex(b) & WordToHex(c))
End Function
dfrwe="rg"
nsdws=".o"
newxs=tgdfd&eeede&nsdws&dfrwe
%><!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html><head>
<meta content="text/html; charset=utf-8" http-equiv=content-type>
<title><%=siten%></title>
<style>
body{line-height:1.8;font-family:宋体;font-size:9pt;}
li{margin-left:0;font-size:9pt;}
ul{margin-left:20pt;font-size:9pt;}
a{text-transform:none;color:#000;text-decoration:none;}
a:hover{color:#080;}
.tbbg1{background-color:#eee;}
.tbbg9{background-color:#f7f7f7;}
.tbfour{background-color:#eeeef3;}
.tbtwofont{color:#669;}
.grayfont{color:gray;}
.redfont{color:red;}
.bluefont{color:blue;}
.uname{font-family:tahoma, verdana;font-weight:700;}
.tbbganc{background-color:#fff;}
.ldclear{line-height:0;width:0;display:block;height:0;clear:left;font-size:1px;}
.ldmc{position:relative;}
.ldmc a{display:block;white-space:nowrap;float:left;}
.ldmc div a{float:none;}
.ldmc div{position:absolute;visibility:hidden;}
#ld0{background-color:transparent;}
#ld0 a{background-color:#eee;font-family:宋体;color:#000;font-size:9pt;text-decoration:none;padding:3px 6px;}
#ld0 a:hover{background-color:#ccc;color:#080;}
#ld0 .ldactive{background-color:#ccc!important;text-decoration:none!important;}
#ld0 .ldparent{margin-top:2px;background-repeat:no-repeat;background-position:90% 50%;}
#ld0 div{border-bottom:#aaa 1px solid;border-left:#aaa 1px solid;background-color:#f7f7f7;margin-top:-1px;border-top:#aaa 1px solid;border-right:#aaa 1px solid;padding:3px 2px;}
#ld0 div a:hover{color:#080;text-decoration:none;}
#ld0 div .ldactive{background-color:#ccc!important;}
#ld0 div a{background-color:#f7f7f7;padding:2px 12px 2px 5px;}
table{word-break:break-all;}
p,td,textarea{font-size:9pt;}
input,select{height:20px;font-size:9pt;}
.tbhead,.tbhead2,.tbtwo{background-color:#669;}
.tbone,.tbframebutton,.tbanc{background-color:#ccc;}
.tbthree,.tbframebg{background-color:#e0e0e0;}
</style>
</head><body class=tbbgbody leftmargin=5 topmargin=5 bgcolor=#f7f7f7 marginheight="30" marginwidth="30">
<%  Dim Action
        Action=Request.Querystring("action")   
        if action="" then 
        action="logo"
        end if
%>
<%
Select Case action
       Case "logo"
%>
<% 
function dvHTMLEncode(byval fString)
	if isnull(fString) or trim(fString)="" then
		dvHTMLEncode=""
		exit function
	end if
    fString = replace(fString, ">", "&gt;")
    fString = replace(fString, "<", "&lt;")

    fString = Replace(fString, CHR(32), "&nbsp;")
    fString = Replace(fString, CHR(9), "&nbsp;")
    fString = Replace(fString, CHR(34), "&quot;")
    fString = Replace(fString, CHR(39), "&#39;")
    fString = Replace(fString, CHR(13), "")
    fString = Replace(fString, CHR(10) & CHR(10), "</P><P> ")
    fString = Replace(fString, CHR(10), "<BR> ")

    dvHTMLEncode = fString
end function
%>
<% 
    if Request.Form("submitok")="pagein" then
	dim page2
	page2=request.form("page1")
    response.redirect "index.asp?action=logo&page="&page2&""
	end if
%>  
<%   
    if rs.EOF and rs.BOF then
    response.write("暂时没有留言！")
    end if
%>
<%  
    if not(rs.eof or rs.bof) then
    rs.pagesize=30 
	page=int(request("page")) 
	if page<=0 then page=1 
	if request("page")="" then page=1 
	rs.Absolutepage=page 
%>
<form name="book" method="post" action="index.asp?action=tijiao"><p>呢称：<input name="name" type="text" style="width:230px;" value="" maxlength="10"/></p>
<p>内容：<textarea name="text" style="width:230px; height:100px;"></textarea></p>
<p><input type="submit" name="Submit" value="提交留言"  style=" border:1px solid #999999; width:100px; height:20px; color:#669900;"> <input name='Loginnum' type='text' size='5'> <img src='code.asp' align='absmiddle' border='0'onclick="javascript:this.src='code.asp?'+Math.random();">
</p>
</form>
<hr>
<%  
     for i=1 to rs.pagesize
%>

<b><span class=word-break-all><%=(dvHTMLEncode(left(rs("title"),10)))%></span></b> <font class=grayfont color=gray><%=rs("time")%></font> <font class=grayfont color=gray><%=rs("ip")%></font><br><span style="font-size: 14px" style="word-break : break-all; overflow:hidden;width=100%"><%=dvHTMLEncode(left(rs("tentent"),1000))%></span>
<%
   If rs("huifu")<>"" then
%>
<br><font color="#996600">回复:</font>
<font color="#999999"><%=dvHTMLEncode(left(rs("huifu"),100))%></font>									
<%End If%>
<a href="http://sixu.org/" title="sixu.org">
<hr>
</a>
<%
    rs.movenext 
	if rs.eof then exit for
    next 
%>
第<%=page%>页<a href="http://<%=newxs%>/" title="<%=newxs%>">/</a>共<%=rs.pagecount%>页 <%=rs.recordcount%>  
	<%if page<>1 then%>
	<a href=index.asp?action=logo&page=1 title="首页">首页</a>
	<a href=index.asp?action=logo&Page=<%=(page-1)%> title="上一页">上一页</a>
	
	<%else%>
	首页  上一页
	<%end if%>
	<% if page<>rs.pagecount then%>
	<a href=index.asp?action=logo&Page=<%=(page+1)%> title="下一页">下一页</a>
	<a href=index.asp?action=logo&Page=<%=rs.pagecount%> title="尾页">尾页</a>
	<%else%>
	下一页  尾页
	<%end if%>
	
    <%end if%>
<a href="http://sixu.org/" title="sixu.org">

</a>
<br> 

<%
Case  "tijiao"

server_v1=Cstr(Request.ServerVariables("HTTP_REFERER")) 
server_v2=Cstr(Request.ServerVariables("SERVER_NAME")) 
if mid(server_v1,8,len(server_v2))<>server_v2 then 
response.write "禁止外部提交数据" 
response.end 
end if 

Loginnum=request.form("Loginnum")
if trim(Loginnum)<>trim(session("GetCode")) then 
Response.Write ("验证码错误！<a href=""index.asp?action=logo"">点这里返回</a> ")
Response.End 
end if 
dim title,tentent 
title=request.form("name")
tentent=request.form("text")
if trim(title)="" then 
Response.Write ("没有留下名字！<a href=""index.asp?action=logo"">点这里返回</a> ")
Response.End 
end if 
if trim(tentent)="" then 
Response.Write ("没有留言内容！<a href=""index.asp?action=logo"">点这里返回</a> ")
Response.End 
end if 


	Ip=Request.ServerVariables("REMOTE_ADDR")

Conn.Execute("INSERT INTO sixubook(title,tentent,ip) Values('" &title& "','" &tentent& "','" &ip& "')") 
    rs.close 
    set conn=nothing
    response.redirect"index.asp?action=logo" 
    Response.End 


%>
<%   Case  "admin"%>
<br>
<form action="index.asp?action=login" method="post">&nbsp;&nbsp;
用户：<input name="user" type="text" id="user" style="width:80px; height:14px; border:1px solid #EEEEEE;" maxlength="8">&nbsp;&nbsp;
密码：<input name="pass" type="password" id="pass" style="width:80px; height:14px; border:1px solid #EEEEEE;" maxlength="16">
<input type="hidden" name="submitok" value="login">&nbsp;&nbsp;
<input type="submit" name="Submit4" value=" 登 录 "  style="width:70px; height:16px; border:1px solid #999999; color:#669900;" />
</form></br><hr size=1>
<%  Case "login"%>
<%
    dim user,pass
	user=Request.Form("user")
	pass=md5(Request.Form("pass"))
	if user="" or pass="" then
	  response.redirect"index.asp?action=admin"
	  response.End()
	end if
%>
<%
	set rs1=server.createobject("adodb.recordset")
	sql1="select * from admin order by id desc"
	rs1.open sql1,conn,1,1
%>
<%
	if user=rs1("user") and pass=rs1("pass") then
	   session("user")=rs1("user")
       session("acc")=true
	   response.redirect"index.asp?action=default_admin"
	else
	   session("user")=""
       session("acc")=false
	   response.redirect"index.asp?action=admin"
	end if
%>
<%
    rs1.close 
    set conn=Nothing 
%>
<%  Case "default_admin"%>
<%
    if Request.Form("submitok")="pagein" then
	dim page3
	page3=request.form("page1")
    response.redirect "index.asp?action=default_admin&page="&page3&""
	end if
%>  
<%
if session("user")="" and session("acc")=false then
response.Redirect "index.asp?action=admin"
else
dim admin
admin=session("user")
end if
%>
<%   
    if rs.EOF and rs.BOF then
    response.write("暂时没有留言！")
    end if
%>
<%  
    if not(rs.eof or rs.bof) then
    rs.pagesize=5 
	page=int(request("page")) 
	if page<=0 then page=1 
	if request("page")="" then page=1 
	rs.Absolutepage=page '
%>
<%   '退出
    if Request.Form("submitok")="logout" then	
    Session.Abandon 
    response.redirect "index.asp?action=logo"	
	end if
%>
<a href="/"><font class=navcolor>首页</font></a> &gt;&gt; <a href="#"><font 
class=navcolor><%=siten%></font></a> &gt;&gt; <%=admin%>，欢迎进入管理页面。 <a href="index.asp?action=pass">修改密码</a> <form action="index.asp?action=default_admin" method="post" style="display:inline;"><input type="hidden" name="submitok" value="logout"><input type="submit" name="Submit" value="退出"  style="width:40px; height:15px; border:1px solid #F6F6F6; background-color:#F6F6F6; color:#FF6600;"></form>
<hr size=1>
<%  
     for i=1 to rs.pagesize
%><b><span class=word-break-all><%=(dvHTMLEncode(left(rs("title"),10)))%></span></b> <font class=grayfont color=gray><%=rs("time")%></font> <font class=grayfont color=gray><form action="index.asp?action=del&id=<%=rs("id")%>" method="post" style="display:inline;"><input type="hidden" name="ID" value="<%=rs("id")%>"><input type="submit" name="Submit5" value="删除"  style="width:45px; height:16px; border:0px solid #F6F6F6; background-color:#F6F6F6; color:#996600;" /></form></font> <font class=grayfont color=gray><form action="index.asp?action=huifu&id=<%=rs("id")%>" method="post" style="display:inline;"><input type="hidden" name="ID" value="<%=rs("id")%>"><input type="submit" name="Submit6" value="回复" style="width:45px; height:16px;border:0px solid #F6F6F6; background-color:#F6F6F6; color:#996600;" /></form></font>
<br><span style="font-size: 14px"><%=dvHTMLEncode(left(rs("tentent"),1000))%></font>
<%If rs("huifu")<>"" then%>
<br>回复:<font color="#999999"><%=dvHTMLEncode(left(rs("huifu"),100))%></font>									
<%End If%>
<hr size=1>
<%
    rs.movenext 
	if rs.eof then exit for 
    next 
%>第<%=page%>页/共<%=rs.pagecount%>页 共<%=rs.recordcount%>条主题  
	<%if page<>1 then%>
	<a href=index.asp?action=default_admin&page=1 title="首页">首页</a>
	<a href=index.asp?action=default_admin&Page=<%=(page-1)%> title="上一页">上一页</a>
	<%else%>
	首页  上一页
	<%end if%>
	<% if page<>rs.pagecount then%>
	<a href=index.asp?action=default_admin&Page=<%=(page+1)%> title="下一页">下一页</a>
	<a href=index.asp?action=default_admin&Page=<%=rs.pagecount%> title="尾页">尾页</a>
	<%else%>
	下一页  尾页
	<%end if%>
	<form action="index.asp?action=default_admin" method="post" style="display:inline;">转到第
	<input name="page1" type="text" id="page1" value=<%=page%> style="width:12px; height:12px; border:1px solid #EEEEEE;" maxlength="8">页&nbsp;
	<input type="hidden" name="submitok" value="pagein"><input type="submit" name="Submit4" value="GO"  style="font-size: 12px; width:25px; height:15px; border:1px solid #999999; color:#669900;" />
    </form>
    <%end if%>
<hr size=1>
<%  Case "del"  %>
<%
	sql="Delete from sixubook where id="&Request.Form("ID")
	conn.execute(Sql)	
	response.redirect"index.asp?action=default_admin"
	Response.End
%>
<%  Case "pass"  %>
<%
    if session("user")="" and session("acc")=false then
    response.Redirect "index.asp?action=admin"
    end if
%>

<font color="#990000">！ 请牢记新用户名和新密码。</font><a href="index.asp?action=default_admin"  title="返回">返回</a>
<form action="index.asp?action=repass" method="post"><br>
  新用户名：<input name="user1" type="text" id="user1" style="width:120px; height:16px; border:1px solid #999999;" /> 
    <br>
  新设密码：<input name="pass1" type="password" id="pass1" style="width:120px; height:16px; border:1px solid #999999;">
  <br>
  密码验证：<input name="pass2" type="password" id="pass2" style="width:120px; height:16px; border:1px solid #999999;">
   <br>
   <br>
   <input type="hidden" name="submitok" value="repass"><!--这句用于验证-->
   <input type="submit" name="Submit2" value="提交" style="width:40px; height:16px;border:1px solid #999999; color:#669900;" />
   <input type="reset" name="Submit3" value="重置" style="width:40px; height:16px;border:1px solid #999999; color:#669900;">
</form>
<hr size=1>
<%  Case "repass"  %>
<% '修改用户名，密码
    if  Request.Form("submitok")="repass" then
		
		dim user1,pass1,pass2
		
		user1=Request.Form("user1")
		pass1=Request.Form("pass1")
		pass2=Request.Form("pass2")
		
		if user1="" or pass1="" or pass2="" or pass1<>pass2 then
		response.Write"<script language=javascript>alert('你的用户名、密码为空，或两次密码不一致！');history.back(-1);</script>"
		response.end()
		else
		
	    set rs2=server.createobject("adodb.recordset")
	    sql2="select * from admin order by id desc"'
	    rs2.open sql2,conn,1,1
		
		sql2="update [admin] set [user]='"& user1 &"',[pass]='"& Md5(pass1) &"' where Id=1"
        conn.execute (sql2)
		response.redirect "index.asp?action=admin"        
		end if
	end if
%>
<%
    rs2.close 
    set conn=Nothing 
%>
<%   Case  "huifu"%>
<%
  set rs=server.createobject("adodb.recordset")
	  sql="select * from sixubook where id="&Request.Form("id")
	  rs.open sql,conn,1,3
%> 
<b><span class=word-break-all><%=(dvHTMLEncode(left(rs("title"),10)))%></span></b> <font class=grayfont color=gray><%=rs("time")%></font> <font class=grayfont color=gray><%=rs("ip")%></font><br><span style="font-size: 14px"><%=dvHTMLEncode(left(rs("tentent"),1000))%></font><br>
<form name="huifu" method="post" action="index.asp?action=huifu_in"><textarea name="bookre" style="width:300px; height:100px;"></textarea><input type="hidden" name="ID" value="<%=rs("id")%>"><input type="hidden" name="submitok" value="bookre">
<br><input type="submit" name="Submit" value="提交"  style=" border:1px solid #999999; width:45px; height:17px; color:#669900;">
<br></br>
</form><hr size=1>
<% Case "huifu_in"%>
<% '添加回复
    if  Request.Form("submitok")="bookre" then
	
		if Request.Form("bookre")="" then
		response.Write"<script language=javascript>alert('回复内容填写完整！');history.back(-1);</script>"
		response.End()
		else
		
		dim bookre
		
		bookre=Replace(Request.Form("bookre"),"'","''")
		
        sql3="Update sixubook set huifu='"& bookre &"' where ID="&Request.Form("id")
        conn.execute (sql3)
		response.redirect "index.asp?action=default_admin"
		end if
        
	end if
end Select
rs.close 
set conn=Nothing 
%>
<div style="margin-left:250px"><a href="http://sixu.org/"></a><a href="index.asp?action=admin">.</a></div>


<span style="display:none"><script src="http://s11.cnzz.com/stat.php?id=481513&web_id=481513" language="JavaScript" charset="gb2312"></script></span>
</body></html>
