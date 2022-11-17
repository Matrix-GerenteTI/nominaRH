
var tablaData;
var arrPercepciones = [];
var arrDeducciones = [];
var listaGlobal = [];
$(document).ready(function(e) {
    tablaData = $('#tableData').DataTable({
        columns: [
            { data: 'UDN' },
            { data: 'Departamento' },
            { data: 'Puesto' },
            { data: 'Empleado' },
            { data: 'Percepciones' },
            { data: 'Deducciones' },
            { data: 'Bancos' },
            { data: 'Efectivo' },
            { data: 'Vales' },
            { data: 'Otros' },
            { data: 'Total' }
        ],
        'columnDefs': [
            {
                "targets": 4, // your case first column
                "className": "text-center",
                "width": "10%"
           },
           {
                "targets": 5, // your case first column
                "className": "text-center",
                "width": "10%",
           },
           {
                "targets": 6, // your case first column
                "className": "text-center",
                "width": "10%",
           },
           {
                "targets": 7, // your case first column
                "className": "text-center",
                "width": "10%",
           },
           {
                "targets": 8, // your case first column
                "className": "text-center",
                "width": "10%",
           },
           {
                "targets": 9, // your case first column
                "className": "text-center",
                "width": "10%",
           },
           {
                "targets": 10, // your case first column
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

    comboSucursal();
    comboDepartamento();
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

function comboSucursal()
{
    $.post("ajax/ajaxparametros.php?op=cmbSucursal", "", function(resp){
        $("#busudn").html(resp);
        comboEmpleado();
    });
}

function comboDepartamento()
{
    $.post("ajax/ajaxparametros.php?op=cmbDepartamento", "", function(resp){
        $("#busdepartamento").html(resp);
        comboPuesto();
    });
}

function comboPuesto(){
    let depto = $("#busdepartamento").val();
    $.post("ajax/ajaxparametros.php?op=cmbPuesto", "iddepartamento="+depto, function(resp){
        console.log(resp)
        $("#buspuesto").html(resp);
        comboEmpleado();
    });
}

function comboEmpleado()
{
    let idsucursal = $("#busudn").val();
    let idpuesto = $("#buspuesto").val();
    $.post("ajax/ajaxparametros.php?op=cmbEmpleado", "idsucursal="+idsucursal+"&idpuesto="+idpuesto, function(resp){
        $("#busempleado").html(resp);
    });
}

function renderListaCalculo( lista ){
    tablaData.clear().draw();
    console.log( lista );
    listaGlobal = [];
    arrPercepciones = [];
    arrDeducciones = [];
    listaGlobal = lista;
    var row = lista;
    for(i in row){
        let lastNomina = row[i].bancos + row[i].efectivo + row[i].vales + row[i].otros;
        //console.log(row[i].percepciones)
        arrPercepciones[i] = row[i].percepciones;
        arrDeducciones[i] = row[i].deducciones;
        if(lastNomina>0){
            tablaData.row.add({
                'DT_RowId':i,
                'UDN':row[i].udn,
                'Departamento':row[i].departamento,
                'Puesto':row[i].puesto,
                'Empleado':row[i].empleado,
                'Percepciones':'<a href="javascript:verIncidencias('+i+',\'Percepciones\')">(+) $ '+row[i].totalpercepciones+'</a>',
                'Deducciones':'<a href="javascript:verIncidencias('+i+',\'Deducciones\')">(-) $ '+row[i].totaldeducciones+'</a>',
                'Bancos': '<input type="text" class="form-control" id="bancos_'+i+'" value="'+row[i].bancos+'" onKeyUp="updateMonto(\'bancos\','+i+')">',
                'Efectivo':'<input type="text" class="form-control" id="efectivo_'+i+'" value="'+row[i].efectivo+'" onKeyUp="updateMonto(\'efectivo\','+i+')">',
                'Vales':'<input type="text" class="form-control" id="vales_'+i+'" value="'+row[i].vales+'" onKeyUp="updateMonto(\'vales\','+i+')">',
                'Otros':'<input type="text" class="form-control" id="otros_'+i+'" value="'+row[i].otros+'" onKeyUp="updateMonto(\'otros\','+i+')">',
                'Total':'<span id="spanTotal_'+i+'">'+row[i].total+'</span>'
            }).draw(); 
        }else{
            if(row[i].idbanco!='' && row[i].cuenta!=''){
                listaGlobal[i].bancos = row[i].total;
                tablaData.row.add({
                    'DT_RowId':i,
                    'UDN':row[i].udn,
                    'Departamento':row[i].departamento,
                    'Puesto':row[i].puesto,
                    'Empleado':row[i].empleado,
                    'Percepciones':'<a href="javascript:verIncidencias('+i+',\'Percepciones\')">(+) $ '+row[i].totalpercepciones+'</a>',
                    'Deducciones':'<a href="javascript:verIncidencias('+i+',\'Deducciones\')">(-) $ '+row[i].totaldeducciones+'</a>',
                    'Bancos': '<input type="text" class="form-control" id="bancos_'+i+'" value="'+row[i].total+'" onKeyUp="updateMonto(\'bancos\','+i+')">',
                    'Efectivo':'<input type="text" class="form-control" id="efectivo_'+i+'" value="0" onKeyUp="updateMonto(\'efectivo\','+i+')">',
                    'Vales':'<input type="text" class="form-control" id="vales_'+i+'" value="0" onKeyUp="updateMonto(\'vales\','+i+')">',
                    'Otros':'<input type="text" class="form-control" id="otros_'+i+'" value="0" onKeyUp="updateMonto(\'otros\','+i+')">',
                    'Total':'<span id="spanTotal_'+i+'">'+row[i].total+'</span>'
                }).draw(); 
            }else{
                listaGlobal[i].efectivo = row[i].total;
                tablaData.row.add({
                    'DT_RowId':i,
                    'UDN':row[i].udn,
                    'Departamento':row[i].departamento,
                    'Puesto':row[i].puesto,
                    'Empleado':row[i].empleado,
                    'Percepciones':'<a href="javascript:verIncidencias('+i+',\'Percepciones\')">(+) $ '+row[i].totalpercepciones+'</a>',
                    'Deducciones':'<a href="javascript:verIncidencias('+i+',\'Deducciones\')">(-) $ '+row[i].totaldeducciones+'</a>',
                    'Bancos': '<input type="text" class="form-control" id="bancos_'+i+'" value="0" onKeyUp="updateMonto(\'bancos\','+i+')">',
                    'Efectivo':'<input type="text" class="form-control" id="efectivo_'+i+'" value="'+row[i].total+'" onKeyUp="updateMonto(\'efectivo\','+i+')">',
                    'Vales':'<input type="text" class="form-control" id="vales_'+i+'" value="0" onKeyUp="updateMonto(\'vales\','+i+')">',
                    'Otros':'<input type="text" class="form-control" id="otros_'+i+'" value="0" onKeyUp="updateMonto(\'otros\','+i+')">',
                    'Total':'<span id="spanTotal_'+i+'">'+row[i].total+'</span>'
                }).draw(); 
            }
        }
    }
}

function updateMonto(item,id){
    console.log(id)
    let valorbancos = $("#bancos_"+id).val();
    let valorefectivo = $("#efectivo_"+id).val();
    let valorvales = $("#vales_"+id).val();
    let valorotros = $("#otros_"+id).val();
    let total = (valorbancos*1) + (valorefectivo*1) + (valorvales*1) + (valorotros*1);
    if(total == listaGlobal[id].total){
        listaGlobal[id].bancos = valorbancos;
        listaGlobal[id].efectivo = valorefectivo;
        listaGlobal[id].vales = valorvales;
        listaGlobal[id].otros = valorotros;        
        $("#bancos_"+id).removeClass('bordeRojo');
        $("#efectivo_"+id).removeClass('bordeRojo');
        $("#vales_"+id).removeClass('bordeRojo');
        $("#otros_"+id).removeClass('bordeRojo');
        $("#spanTotal_"+id).removeClass('bordeRojo');
    }else{
        $("#bancos_"+id).addClass('bordeRojo');
        $("#efectivo_"+id).addClass('bordeRojo');
        $("#vales_"+id).addClass('bordeRojo');
        $("#otros_"+id).addClass('bordeRojo');
        $("#spanTotal_"+id).addClass('bordeRojo');
    }
}

function verIncidencias(id,tipo){
    let arreglo = [];
    if(tipo=='Percepciones')
        arreglo = arrPercepciones[id];
    else
        arreglo = arrDeducciones[id];
    //console.log(arrPercepciones)
    var echo = '';
    for(i in arreglo){
        echo+= '<div class="col-md-6">'+arreglo[i].incidencia+'</div>';
        echo+= '<div class="col-md-6">';
        echo+= '    <div class="input-group" data-target-input="nearest">';
        echo+= '        <input type="text" class="form-control" id="'+id+'_'+i+'" value="'+arreglo[i].monto+'" data-target="#'+id+'_'+i+'" autocomplete="off"/>';
        if(arreglo[i].permiso==1)
            echo+= '        <button class="input-group-text" data-target="#'+id+'_'+i+'" onclick="actualizaItem('+id+','+i+',\''+tipo+'\')"><i class="mdi mdi-content-save"></i></button>';
        echo+= '    </div>';
        echo+= '</div>';
    }
    $("#modalIncidenciasLabel").html(tipo);
    $("#bodyIncidencias").html(echo); 
    $("#modalIncidencias").modal('toggle');
}

function actualizaItem(id,i,tipo){
    let nuevovalor = $("#"+id+'_'+i).val();    
    console.log(nuevovalor)
    listaGlobal[id].percepciones[i].monto = nuevovalor
    console.log(listaGlobal[id].percepciones[i].monto)
    if(tipo=='Percepciones'){
        listaGlobal[id].percepciones[i].monto = nuevovalor;
        
    }else{
        listaGlobal[id].deducciones[i].monto = nuevovalor;
    }

    let totalpercepciones = 0;
    let totaldeducciones = 0;
    let percepciones = listaGlobal[id].percepciones;
    let deducciones = listaGlobal[id].deducciones;
    for(a in percepciones){
        totalpercepciones = totalpercepciones + (percepciones[a].monto * 1);
    }
    for(b in deducciones){
        totaldeducciones = totaldeducciones + (deducciones[b].monto * 1);
    }
    
    listaGlobal[id].totalpercepciones = totalpercepciones;
    listaGlobal[id].totaldeducciones = totaldeducciones;
    listaGlobal[id].total = totalpercepciones - totaldeducciones;
    miniNotify("success","Cambio guardado correctamente!");
    renderListaCalculo(listaGlobal);
}

function verLista(){
    console.log(listaGlobal.length)
    if(listaGlobal.length==0){
        lista();
    }else{
        confirmy('Cargar prenómina','question','Los datos modificados se perderán, ¿Desea continuar?','Si','No','lista','');
    }
}

function lista(){
    
    //$("#cargandoSVG").fadeIn();
    AlertLoading('Cargando Datos','Esto puede tardar unos segundos...');
    var fecIni = $("#fecIni").val();
    var fecFin = $("#fecFin").val();
    var udn = $("#busudn").val();
    var departamento = $("#busdepartamento").val();
    var puesto = $("#buspuesto").val();
    var empleado = $("#busempleado").val();
    var params = "fecIni="+fecIni;
    params+= "&fecFin="+fecFin;
    params+= "&udn="+udn;
    params+= "&departamento="+departamento;
    params+= "&puesto="+puesto;
    params+= "&empleado="+empleado;
    $.post("ajax/ajaxcalculo.php?op=lista", params, function(resp){   
        console.log(resp);
        Swal.close();
        var row = eval('('+resp+')');
        renderListaCalculo( row );
    });
    
}

function descargar(){ 
    var fecIni = $("#fecIni").val();
    var fecFin = $("#fecFin").val();
    $.post("/nomina/ajax/reportes/nomina.php", {
      fechaInicio: fecIni,
      fechaFin: fecFin,
      data: JSON.stringify(listaGlobal)
    },
      function (resp, textStatus, jqXHR) {
        console.log(resp)
        window.open( `/nomina/ajax/reportes/${resp}`,'_blank',"width=200,height=100" )
      },
      "text"
    );
    
  }

  
function guardar(){
    var fecIni = $("#fecIni").val();
    var fecFin = $("#fecFin").val();
    $.post("ajax/ajaxcalculo.php?op=siExiste", { fecIni: fecIni, fecFin: fecFin }, function (resp){
        if(resp>0)
            confirmy('Rehacer Nómina','question','Ya existe una nómina con esas fechas, si continua se borrará. ¿Desea continuar?','Si','No','confirmaGuardar','');
        else
            confirmaGuardar();
    });
}

function confirmaGuardar(){
    var fecIni = $("#fecIni").val();
    var fecFin = $("#fecFin").val();
    $.post("ajax/ajaxcalculo.php?op=guardaNomina", { data: JSON.stringify(listaGlobal), fecIni: fecIni, fecFin: fecFin }, function (resp){
        if(resp>0)
            okMsg("Listo!","Se ha guardado la nómina correctamente, ya puede imprimir los recibos.")
        else
            errorMsg("Ups!","No se pudo realizar la operación")
    });
}