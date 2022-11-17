
var tablaData;
$(document).ready(function(e) {
    tablaData = $('#tableData').DataTable({
        columns: [
            { data: 'Usuario' },
            { data: 'Modulo' },
            { data: 'Fecha' },
            { data: 'Hora' },
            { data: 'Movimiento' },
            { data: 'Query' }
        ],
        'columnDefs': [
            {
                "targets": 1, // your case first column
                "className": "text-center",
                "width": "10%"
           },
           {
                "targets": 2, // your case first column
                "className": "text-center",
                "width": "10%",
           },
           {
                "targets": 3, // your case first column
                "className": "text-center",
                "width": "10%",
           }
         ],
        "language": {
            url: "https://cdn.datatables.net/plug-ins/1.12.1/i18n/es-MX.json"
        }
    }); 
    
    $("#fecIni").datepicker({
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
        yearRange: '1930:+0'
    });
    $("#fecFin").datepicker({
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
        yearRange: '1930:+0'
    });

    cmbUsuario();
    cmbModulo();
});

function getCurrentDate(){
    var today = new Date();
    var dd = today.getDate();

    var mm = today.getMonth()+1; 
    var yyyy = today.getFullYear();
    if(dd<10) 
    {
        dd='0'+dd;
    } 

    if(mm<10) 
    {
        mm='0'+mm;
    } 
    
    
    return `${dd}/${mm}/${yyyy}`
}

function cmbUsuario(){
    $.post("ajax/ajaxbitacora.php?op=cmbUsuario", '', function(resp){   
        $("#bususuario").html(resp);
    });
}

function cmbModulo(){
    $.post("ajax/ajaxbitacora.php?op=cmbModulo", '', function(resp){   
        $("#busmodulo").html(resp);
    });
}

function renderListaBitacora( lista ){
    tablaData.clear().draw();
    console.log( lista );
    var row = lista;
    for(i in row){
        tablaData.row.add({
            'DT_RowId':row[i].id,
            'Usuario':row[i].usuario,
            'Modulo':row[i].modulo,
            'Fecha':row[i].fecha,
            'Hora':row[i].hora,
            'Movimiento':row[i].movimiento,
            'Query':'<a href="javascript:verQuery(\''+row[i].query+'\')">Ver</a>'
        }).draw(); 
    }
}

function verQuery(query){
    $("#txtQuery").html(atob(query))
    $("#modalQuery").modal('toggle');
}

function lista(){
    //$("#cargandoSVG").fadeIn();
    AlertLoading('Cargando Datos','Esto puede tardar unos segundos...');
    var fecIni = $("#fecIni").val();
    var fecFin = $("#fecFin").val();
    var usuario = $("#bususuario").val();
    var modulo = $("#busmodulo").val();
    var params = "fecIni="+fecIni;
    params+= "&fecFin="+fecFin;
    params+= "&usuario="+usuario;
    params+= "&modulo="+modulo;
    $.post("ajax/ajaxbitacora.php?op=lista", params, function(resp){   
        Swal.close();
        var row = eval('('+resp+')');
        renderListaBitacora( row );
    });
    
}
