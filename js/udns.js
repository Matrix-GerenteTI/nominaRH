	$(document).ready(function(e) {
		comboCatalogo('u','zona',1);
		lista('Udns');
		lista('Zonas');
    });
	
	
	function lista(id){
		if(id=='Zonas'){
			$.post("ajax/ajaxempresa.php?op=listaZonas", "", function(resp){
				//alert(resp);
				var row = eval('('+resp+')');
				var echo = "";
				var n=0;
				for(i in row){
					echo+= "<tr>";
					echo+= "	<td><input type='checkbox' id='z-"+row[i].id+"' name='z-"+row[i].id+"' /></td>";
					echo+= "	<td>"+row[i].descripcion+"</td>";
					echo+= '	<td><button class="btn btn-info" onclick="cargarZona('+row[i].id+')"><i class="mdi mdi-pencil-box-outline"></i></button></td>';
					echo+= "<tr>";
					n++;
				}
				$("#tbody"+id).html(echo);
			});	
		}
		if(id=='Udns'){
			$.post("ajax/ajaxempresa.php?op=listaUdns", "", function(resp){
				//alert(resp);
				var row = eval('('+resp+')');
				var echo = "";
				var n=0;
				for(i in row){
					echo+= "<tr>";
					echo+= "	<td><input type='checkbox' id='u-"+row[i].id+"' name='u-"+row[i].id+"' /></td>";
					echo+= "	<td>"+row[i].zona+"</td>";
					echo+= '	<td><a href="https://maps.google.com/?q='+row[i].latitud+','+row[i].longitud+'" target="_blank">'+row[i].descripcion+'</a>';
					echo+= "	<td>"+row[i].latitud+"</td>";
					echo+= "	<td>"+row[i].longitud+"</td>";
					echo+= "	<td>"+row[i].rango+"</td>";
					echo+= '	<td><button class="btn btn-info" onclick="cargar('+row[i].id+')"><i class="mdi mdi-pencil-box-outline"></i></button></td>';
					echo+= "<tr>";
					n++;
				}
				$("#tbody"+id).html(echo);
			});	
		}
	}

	function nuevoUDN(){
		$("#uid").val('');
		$("#udescripcion").val('');
		$("#uzona").val('');
		$("#ulatitud").val('');
		$("#ulongitud").val('');
		$("#urango").val('');
		comboCatalogo('u','zona',1);
	}

	function nuevoZona(){
		$("#zid").val('');
		$("#zdescripcion").val('');
	}

	function cargar(id){
		$.post("ajax/ajaxempresa.php?op=cargaUDN", "id="+id, function(resp){
			console.log(resp)
			var row = eval('('+resp+')');
			$("#uid").val(id);
			$("#udescripcion").val(row.descripcion);
			$("#uzona").val(row.zona);
			$("#ulatitud").val(row.latitud);
			$("#ulongitud").val(row.longitud);
			$("#urango").val(row.rango);
		});
	}
	
	function cargarZona(id){
		$.post("ajax/ajaxempresa.php?op=cargaZona", "id="+id, function(resp){
			console.log(resp)
			var row = eval('('+resp+')');
			$("#zid").val(id);
			$("#zdescripcion").val(row.descripcion);
		});
	}

	function guardarZona(){
		var descripcion = $("#zdescripcion").val();
		var id = $("#zid").val();
		//alert("A")
		if(descripcion.trim()!=""){
			var params = "zona=" + descripcion;
			params+= "&id=" + id;
			
			$.post("ajax/ajaxempresa.php?op=guardaZona", params, function(resp){
				//alert(resp);
				if(resp>0){
					//alert("El registro se guardo exitosamente!");
					okMsg('Listo!',"Se registro la zona exitosamente!");
					nuevoZona();
					$("#zdescripcion").val('');
					lista('Zonas');
					comboCatalogo('u','zona',1);
				}else
				errorMsg('Ups!',"Ocurrió un error, intente nuevamente. Si el problema persiste contacte a soporte");
			});
		}
	}
	
	function guardarUDN(){
		var zona = $("#uzona").val();
		var descripcion = $("#udescripcion").val();
		var zona = $("#uzona").val();
		var lat = $("#ulatitud").val();
		var long = $("#ulongitud").val();
		var rango = $("#urango").val();
		var id = $("#uid").val();
		if(descripcion.trim()!=""){
			var params = "udn=" + descripcion;
			params+= "&zona=" + zona;
			params+= "&lat=" + lat;
			params+= "&long=" + long;
			params+= "&rango=" + rango;
			params+= "&id=" + id;
			$.post("ajax/ajaxempresa.php?op=guardaUdn", params, function(resp){
				//alert(resp);
				if(resp>0){
					//alert("El registro se guardo exitosamente!");
					okMsg('Listo!',"Se registro la UDN exitosamente!");
					nuevoUDN();
					comboCatalogo('u','zona',1);
					lista('Udns');
				}else
                    errorMsg('Ups!',"Ocurrió un error, intente nuevamente. Si el problema persiste contacte a soporte");
			});
		}
	}
	
	function eliminar(prefijo,tabla){
		$("input:checkbox:checked").each(function() {
			 var id = $(this).attr('name');
			 //var arreglo = new Array();
			 if(id!='chkall'){
				 arreglo = id.split("-");
				 if(arreglo[0]==prefijo){
					
					$.post("ajax/ajaxempresa.php?op=eliminaItem", "tabla="+tabla+"&id="+arreglo[1], function(resp){
						//alert(resp);
						if(resp>0){
							okMsg('Listo!',"El registro se eliminó exitosamente!");
							if(prefijo=='u')
								lista('Udns');
							if(prefijo=='z')
								lista('Zonas');							
						}else
							errorMsg('Ups!',"Ocurrió un error, intente nuevamente. Si el problema persiste contacte a soporte");
					});
				 }
			 }
		});
	}
	
	
	function comboCatalogoS(prefijo,catalogo,valor){
		var id = "";
		$.post("ajax/ajaxempresa.php?op=comboSelected", "catalogo="+catalogo+"&valor="+valor, function(resp){
			//alert(resp);
			$("#"+prefijo+""+catalogo).html(resp);
		});
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

