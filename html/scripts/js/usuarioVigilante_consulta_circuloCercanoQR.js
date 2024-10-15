$(document).ready(function(){
// (function ($) {
	// "use strict";

  
   // var init = function(){
    $('#datatableQR').dataTable({
      ajax: 'scripts/asp/usuarioVigilante_consulta_circuloCercanoQR.asp', 
      processing: true,
      "oLanguage": {
    "sUrl": "../../libs/datatables/tableLanguaje.txt"
  },
      //"scrollY":  "200px",
      //"scrollCollapse": true,
      columns: [
          
          { data: "id" },
          { data: "nombre"},
          { data: "domicilio" },
          { data: "circulo" },
          { data: "entrada" },
          { data: "QR", "orderable": false },
          { data: "no_molestar" }
      ]
    });
  // };

  // for ajax to init again
 // $.fn.dataTable.init = init;

});//(jQuery);


// $(document).ready(function() {
//   $('#datatableQR').DataTable({
//     //ajax:"asp/llenainfo.asp",
//     "ajax": {"url": "asp/llenainfo.asp", "type":"POST", "dataType":"json", "dataSrc":"datos"},
//     "columns":[
//                 {"data" :"id"},
//                 {"data" :"Nombre"},
//                 {"data" :"AP"},
//                 {"data" :"AM"},
//                 {"data" :"Email"}
//               ]
//   });
//   });
