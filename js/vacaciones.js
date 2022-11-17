let fechasProgramadas = [];
let fechasTime = [];
let fechasSeleccionadas = '';
let fechasACancelar = [];
let diasVacaciones = 0;
let nipEmpleado = -1;
let anioProgramar = new Date();
anioProgramar = anioProgramar.getFullYear();

let inicioPeriodo = undefined;
let finPeriodo = undefined;

let pickerVacaciones = $("#fechasProgramada");
let minDate = new Date();
let maxDate = new Date();



$('#inicioPeriodo').datepicker({
onSelect: function (fd , date) {
    minDate = new Date(date.getFullYear() , date.getMonth(), date.getDate() );

    maxDate = new Date(date.getFullYear() +1  , date.getMonth(), 0 );
    pickerVacaciones.datepicker({
        minDate: minDate,
        maxDate: maxDate
    })

}
})



$('#fechasProgramada').datepicker({
language: 'es',
})
// Access instance of plugin
$('#fechasProgramada').data('datepicker')	
let fechaHoy = new Date()			   
listarTrabajadoresConVacaciones('');
buslista();

function formatearFecha(fecha){
    fec = fecha.split("-");
    return fec[2]+"/"+fec[1]+"/"+fec[0];	
}

function calculaTiempo(origen,destino,tipo){
    var fecha = $("#"+origen).val();
    $.post("ajax/ajaxempleado.php?op=calculaTiempo", "fecha="+fecha+"&tipo="+tipo, function(resp){
        //alert(resp);
        $("#"+destino).val(resp);
    });
}

function buscar(){
    $("#busquedaEmpleados").modal('toggle');
    comboCatalogo('bus','departamento',3);
    buslista();
}

function buslista(){
    var departamento = $("#busdepartamento").val();
    var nombre = $("#busnombre").val();
    $.post("ajax/ajaxempleado.php?op=buslista", "departamento="+departamento+"&nombre="+nombre+"&estado=1", function(resp){
  console.log(resp)
        //alert(resp);
          var row = eval('('+resp+')');
        var echo = "";
        for(i in row){
            echo+= "<tr style='cursor:pointer' onClick='loadmodal(\""+row[i].nip+"\")'>";
            echo+= "	<td>"+row[i].departamento+"</td><td>"+row[i].nombre+"</td>";
            echo+= "<tr>";
        }
        $("#bustbody").html(echo);
    });
}

function loadmodal(nip){
    $("#busquedaEmpleados").modal('toggle');
    cargar(nip);
    
}

function cargar(nip){
    $.post("ajax/ajaxempleado.php?op=cargar", "nip="+nip, function(resp){
        //alert(resp);
        $(".btn-guarda").attr('href','javascript:actualizar();')
        var row = eval('('+resp+')');
        //Datos de pempleado
        $("#nip").val(row.nip);
        nipEmpleado = row.nip;
        
        $("#nombre").val(row.nombre);
        $("#antiguedad").val( row.antiguedad);
        $("#tieneVacaciones").val( row.diasVacaciones > 0  ? `${row.diasVacaciones} Días` : 'No');
        $("#fechaInicioLab").val( (row.fechainiciolab).replace(/-/g, "/") );
        diasVacaciones = row.diasVacaciones - (row.listaVacaciones).length;

        $("#diasProgramados").val( (row.listaVacaciones).length );

        recargaCalendario( row.listaVacaciones );
    });
}

function recargaCalendario( listaVacaciones ) {
        fechasProgramadas = [];
         fechasTime = [];
        let fechaRegistrada;

        $.each(listaVacaciones, function (i, item) { 
             splitedFecha = item.fecha.split("-");
             fechaRegistrada = new Date(splitedFecha[0] , splitedFecha[1] -1 , splitedFecha[2] );

             fechasProgramadas.push( fechaRegistrada  );
             fechasTime.push( `${fechaRegistrada.getDate()}${fechaRegistrada.getMonth()}${fechaRegistrada.getFullYear()}` );
        });

        $('#fechasProgramada').datepicker().data('datepicker').clear();
        $('#fechasProgramada').datepicker({
                language: 'es',
                multipleDates: diasVacaciones ,
                multipleDatesSeparator: ',',
                maxDate: maxDate,
                minDate: minDate,
                onChangeMonthr: function (month, year) {
                     anioProgramar = year;
                     
                },
                onRenderCell: function (date, cellType) {
                    //console.log(date)
                    // Add extra element, if `eventDates` contains `currentDate`                            
                        if (cellType == 'day' && fechasTime.indexOf( `${date.getDate()}${date.getMonth()}${date.getFullYear()}` ) != -1 ) {                                                                
                            return {
                                html: date.getDate() + '<span class="dp-note"></span>'
                            }
                        }                             
                },
                onSelect: function onSelect(fd, date , picker ) {
                    console.log(date)
                    let nSeleccionados = date.length ;
                    let yaProgramadas = []; 
                    let fechasMensaje = [];
                    console.log(date.length);
                    if ( nSeleccionados > 0 ) {
                      console.log(date);
                        date.forEach( function ( item , i ) {      
                          console.log(fechasTime.indexOf( `${item.getDate()}${item.getMonth()}${item.getFullYear()}` ));                       
                            if( fechasTime.indexOf( `${item.getDate()}${item.getMonth()}${item.getFullYear()}` ) != -1 ){
                                yaProgramadas.push( `${i}` );

                                //Acá eliminamos las fechas que fueron seleccionadas para cancelar para luego volverl
                                fechasACancelar.forEach( function ( value , j ) {
                                    if ( `${item.getDate() <10 ? '0' : ''}${item.getDate()}/${item.getMonth()+1 <10 ? '0' : ''}${item.getMonth()+1}/${item.getFullYear()}` == fechasACancelar[j]) {
                                        fechasACancelar.splice( j , 1 );
                                    }
                                    
                                });

                                fechasACancelar.push( `${item.getDate() <10 ? '0' : ''}${item.getDate()}/${item.getMonth() +1 <10 ? '0' : ''}${item.getMonth()+1}/${item.getFullYear()}` )
                            }else{
                              //console.log(`${item.getDate()}/${item.getMonth()+1}/${item.getFullYear()}`);
                                if ( fechasMensaje.indexOf(`${item.getDate()}/${item.getMonth()+1}/${item.getFullYear()}` ) == -1  ) {
                                    fechasMensaje.push( `${item.getDate()}/${item.getMonth()+1}/${item.getFullYear()}`  );

                                }
                            }
                        
                        });
                        
                    }else{
                        fechasACancelar = [];
                        $("#contentConfirmaVacaciones").fadeOut();
                        $("#containerCancelaVacaciones").fadeOut();
                    }                       
                    
                    //verificando que las fechas para cancelar coincidadn con las que hay seleccionadas
                    fechasACancelar.forEach( function ( value , j ) {                               
                        console.log(fechasACancelar)
                            if ( fd.search( value )  == -1 ) {
                                fechasACancelar.splice( j , 1 );
                            }        
                    });
                    
                     if ( yaProgramadas.indexOf( `${(nSeleccionados -1 )}`  ) != -1  && nSeleccionados > 0 ) {
                        
                        $("#contentConfirmaVacaciones").fadeOut();
                        $("#containerCancelaVacaciones").fadeIn();
                        $("#txtFechasCancelar").html( fechasACancelar.join(", ") );
                        
                     }else if(  nSeleccionados > 0 ) {
                        //console.log(fechasMensaje)
                        $("#contentConfirmaVacaciones").fadeIn();
                        //console.log(fechasMensaje);
                        $("#txtFechasConfirmar").html( fechasMensaje.join(", ") );
                        $("#containerCancelaVacaciones").fadeOut();
                        fechasSeleccionadas = fd;
                     }
                     
                }
            })
        
        // pickerVacaciones.data('datepicker').selectDate( fechasProgramadas  );
        $('#fechasProgramada').data('datepicker');
}

$('#filtroPeriodo').datepicker({
    onSelect: function (fd , date) {
      console.log(date.getFullYear())
      listarTrabajadoresConVacaciones('')
    }
})

function listarTrabajadoresConVacaciones(periodo) {
    $.get("/intranet/controladores/nomina/trabajadores.php?anio="+periodo, {
        opc: 'listarVacaciones',

    },
        function (data, textStatus, jqXHR) {
            let template = `                         
                       <div class="rowtable header">
                                <div class="cell">
                                    Nombre
                                </div>
                                <div class="cell">
                                    Puesto
                                </div>
                                <div class="cell">
                                    Sucursal
                                </div>
                                <div class="cell">
                                    # Días vacaciones
                                </div>
                                <div class="cell">
                                   Constancia
                                </div>                                    
                            </div>`;
            $.each(data, function (i, item) { 
                 template += `
                                    <div class="rowtable">
                                            <div class="cell" data-title="Nombre">
                                            ${item.empleado}
                                            </div>
                                            <div class="cell" data-title="Puesto">
                                            ${item.puesto}
                                            </div>
                                            <div class="cell" data-title="Sucursal">
                                            ${item.sucursal}
                                            </div>
                                            <div class="cell" data-title="# Días programados">
                                            ${item.diasProgramados}
                                            </div>`;
                //console.log(item.permisos.guardar)
                if(item.permisos.imprimir){
                    template += `           <div class="cell" data-title="Constancia" style="cursor:pointer" onclick="printConstancia(${item.nip})">
                                            <i class="icon-print"></i><span>Imprimir</span> </a> </li>
                                            </div>`;
                }else{
                    template += `           <div class="cell" data-title="Constancia">
                                            <i class="icon-print"></i><span>Imprimir</span> </a> </li>
                                            </div>`;
                }
                template += `           </div>`;
            });
            $("#trabajadoresProgramados").html( template );
        },
        "json"
    );
}

function comboCatalogo(prefijo,catalogo,tipo,scatalogo,sscatalogo,ssscatalogo){
    var id = "";
    if(tipo==1){
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

function printConstancia( idempleado ) {
    $.get("/nomina/ajax/controladores/formateria/vacaciones.php", {
        empleado : idempleado
    },
        function (data, textStatus, jqXHR) {
          console.log(data);
            window.open(data, "_blank");
        },
        "text"
    );
}

$("#confirmaVacaciones").click(function (e) { 
    e.preventDefault();
    //Buscando que la fecha ya haya sido seleccionada
    let fechas = fechasSeleccionadas.split(",");
    let index = [];
    fechas.forEach( function (item , i ) {      
         if( fechasTime.indexOf( `${ item.replace(/\//g, '' ) }` ) != -1 ){
            index.push( i );
         }
     })
     //Eliminando los indices que ya habían sido programados con anterioridad
     index.forEach( function ( value ) {
            fechas.splice( value , 1 );
       });
    let fechasAProgramar = fechas.join(",");
    $.post("/intranet/controladores/nomina/trabajadores.php?opc=agendarVacaciones", {
        trabajador: $("#nip").val(),
        fechas: fechasAProgramar,
        periodo: `${minDate.getMonth()}/${minDate.getFullYear()} A ${maxDate.getMonth()}/${maxDate.getFullYear()}`,
        observaciones: $("#observaciones").val()
    },
        function (data, textStatus, jqXHR) {
          console.log(data);
            let periodoSelected = $("#filtroPeriodo").val();
            listarTrabajadoresConVacaciones('');
            cargar( nipEmpleado );
            if ( data.length > 0 ) {
                okMsg("Listo!","Se le han programado vacaciones al empleado")
                $("#observaciones").val('')
            }else{
                errorMsg("Ups!","Es posible que el trabajador no cuente con días disponibles para vacacionar");
            }
        },
        "json"
    );
});

$("#cancelarDiaVacacion").click(function (e) { 
    e.preventDefault();

    let fechasCancelar = fechasACancelar.join(",");
    $.post("/intranet/controladores/nomina/trabajadores.php?opc=actualizarVacaciones", {
        trabajador: $("#nip").val(),
        fechas: fechasCancelar,
        estado: "pendiente"
    },
        function (data, textStatus, jqXHR) {
            console.log(data);
            let periodoSelected = $("#filtroPeriodo").val();
            listarTrabajadoresConVacaciones('');
            cargar( nipEmpleado );
            if ( data > 0 ) {
                okMsg("Listo!","Se han cancelado los días vacacionales")
            }else{
                errorMsg("Ups!","Ocurrió el siguiente error: "+data );
            }
        },
        "json"
    );

});

function formatearFecha(fecha){
    fec = fecha.split("-");
    return fec[2]+"/"+fec[1]+"/"+fec[0];	
}

function formatDBDate(fecha) {
    fec = fecha.split("/");
    return fec[2]+"-"+fec[1]+"-"+fec[0];	
}