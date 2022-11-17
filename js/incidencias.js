$(document).ready(function(e) {
    reiniciar();
    
    $("#fechaCargo").datepicker({
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
        yearRange: '1930:+0',
        dateFormat: 'yy-mm-dd'
    });
    $("#fechaVencimiento").datepicker({
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
        yearRange: '1930:+0',
        dateFormat: 'yy-mm-dd'
    });		

    $("#busnombre").keyup(function(e){
        let texto = $(this).val();
        console.log(texto)
        buslista();
    });
    
});

function buscar(){
    $("#busquedaEmpleados").modal('toggle');
    comboCatalogo('bus','departamento',3);
    buslista();
}

function buslista(){
    var departamento = $("#busdepartamento").val();
    var nombre = $("#busnombre").val();
    $.post("ajax/ajaxempleado.php?op=buslista", "departamento="+departamento+"&nombre="+nombre+"&estado=1", function(resp){
        //alert(resp);
          var row = eval('('+resp+')');
        var echo = "";
        for(i in row){
            echo+= "<tr style='cursor:pointer' onClick='cargar(\""+row[i].nip+"\")'>";
            echo+= "	<td>"+row[i].departamento+"</td><td>"+row[i].nombre+"</td>";
            echo+= "<tr>";
        }
        $("#bustbody").html(echo);
    });
}

function reiniciar(){
    comboCatalogo('bus','departamento',3);
    comboCatalogo('percepciones_','tipopercepcion',1);
    comboCatalogo('horasextra_','tipohoras',1);		
    comboCatalogo('deducciones_','tipodeduccion',1);
    comboCatalogo('otrospagos_','tipootropago',1);
    comboCatalogo('incapacidades_','tipoincapacidad',1);
    comboCatalogo('jubilaciones_','tipopercepcion',1);
    comboCatalogo('separaciones_','tipopercepcion',1);
    $("#tbodypercepciones").html('');
    //$("#tbodyacciones").html('');
    //$("#tbodycompensaciones").html('');
    $("#tbodydeducciones").html('');
    $("#tbodyhorasextra").html('');
    $("#tbodyincapacidades").html('');
    $("#tbodyjubilaciones").html('');
    $("#tbodyotrospagos").html('');
    $("#tbodyseparaciones").html('');
    //$("#tbodysubsidios").html('');
}

function cargar(nip){
    $("#busquedaEmpleados").modal('toggle');
    $.post("ajax/ajaxempleado.php?op=cargar", "nip="+nip, function(resp){
        var row = eval('('+resp+')');
        //Datos de pempleado
        $("#inip").val(row.nip);
        $("#trabajadorId").val( row.nip)
        
        $("#inombre").val(row.nombre);
        $("#idepartamento").val(row.departamento);
        $("#ipuesto").val(row.puesto);
        lista1('percepciones');
        //lista1('acciones');
        //lista1('compensaciones');
        lista1('deducciones');
        lista1('horasextra');
        lista1('incapacidades');
        lista1('jubilaciones');
        lista1('otrospagos');
        lista1('separaciones');
        //lista1('subsidios');
    });
}

function add(id){
    var nip = $("#inip").val();
    if(nip>0){
        var params = "id="+id+"&nip="+nip;
        $(".tab-content").find(':input').each(function() {
            var elemento= this;
            var inputid = elemento.id;
            var n = inputid.indexOf(id+"_");
            if(n!=-1){				
                var rw = inputid.split("_");
                if(this.type=='select-one')
                    params+= "&id"+rw[1]+"="+$("#"+inputid).val();
                else
                    params+= "&"+rw[1]+"="+$("#"+inputid).val();
            }
        });
        //alert(params);
        $.post("ajax/ajaxincidencias.php?op=add", params, function(resp){
            //alert(resp);
            //$("#inombre").val(resp);
            if(resp==1){
                reinicia(id);
                lista1(id);
            }
        });
    }else{
        miniNotify('error',"Debe seleccionar primero a un empleado para realizar esta accion");
    }
}

function reinicia(id){
    $(".tab-content").find(':input').each(function() {
            var elemento= this;
            var inputid = elemento.id;
            var n = inputid.indexOf(id+"_");
            if(n!=-1){				
                var rw = inputid.split("_");
                if(this.type=='select-one'){
                    comboCatalogo(id+'_',rw[1],1);
                }else{
                    $("#"+inputid).val('');
                }
            }
        });
}

function lista1(id){
    var nip = $("#inip").val();
    $.post("ajax/ajaxincidencias.php?op=lista", "id="+id+"&nip="+nip, function(resp){
        //alert(resp);
        var row = eval('('+resp+')');
        var echo = "";
        for(i in row){
            echo+= "<tr>";
            for(j in row[i]){
                if(j!='id' && j!='permisos')
                    if ( row[i][j] == 'null'  || row[i][j] == null) {
                        echo+= "	<td>No aplica</td>";
                    }
                    else{
                        echo+= "	<td>"+row[i][j]+"</td>";
                    }
            }
            if(row[i].permisos.borrar==1){
                echo+= '	<td class="td-actions" ><a href="javascript:del(\''+id+'\','+row[i].id+');" class="btn btn-danger btn-small" title="Eliminar"><i class="btn-icon-only icon-remove"> </i></a></td>';
            }else{
                echo+= '	<td></td>';
            }
            echo+= "<tr>";
        }
        $("#tbody"+id).html(echo);
        //alert(echo);
    });
}

function del(id,item){
    var params = "id="+id;
    params+= "&item="+item;
    $.post("ajax/ajaxincidencias.php?op=delete", params, function(resp){
        console.log(resp);
        if(resp==1){
            lista1(id);
        }
    });
}

function comboCatalogo(prefijo,catalogo,tipo,scatalogo,sscatalogo,ssscatalogo){
    var id = "";
    if(tipo==1){
        $.post("ajax/ajaxempleado.php?op=comboCatalogo", "catalogo="+catalogo+"&tipo="+tipo+"&prefijo="+prefijo, function(resp){
            //alert(resp);
            $("#"+prefijo+""+catalogo).html(resp);
            
            //Cargamos el subcombo
            if(typeof scatalogo != 'undefined'){
                id = $("#"+prefijo+""+catalogo).val();
                $.post("ajax/ajaxempleado.php?op=comboCatalogo", "catalogo="+catalogo+"&scatalogo="+scatalogo+"&id="+id+"&tipo="+tipo+"&prefijo="+prefijo, function(sresp){
                    $("#"+prefijo+""+scatalogo).html(sresp);
                    
                    //Cargamos el subcombo
                    if(typeof sscatalogo != 'undefined'){
                        id = $("#"+prefijo+""+scatalogo).val();
                        $.post("ajax/ajaxempleado.php?op=comboCatalogo", "catalogo="+scatalogo+"&scatalogo="+sscatalogo+"&id="+id+"&tipo="+tipo+"&prefijo="+prefijo, function(ssresp){
                            $("#"+prefijo+""+sscatalogo).html(ssresp);
                            
                            //Cargamos el subcombo
                            if(typeof ssscatalogo != 'undefined'){
                                id = $("#"+prefijo+""+sscatalogo).val();
                                $.post("ajax/ajaxempleado.php?op=comboCatalogo", "catalogo="+sscatalogo+"&scatalogo="+ssscatalogo+"&id="+id+"&tipo="+tipo+"&prefijo="+prefijo, function(sssresp){
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
            $.post("ajax/ajaxempleado.php?op=comboCatalogo", "catalogo="+catalogo+"&scatalogo="+scatalogo+"&id="+id+"&tipo="+tipo+"&prefijo="+prefijo, function(sresp){
                $("#"+prefijo+""+scatalogo).html(sresp);
                
                //Cargamos el subcombo
                if(typeof sscatalogo != 'undefined'){
                    id = $("#"+prefijo+""+scatalogo).val();
                    $.post("ajax/ajaxempleado.php?op=comboCatalogo", "catalogo="+scatalogo+"&scatalogo="+sscatalogo+"&id="+id+"&tipo="+tipo+"&prefijo="+prefijo, function(ssresp){
                        $("#"+prefijo+""+sscatalogo).html(ssresp);
                        
                        //Cargamos el subcombo
                        if(typeof ssscatalogo != 'undefined'){
                            id = $("#"+prefijo+""+sscatalogo).val();
                            $.post("ajax/ajaxempleado.php?op=comboCatalogo", "catalogo="+sscatalogo+"&scatalogo="+ssscatalogo+"&id="+id+"&tipo="+tipo+"&prefijo="+prefijo, function(sssresp){
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

function name() {
    alert( "");
}
vmDeduccion = new Vue({
    el:"#deducciones",
    data:{
        tipoDeduccion: "0001",
        fechaCargo: null,
        vencimientoCargo: "",
        importe:0,
        deduccionAuto:false,
        tipoProgramacion:"1"
        
    },
    methods:{
        addDeduccion: function () {
            let nip = $('#inip').val();
            if(nip>0){
                axios.post("ajax/ajaxincidencias.php",{
                    tipoDeduccion: this.tipoDeduccion,
                    fechaCargo:  this.fechaCargo,
                    vencimientoCargo: this.vencimientoCargo,
                    importe: this.importe,
                    deduccionAuto: this.deduccionAuto,
                    tipoProgramacion: this.tipoProgramacion,
                    op: 'addDeduccion',
                    trabajador : $('#trabajadorId').val()
                }).then( function (response) { 
                    console.log(response)
                    this.fechaCargo = null;
                    this.vencimientoCargo ="";
                    this.importe = 0;
                    this.deduccionAuto = !this.deduccionAuto;
                    inputsFecha = document.getElementsByClassName("flatpickr-input");
                    inputsFecha[0].value = '';
                    inputsFecha[1].value = '';
                    lista1( 'deducciones' );
                }).catch( function (error) {  })
            }else{
                miniNotify('error',"Debe seleccionar primero a un empleado para realizar esta accion");
            }
          },
          visibleProgramar:function () {
              this.tipoDeduccion = this.tipoDeduccion
              this.fechaCargo = this.fechaCargo
              this.vencimientoCargo = this.vencimientoCargo
              this.importe = this.importe
              this.deduccionAuto = !this.deduccionAuto
              console.log( this.fechaCargo)
            }
    }
});