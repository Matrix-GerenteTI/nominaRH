    nuevo();
    var arrModulos = [];
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
		$.post("ajax/ajaxempleado.php?op=calculaTiempo", "fecha="+fecha+"&tipo=antiguedad", function(resp2){
			//alert(resp);
			$("#pantiguedadinterna").val(resp2);
		});
	}
	
	
	function nuevo(){
        $("#idusuario").val('');
        $("#usuario").val('');
		comboCatalogo('bus','tipousuario',1);	
		buslista();
        $('input:checkbox').removeAttr('checked');
        $("#tbody").html('');
	}
	
	function buscar(){
		$("#busquedaEmpleados").modal('toggle');
		buslista();
	}

    function guardar(){
        let idusuario = $("#idusuario").val();
        let nombreusuario = $("#usuario").val();
        var arrPermisos = [];
        console.log(arrModulos)
        arrModulos.forEach(function(item){
            arrPermisos[item] = {usuario:idusuario, idmodulo:item, acceso:0, guardar:0, actualizar:0, borrar:0, ver:0, imprimir:0};
            //console.log(arrPermisos[item].usuario)
            if($('#acceso_'+item).is(':checked')){					
                arrPermisos[item].acceso = 1;
            }else{
                arrPermisos[item].acceso = 0;
            }
            if($('#ver_'+item).is(':checked')){					
                arrPermisos[item].ver = 1;
            }else{
                arrPermisos[item].ver = 0;
            }
            if($('#guardar_'+item).is(':checked')){					
                arrPermisos[item].guardar = 1;
            }else{
                arrPermisos[item].guardar = 0;
            }
            if($('#actualizar_'+item).is(':checked')){					
                arrPermisos[item].actualizar = 1;
            }else{
                arrPermisos[item].actualizar = 0;
            }
            if($('#borrar_'+item).is(':checked')){					
                arrPermisos[item].borrar = 1;
            }else{
                arrPermisos[item].borrar = 0;
            }
            if($('#imprimir_'+item).is(':checked')){					
                arrPermisos[item].imprimir = 1;
            }else{
                arrPermisos[item].imprimir = 0;
            }
        })
        console.log(arrPermisos)
        $.post("ajax/ajaxempleado.php?op=guardarPermisos", "usuario="+idusuario+"&arreglo="+JSON.stringify(arrPermisos), function(resp){
			console.log(resp)
            //var row = eval('('+resp+')');
			if(resp==1)
				okMsg('Listo!','Se han actualizado los accesos y permisos del usuario');
			else
				errorMsg('Ups!','Ha ocurrido un problema al guardar los accesos y permisos');
            carga(idusuario,nombreusuario);
        })
    }

	function checkAllP(id){
		if($("#"+id).is(':checked')){
			$('.'+id+':checkbox').attr('checked','checked');
		}else{ 
			$('.'+id+':checkbox').removeAttr('checked');
		}
	}

    function carga(idusuario,nombre){
        console.log(idusuario)
        arrModulos = [];
		$("#busquedaEmpleados").modal('hide')
        $("#usuario").val(nombre);
        $("#idusuario").val(idusuario);
        $.post("ajax/ajaxempleado.php?op=cargaPermisos", "idusuario="+idusuario, function(resp){
			console.log(resp);
	  		var row = eval('('+resp+')');
			var echo = "";
			var acceso = 0;
			var ver = 0;
			var guardar = 0;
			var borrar = 0;
			var imprimir = 0;
			for(i in row){
                arrModulos.push(row[i].idmodulo);
				echo+= "<tr>";
				echo+= '	<td>'+row[i].seccion+'</td>';
				echo+= '	<td>'+row[i].modulo+'</td>';
                if(row[i].acceso==1){
					acceso++;
                    echo+= '	<td><div class="form-check"><input type="checkbox" class="form-check-input acceso" id="acceso_'+row[i].idmodulo+'" checked><label class="form-check-label" for="checkChecked"></label></div></td>';
				}else{
                    echo+= '	<td><div class="form-check"><input type="checkbox" class="form-check-input acceso" id="acceso_'+row[i].idmodulo+'"><label class="form-check-label" for="checkChecked"></label></div></td>';
				}
                if(row[i].ver==1){
					ver++;
                    echo+= '	<td><div class="form-check"><input type="checkbox" class="form-check-input ver" id="ver_'+row[i].idmodulo+'" checked><label class="form-check-label" for="checkChecked"></label></div></td>';
                }else{
                    echo+= '	<td><div class="form-check"><input type="checkbox" class="form-check-input ver" id="ver_'+row[i].idmodulo+'"><label class="form-check-label" for="checkChecked"></label></div></td>';
                }
                if(row[i].guardar==1){
					guardar++;
                    echo+= '	<td><div class="form-check"><input type="checkbox" class="form-check-input guardar" id="guardar_'+row[i].idmodulo+'" checked><label class="form-check-label" for="checkChecked"></label></div></td>';
                }else{
                    echo+= '	<td><div class="form-check"><input type="checkbox" class="form-check-input guardar" id="guardar_'+row[i].idmodulo+'"><label class="form-check-label" for="checkChecked"></label></div></td>';
				}
                // if(row[i].actualizar==1)
                //     echo+= '	<td><div class="form-check"><input type="checkbox" class="form-check-input" id="actualizar_'+row[i].idmodulo+'" checked><label class="form-check-label" for="checkChecked"></label></div></td>';
                // else
                //     echo+= '	<td><div class="form-check"><input type="checkbox" class="form-check-input" id="actualizar_'+row[i].idmodulo+'"><label class="form-check-label" for="checkChecked"></label></div></td>';
                if(row[i].borrar==1){
					borrar++;
                    echo+= '	<td><div class="form-check"><input type="checkbox" class="form-check-input borrar" id="borrar_'+row[i].idmodulo+'" checked><label class="form-check-label" for="checkChecked"></label></div></td>';
                }else{
                    echo+= '	<td><div class="form-check"><input type="checkbox" class="form-check-input borrar" id="borrar_'+row[i].idmodulo+'"><label class="form-check-label" for="checkChecked"></label></div></td>';
                }
                if(row[i].imprimir==1){
					imprimir++;
                    echo+= '	<td><div class="form-check"><input type="checkbox" class="form-check-input imprimir" id="imprimir_'+row[i].idmodulo+'" checked><label class="form-check-label" for="checkChecked"></label></div></td>';
                }else{
                    echo+= '	<td><div class="form-check"><input type="checkbox" class="form-check-input imprimir" id="imprimir_'+row[i].idmodulo+'"><label class="form-check-label" for="checkChecked"></label></div></td>';
				}
				echo+= "<tr>";
			}
			// console.log(row.length)
			// if(borrar==row.length)
			// 	$('#borrar').attr('checked','checked');
			$("#tbody").html(echo);
		});
    }
	
	function buslista(){
        let tipo = $("#bustipousuario").val();
		$.post("ajax/ajaxempleado.php?op=buslistaUsuario", "tipousuario="+tipo, function(resp){
			console.log(resp);
	  		var row = eval('('+resp+')');
			var echo = "";
			for(i in row){
				echo+= "<tr style='cursor:pointer' onClick='carga(\""+row[i].idusuario+"\",\""+row[i].nombre+"\")'>";
				echo+= "	<td>"+row[i].tipousuario+"</td><td>"+row[i].nombre+"</td>";
				echo+= "<tr>";
			}
			$("#bustbody").html(echo);
		});
	}

    function imprimir(){
		var folio = $("#folio").html();
		window.open("impIngreso.php?folio="+folio,"_blank");
		//alert("Ha ocurrido un problema con la configuracion de la impresion");	
	}
	

	function formatearFecha(fecha){
		fec = fecha.split("-");
		return fec[2]+"/"+fec[1]+"/"+fec[0];	
	}

	function formatDBDate(fecha) {
		fec = fecha.split("/");
		return fec[2]+"-"+fec[1]+"-"+fec[0];	
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