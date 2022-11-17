
var tablaData;
$(document).ready(function(e) {

    tablaData = $('#tableData').DataTable({
        columns: [
            { data: 'Sucursal' },
            { data: 'Depto' },
            { data: 'Puesto' },
            { data: 'Empleado' },
            { data: 'Asistencias' },
            { data: 'Retardos' },
            { data: 'Faltas' }
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
    
    comboCatalogo('bus','departamento',1,'puesto');
    comboCatalogo('bus','sucursal',1);
    comboCatalogo('upd','sucursal',1);
    
});

let trabajadorSeleccionado = [];

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

$("#btnCerrarControl").click(function (e) { 
    e.preventDefault();
    $("#modalControlAsistencia").hide();
            $('html, body').css({
            overflow: 'auto',
        });
});
let asistencias;
function controlAsistencia(opc, idItem) {
// 	$("html, body").animate({scrollTop:"0px"});
// 	$('html, body').css({
// overflow: 'hidden',
// height: '100%'
// });
    $("#logAsistencia").html('');
    //$("#modalControlAsistencia").fadeIn('slow');
    $("#modalControlAsistencia").modal('toggle');
    //accediendo a las asistencias del  empleado
    let empleado = asistencias[idItem];
    trabajadorSeleccionado = empleado;
    let templateItem = '';
    let idEmpleado = empleado.nip;
    $("#displaySetIngresoXFalta").hide();
    $("#horaIngresoxFalta").val('');
    $("#nipIngesoXFalta").val('');

    switch (opc) {
        case 'asistencia':
            $("#headerEliminaIncidencia").hide();
            $("#headerMontoIncidencia").hide();
            $("#displaySetIngresoXFalta").hide();

            $("#tituloControl").html("Registro de Asistencia");
            $.each(empleado.asistencia, function (i, item) { 
                for(t in item){
                    item[t].ubicacion==null?ubicaciontxt='NR':ubicaciontxt=item[t].ubicacion;
                    item[t].imagen==null?imagentxt='/nomina/assets/images/sinimagen.jpg':imagentxt=item[t].imagen;
                    templateItem += `
                        <tr>
                            <td><img src="${imagentxt}" /></td> 
                            <td>${ubicaciontxt}</td>
                            <td>${i}</td>
                            <td>${item[t].hora}</td>
                            <td>${item[t].tipo}</td>
                        </tr>
                    `;
                }
            });
        break;
        case 'retardos':
            $("#tituloControl").html('Registro de Rertardos');	
                
                $.each(empleado.retardos, function (i, item) { 
                    for(t in item){
                        $("#headerEliminaIncidencia").show();
                        $("#headerMontoIncidencia").show();
                        $("#displaySetIngresoXFalta").hide();
                        item[t].ubicacion==null?ubicaciontxt='NR':ubicaciontxt=item[t].ubicacion;
                        item[t].imagen==null?imagentxt='/nomina/assets/images/sinimagen.jpg':imagentxt=item[t].imagen;
                        templateItem += `
                                <tr>
                                    <td><img src="${imagentxt}" /></td>
                                    <td>${ubicaciontxt}</td>
                                    <td>${i}</td>
                                    <td>${item[t].hora}</td>
                                    <td>${item[t].tipo}</td>
                                    <td><button class="btn btn-icon btn-warning" onclick="removeIncidenciaAsistencia( {
                                            tipo: 'retardo',
                                            monto: 0,
                                            empleado: ${idEmpleado},
                                            incidencia: '',
                                            checado: '${i} ${item[t].hora}',
                                            index: ${idItem}
                                    })"><i class="mdi mdi-cached"></i></button></td>
                                </tr>
                        `;
                    }
                });
        break;
        case 'faltas':
                $("#tituloControl").html("Registro de Faltas");
                $("#headerEliminaIncidencia").show();
                $("#headerMontoIncidencia").show();

                $.each(empleado.faltas, function (i, item) { 
                    for(t in item){
                        item[t].ubicacion==null?ubicaciontxt='NR':ubicaciontxt=item[t].ubicacion;
                        item[t].imagen==null?imagentxt='/nomina/assets/images/sinimagen.jpg':imagentxt=item[t].imagen;
                        templateItem += `
                                <tr>
                                    <td><img src="${imagentxt}" /></td>
                                    <td>${ubicaciontxt}</td>
                                    <td>${i}</td>
                                    <td>${item[t].hora}</td>
                                    <td>${item[t].tipo}</td>
                                    <td><button class="btn btn-icon btn-warning" onclick="removeIncidenciaAsistencia( {
                                            tipo: 'falta',
                                            monto:0,
                                            empleado: ${idEmpleado},
                                            incidencia: '',
                                            checado: '${i} ${item[t].hora}',
                                            index: ${idItem}
                                    })"><i class="mdi mdi-cached"></i></button>
                                    </td>
                                </tr>
                        `;
                    }
                });			
        break;
        default:
            break;
    }
    $("#logAsistencia").html(templateItem );
} 

function removeIncidenciaAsistencia( params ) {
    $("#horaIngresoxFalta").val('');
    $("#nipIngesoXFalta").val( params.empleado );
    $("#btnSetAsistenciaDeFalta").attr('onClick', `confirmRemoveFalta(${JSON.stringify( params ) })`);
    $("#displaySetIngresoXFalta").show();
    $("#horaIngresoxFalta").val('');
    $("#nipIngesoXFalta").val('');
}

function confirmRemoveFalta( params ) {
    //Variable para asignarle asistencia en caso de que se le de ingreso a raíz de una falta
    nuevoIngreso = '';
    nuevaIncidencia = 0;
    nuevaUbicacion = '';
    if( params.tipo != 'asistencia'){
        nuevoIngreso = $("#horaIngresoxFalta").val();
        nuevaUbicacion = $("#updsucursal").val();
        //nuevaIncidencia = $("#sancion_"+params.index).val();
        if(nuevaUbicacion>0){
            if( nuevoIngreso.trim()  == ''){
                errorMsg("Ups!","Debe elegir una hora de ingreso aproximada");
                return 0;
            }
        }else{
            errorMsg("Ups!","Debe elegir una nueva ubicacion");
            return 0;
        }
    }

    console.log(params)
    $.ajax({
            url: "/intranet/controladores/nomina/trabajadores.php?opc=setAplicacionIncidenciaAsistencia",
            type: 'POST',
            data: {
                empleado: params.empleado,
                checado: params.checado,
                incidencia: nuevaIncidencia,
                horaNvoIngreso: nuevoIngreso,
                nuevaUbicacion: nuevaUbicacion
            },
            dataType: "text",
            success: function(result) {
                console.log(result)
                if ( result >= 0) {
                    let lael = params.tipo=='falta'?'la':'el';
                    okMsg("Listo!",`Se ha modificado ${lael} ${params.tipo} al trabajador ${trabajadorSeleccionado.nombre}`);
                    lista(0 , 15);                    					
                    $("#displaySetIngresoXFalta").hide();
                    $("#horaIngresoxFalta").val('');
                    $("#nipIngesoXFalta").val('');          
                    $("#modalControlAsistencia").modal('toggle');          
                }else{
                    errorMsg("Ups!","No se pudo realizar la operación");
                }
            }
        });
}

function renderListaAsistencia( lista ){
    tablaData.clear().draw();
    console.log( lista );
    var row = lista;
    for(i in row){
        tablaData.row.add({
            'DT_RowId':row[i].nip,
            'Sucursal':row[i].sucursal,
            'Depto':row[i].depto,
            'Puesto':row[i].puesto,
            'Empleado':row[i].nombre,
            'Asistencias':'<a href="#" onclick="controlAsistencia(\'asistencia\','+i+')">'+row[i].asistenciaTotal+'</a>',
            'Retardos':'<a href="#" onclick="controlAsistencia(\'retardos\','+i+')">'+row[i].retardosTotal+'</a>',
            'Faltas':'<a href="#" onclick="controlAsistencia(\'faltas\','+i+')">'+row[i].faltasTotal+'</a>'
        }).draw(); 
    }
}

function lista(inicio,cantidad){
    //$("#cargandoSVG").fadeIn();
    AlertLoading('Cargando Datos','Esto puede tardar unos segundos...');
    var fecIni = $("#fecIni").val();
    var fecFin = $("#fecFin").val();
    var nombre = $("#busempleado").val();
    var sucursal = $("#bussucursal").val();
    var depto = $("#busdepartamento").val();		
    var puesto = $("#buspuesto").val();
    var params = "fecIni="+fecIni;
    params+= "&fecFin="+fecFin;
    params+= "&nombre="+nombre;
    params+= "&sucursal="+sucursal;
    params+= "&departamento="+depto;
    params+= "&puesto="+puesto;
    params+= "&inicio="+inicio;
    params+= "&cantidad="+cantidad;
    $.post("ajax/ajaxasistencia.php?op=lista", params, function(resp){   
        console.log(resp);     
        //$("#cargandoSVG").fadeOut();
        Swal.close();
        //console.log(resp);
        //alert(resp);
        //$("#paginacion").html(resp);
        var row = eval('('+resp+')');
        asistencias = row;
        renderListaAsistencia( row );
    });
    
}

function aplicar(){
    var fecIni = $("#fecIni").val();
    var fecFin = $("#fecFin").val();
    $.post("ajax/ajaxasistencia.php?op=guardaAsistencia", { data: JSON.stringify(asistencias), fechaIni: fecIni, fechaFin: fecFin }, function (resp){
        if(resp==1)
            okMsg("Listo!","Se han guardado las asistencias correctamente, ya puede procesar la nómina.")
        else
            errorMsg("Ups!","No se pudo realizar la operación")
    });
    
}

function listaIncidenciasAsistencia() {
    inicio = 0;
    cantidad = 0;

    $.post("ajax/ajaxasistencia.php?op=lista", {
        fecIni: $("#fecIni").val(),
        fecFin: $("#fecFin").val(),
        nombre: $("#busempleado").val(),
        sucursal: $("#bussucursal").val(),
        departamento: $("#busdepartamento").val(),
        puesto: $("#buspuesto").val(),
        inicio: inicio,
        cantidad: cantidad
    }, function(resp){
        //alert(resp);
        //$("#paginacion").html(resp);
          var row = eval('('+resp+')');
            asistencias = row;
        var echo = "";
        var n=0;
        for(i in row){
            echo+= "<tr class='text-center'>";
            echo+= "	<td>"+row[i].sucursal+"</td>";
            echo+= "	<td>"+row[i].depto+"</td>";
            echo+= "	<td>"+row[i].puesto+"</td>";
            echo+= "	<td>"+row[i].nombre+"</td>";
            echo+= `	<td style='text-align:center;cursor:pointer' onclick='controlAsistencia("asistencia",${row[i].id})'>${row[i].historialAsistencia.length}</td>`;
            echo+= `	<td style='text-align:center;cursor:pointer' onclick='controlAsistencia("retardos",${row[i].id})'>${row[i].nRetardos}</td>`;
            echo+= `	<td style='text-align:center;cursor:pointer' onclick='controlAsistencia("faltas",${row[i].id})'>${row[i].faltas}</td>`;
            echo+= `	 <td>
                                    <select class="sancion_empleado" id="emp_${row[i].id}">
                                        <option>Aplica</option>
                                        <option>No Aplica</option>
                                        <option>Aplica Sancion Diferente</option>
                                    </select>
                                </td>`;
            echo+= `	<td>
                                    <label>Concepto</label>
                                    <input type="number" placeholder="Ingresa un monto"
                                    <label>Observaciones:</label>
                                    <textarea></textarea>
                                </td>`;
            echo+= "<tr>";
            n++;
        }
        for(j=n;j<cantidad;j++){
            echo+= "<tr>";
            echo+= "	<td>&nbsp;</td>";
            echo+= "	<td>&nbsp;</td>";
            echo+= "	<td>&nbsp;</td>";
            echo+= "	<td>&nbsp;</td>";
            echo+= "	<td>&nbsp;</td>";
            echo+= "	<td>&nbsp;</td>";
            echo+= "	<td>&nbsp;</td>";
            echo+= "<tr>";
        }
        $("#tbody").html(echo);
    });
}

function imprimir(){
    var ficha = document.getElementById('tablaExport');
    var ventimp = window.open(' ', 'popimpr');
    ventimp.document.write( ficha.innerHTML );
    ventimp.document.close();
    ventimp.print( );
    ventimp.close();
}


function descargar(){ 
    var fecIni = $("#fecIni").val();
    var fecFin = $("#fecFin").val();
    $.post("/nomina/ajax/reportes/asistencias.php", {
      fechaInicio: fecIni,
      fechaFin: fecFin,
      data: JSON.stringify(asistencias)
    },
      function (resp, textStatus, jqXHR) {
        console.log(asistencias)
        window.open( `/nomina/ajax/reportes/${resp}`,'_blank',"width=200,height=100" )
      },
      "text"
    );
    
  }

function comboCatalogo(prefijo,catalogo,tipo,scatalogo,sscatalogo,ssscatalogo){
    var id = "";
    if(tipo==1){
        $.post("ajax/ajaxempleado.php?op=comboCatalogo", "catalogo="+catalogo+"&tipo="+tipo, function(resp){
            //alert(resp);
            $("#"+prefijo+""+catalogo).html("<option value='%'>TODOS...</option>"+resp);
            
            //Cargamos el subcombo
            if(typeof scatalogo != 'undefined'){
                id = $("#"+prefijo+""+catalogo).val();
                $.post("ajax/ajaxempleado.php?op=comboCatalogo", "catalogo="+catalogo+"&scatalogo="+scatalogo+"&id="+id+"&tipo="+tipo, function(sresp){
                    $("#"+prefijo+""+scatalogo).html("<option value='%'>TODOS...</option>"+sresp);
                    
                    //Cargamos el subcombo
                    if(typeof sscatalogo != 'undefined'){
                        id = $("#"+prefijo+""+scatalogo).val();
                        $.post("ajax/ajaxempleado.php?op=comboCatalogo", "catalogo="+scatalogo+"&scatalogo="+sscatalogo+"&id="+id+"&tipo="+tipo, function(ssresp){
                            $("#"+prefijo+""+sscatalogo).html(ssresp);
                            
                            //Cargamos el subcombo
                            if(typeof ssscatalogo != 'undefined'){
                                id = $("#"+prefijo+""+sscatalogo).val();
                                $.post("ajax/ajaxempleado.php?op=comboCatalogo", "catalogo="+sscatalogo+"&scatalogo="+ssscatalogo+"&id="+id+"&tipo="+tipo, function(sssresp){
                                    $("#"+prefijo+""+ssscatalogo).html(sssresp);
                                });
                            }
                        });
                    }
                });
            }
        });
    }
    if(tipo==2){
        if(typeof scatalogo != 'undefined'){
            id = $("#"+prefijo+""+catalogo).val();
            $.post("ajax/ajaxempleado.php?op=comboCatalogo", "catalogo="+catalogo+"&scatalogo="+scatalogo+"&id="+id+"&tipo="+tipo, function(sresp){
                $("#"+prefijo+""+scatalogo).html(sresp);
                
                //Cargamos el subcombo
                if(typeof sscatalogo != 'undefined'){
                    id = $("#"+prefijo+""+scatalogo).val();
                    $.post("ajax/ajaxempleado.php?op=comboCatalogo", "catalogo="+scatalogo+"&scatalogo="+sscatalogo+"&id="+id+"&tipo="+tipo, function(ssresp){
                        $("#"+prefijo+""+sscatalogo).html(ssresp);
                        
                        //Cargamos el subcombo
                        if(typeof ssscatalogo != 'undefined'){
                            id = $("#"+prefijo+""+sscatalogo).val();
                            $.post("ajax/ajaxempleado.php?op=comboCatalogo", "catalogo="+sscatalogo+"&scatalogo="+ssscatalogo+"&id="+id+"&tipo="+tipo, function(sssresp){
                                $("#"+prefijo+""+ssscatalogo).html(sssresp);
                            });
                        }
                    });
                }
            });
        }
    }
    if(tipo==3){
        $.post("ajax/ajaxempleado.php?op=comboCatalogo", "catalogo="+catalogo+"&tipo="+tipo, function(resp){
            //alert(resp);
            $("#"+prefijo+""+catalogo).html(resp);
            
            //Cargamos el subcombo
            if(typeof scatalogo != 'undefined'){
                id = $("#"+prefijo+""+catalogo).val();
                $.post("ajax/ajaxempleado.php?op=comboCatalogo", "catalogo="+catalogo+"&scatalogo="+scatalogo+"&id="+id+"&tipo="+tipo, function(sresp){
                    $("#"+prefijo+""+scatalogo).html(sresp);
                    
                    //Cargamos el subcombo
                    if(typeof sscatalogo != 'undefined'){
                        id = $("#"+prefijo+""+scatalogo).val();
                        $.post("ajax/ajaxempleado.php?op=comboCatalogo", "catalogo="+scatalogo+"&scatalogo="+sscatalogo+"&id="+id+"&tipo="+tipo, function(ssresp){
                            $("#"+prefijo+""+sscatalogo).html(ssresp);
                            
                            //Cargamos el subcombo
                            if(typeof ssscatalogo != 'undefined'){
                                id = $("#"+prefijo+""+sscatalogo).val();
                                $.post("ajax/ajaxempleado.php?op=comboCatalogo", "catalogo="+sscatalogo+"&scatalogo="+ssscatalogo+"&id="+id+"&tipo="+tipo, function(sssresp){
                                    $("#"+prefijo+""+ssscatalogo).html(sssresp);
                                });
                            }
                        });
                    }
                });
            }
        });
    }
}