
var link = document.createElement('a');
$("#descargaListaTrabajadores").click(function (e) { 
    let tipoempleado = $("#empleadotipo").val();
    e.preventDefault(); 
    $.get("/nomina/ajax/reportes/Empleados/TrabajadoresActivos.php", {
        opc: "generar",
        tipo: tipoempleado
    },
    function (data, textStatus, jqXHR) {
        console.log(data)
        downloadFile( `/nomina/ajax/reportes/Empleados/${data}` );

    },
    "text"
    );

});

function downloadFile(filePath) {
    link.href = filePath;
    link.download = filePath.substr(filePath.lastIndexOf('/') + 1);
    link.click();
  }