$(document).ready(function(){


// $("#btnGuardarEntrada").click(function(){
// 	guardar()
// })

$("#id_form").on("submit", function(){
	guardar()
	return false;

})


function guardar(){

		infoR = {cboTipoIngreso:tipoIngreso,txtNombre:$("#txtNombre").val(),txtPlacas:$("#txtPlacas").val(),cboPropiedad:$("#cboPropiedad").val(),txtObserv:$("#txtObserv").val(),tipoEvento:"guardar"}
        console.log(infoR)

       $.ajax({
       	type: "POST",
       	url: "scripts/asp/usuarioVigilante_entradaGuardar.asp",
       	data: infoR 

       }).done(function(rest){
       		if(rest=="ok"){
            controlBarreraVisEn(1)
            //alert("Se guardo correctamente")
            $("#msjGuardado p").remove()
            $("#msjGuardado").append('<p style="color:#FF0000">Se guardo correctamente</p>')
            $('form').find('input:text, input:password, select, textarea').val('');
            $('#msjGuardado p').fadeOut(6000, function(){ $(this).remove();});
            $('#datatableIngreEngr').DataTable().ajax.reload();
          }
       })
    }


    function controlBarreraVisEn(abrioCer){
        
        $.ajax({
            url:"http://192.168.14.10/visitasEntrada_controlGate.php",
            method:"POST",
            data:{openClose:abrioCer}
        }).fail(function(){
            // if(parseInt(abrioCer)==1){
            //     alert("Enter para cerrar barrera")
            //     controlBarreraVisEn(2)
            // }else{
                
            // }
        })
    }

    $(document).on("click", "#btnGuardarEntradaCerrar",function(){
    	controlBarreraVisEn(2)
    })


  $.ajax({
      url:"scripts/asp/residentes.asp",
      cache: false,
      dataType: "json"
  }).done(function(rest){
      //rest.tipo
    $.each(rest, function (i, item) {
      $('#cboPropiedad').append(new Option(item.domicilio+' '+item.no_molestar, item.id));
    });
  })

    $("#cboPropiedad").change(function(){
        if($(this).val()!=""){
            var thisValUee = $("#cboPropiedad option:selected").text();

            if(thisValUee.indexOf('MOLESTAR')>=0){
                alert("Este residente tiene activado el MODO NO MOLESTAR, no se permite el acceso")
                $(this).val("");
            }
        }
    })

        var tipoIngreso
        $("#cboTipoIngreso").change(function(){
          tipoIngreso = $(this).val();
        });


});