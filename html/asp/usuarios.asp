<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>

<%
response.Expires = 0
dim conexion
set conexion = Server.CreateObject("ADODB.Connection")
conexion.ConnectionString ="Provider=SQLOLEDB;" & _
                           "Server=.\SQLEXPRESS;" & _
                           "Database=Datos;" & _
                           "User ID=sa;" & _
                           "Password=Sql12345;" & _
                           "Trusted_Connection=false;"
conexion.Open
dim registros
set registros = Server.CreateObject("ADODB.RecordSet")
registros.Open "Select idUsuario, nombreUsuario, apUsuario, amUsuario, emailUsuario from Usuarios",conexion

if not registros.eof then
botonQR = "<button class=//btn btn-sm btn-outline btn-rounded b-info text-info btnQR//>Crear QR</button>"

	micadena = "{'data':["
		'do while not registros.eof
		''	micadena =  micadena & "{" & "'Nombre':" & "'" &registros("Nombre") & "'" & ",'ApellidoP':" & "'" & registros("ApellidoP") & "'" &",'ApellidoM':" & "'" & registros("ApellidoM") & "'" &"}"
    	'registros.movenext
    	'micadena = micadena & ","
    	'loop
		'micadena = micadena & "]" & "}"

do
micadena =  micadena & "{" & "'id':" & "'" &registros("idUsuario") & "'" & ",'Nombre':" & "'" &registros("nombreUsuario") & "'" & ",'AP':" & "'" & registros("apUsuario") & "'" &",'AM':" & "'" & registros("amUsuario") & "'" &",'Email':" & "'" & registros("emailUsuario") & "'" &", 'CrearQR':" & "'" & botonQR & "'"  &"}"
registros.movenext

if registros.eof then
	else
	micadena = micadena & ","

end if

loop while not registros.eof
micadena = micadena & "]" & "}"

	respuesta = Replace(micadena, "'", chr(34))
  respuesta = replace(respuesta,"//","'")
	response.write(respuesta)

end if
conexion.close

'if not registros.eof then
''		numReg = registros.getrows
''
''	for i = 0 to numReg
''	micadena = micadena & "{"nombre":'"&registros(i,i+1)&"',"ApellidoP":'"&registros(i,i+1)&"',"ApellidoM":'"&registros(i,i+1)"'}"
''	next
''	response.write(micadena	)
'end if

'do while not registros.eof
	 
 '' response.write("Nombre:" & registros("Nombre"))
  'response.write("<br>")
  'response.write("ApellidoP:" & registros("ApellidoP"))
  'response.write("<br>")
  'response.write("ApellidoM:" & registros("ApellidoM"))
  'response.write("<br>")
  'response.write("------------------------------------------------------------")
  'response.write("<br>")
  'registros.movenext
'loop


'if not IsEmpty(registros) then 
 ''      response.Write("Si hay datos")     
 '' else
  ''     response.Write("no hay datos")
'end if

  


%>