<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../../libs/asp/BD.asp"-->
<%
Response.Expires = 0
LServerName = Request.ServerVariables("SERVER_NAME")
valSpl = split(LServerName,".")
dominio = valSpl(0)

' dominio = request.querystring("dominio") 
comm = request.querystring("comm")

' if comm = "get" then

    sql = "select cc.id, cc.nombre, pr.domicilio, cc.nombre_circulo, CONVERT(varchar, cc.hora_entrada, 108), us.no_molestar, us.no_molestarCirculo "&_ 
    " from dueno_circulo_cercano cc  "&_
    " inner join propiedades pr on cc.id_usuario=pr.id_usuario "&_
    " inner join usuarios us on cc.id_usuario=us.id "&_
    " where cc.estado=1 "

  datos = executee(sql,dominio)
  info = ""
  if not IsEmpty(datos) then
    botonQR = "<button class=//btn btn-sm btn-outline btn-rounded b-info text-info btnQR//>Crear QR</button>"
    for l=0 to ubound(datos,2)
            noMolestar = datos(5,l) &"-"&datos(6,l)
            info =  info & "{'id':'"&datos(0,l)&"','nombre':'"&datos(1,l)&"','domicilio':'"&datos(2,l)&"','circulo':'"&datos(3,l)&"', 'entrada':'"&datos(4,l)&"', 'QR':'"&botonQR&"', 'no_molestar':'"&noMolestar&"'},"
    next
    info = left(info, len(info)-1)
    info = "{'data':["&info&"]}"
    info = Replace(info, "'", chr(34))
    info = replace(info,"//","'")
  end if
  
  info =  info
' end if


response.write(info)

%>