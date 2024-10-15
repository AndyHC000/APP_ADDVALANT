<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>

<%
response.Expires = 0

' dim conexion
' set conexion = Server.CreateObject("ADODB.Connection")
' conexion.ConnectionString ="Provider=SQLOLEDB;" & _
'                            "Server=.\SQLEXPRESS;" & _
'                            "Database=Datos;" & _
'                            "User ID=sa;" & _
'                            "Password=Sql12345;" & _
'                            "Trusted_Connection=false;"
' conexion.Open

IDuser = request.form("idUser")
QR = request.form("qrcode")
comm = request.form("comm")

if comm = "save" then
	if IDuser =""then
		response.write("no hay ID")
	else
		'conexion.execute ("update Usuarios set QR='" & QR & "' where idUsuario="&IDuser&" ")
		ActualizarDatos "Usuarios", "QR='" & QR & "'", "idUsuario="&IDuser&"", "n"
		response.write("datos guardados")
	end if		
end if

if comm = "paselista" then
	'buscar QR en CC
	'dim registros
	'set registros = Server.CreateObject("ADODB.RecordSet")
	 'registros.Open "Select idUsuario from Usuarios where QR ='"&QR&"'",conexion 
	'iduser = registros("idUsuario")'datos(0,l)
sql = "Select idUsuario from Usuarios where QR ='"&QR&"'"
	datos = executee (sql,"n")
	'buscamos en entradas y salidas si existe el pase de lista con fecha de hoy
	if not isempty(datos) then

		l = 0
		idUsuario = datos(0,l)
		if idUsuario<>""then
			sql="Select idUsuario from EntradaSalida where idUsuario ='"&idUsuario&"' and cast(HoraEntrada as date) = cast(getdate() as date)"
			datos = executee(sql,"n")
			if not isempty(datos) then '1=entrada, 2=salida
				ActualizarDatos "EntradaSalida", "HoraSalida=convert(varchar,getdate(),121)", "idUsuario='"&idUsuario&"' and cast(HoraEntrada as date) = cast(getdate() as date)", "n"
				info = "ok"
				else 'guardamos la entrada por primera vez'
				guardarDatos "EntradaSalida", "idUsuario,Tipo,HoraEntrada", "'"&idUsuario&"',1,convert(varchar,getdate(),121)", "n"
				info = "ok"
			end if
			
		end if
	else
	info = "noOk"
	end if 
end if


response.write(info)



public function executee(query, cn)
	set rsPregunta = server.CreateObject("ADODB.Recordset")
	rsPregunta.open query, conectate(cn)
	
	if not rsPregunta.eof then
		todosDatos = rsPregunta.getrows 
	end if
	'numrows = ubound(todosDatos,2)
	rsPregunta.Close()
	Set rsPregunta = Nothing
	executee = todosDatos
end function

public function guardarDatos(table,campos,datos, cnE)
	set cn = Server.CreateObject("ADODB.Connection")
	cn.Open conectate(cnE)
	cn.execute "insert into "&table&" ("&campos&") values ("&datos&") "
	cn.Close()
	Set cn = Nothing
end function

public function ActualizarDatos(base,actua,cuando, cnE)
	set cn = Server.CreateObject("ADODB.Connection")
	cn.Open conectate(cnE)
	cn.execute "update "&base&" set "&actua&"  where "&cuando
	cn.Close()
	Set cn = Nothing
	ActualizarDatos = "exito"
end function

function conectate(cual)
	select case cual
		case "core":
			conectate = session("cn")
		case "master"
			conectate = session("cnMaster")
		case else:
			conectate = "Provider=SQLOLEDB;" & _
                           "Server=.\SQLEXPRESS;" & _
                           "Database=Datos;" & _
                           "User ID=sa;" & _
                           "Password=Sql12345;" & _
                           "Trusted_Connection=false;"
	end select
end function
%>