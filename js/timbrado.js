var camposTXT = new Array('tfechainicial_txt',
							   'tfechafinal_txt',
							   'tfechapago_txt',
							   'tdiaspagados_txt');
							   
	$(document).ready(function(e) {
		
		$("#tfechafinal").datepicker({
			changeMonth: true,
            changeYear: true,
			showButtonPanel: true,
			yearRange: '1930:+0'
		});
		$("#tfechainicial").datepicker({
			changeMonth: true,
            changeYear: true,
			showButtonPanel: true,
			yearRange: '1930:+0'
		});
		$("#tfechafinal").datepicker({
			changeMonth: true,
            changeYear: true,
			showButtonPanel: true,
			yearRange: '1930:+0'
		});
		$("#tfechapago").datepicker({
			changeMonth: true,
            changeYear: true,
			showButtonPanel: true,
			yearRange: '1930:+0'
		});

		$("#dateBajaPersonal").datepicker({
			changeMonth: true,
            changeYear: true,
			showButtonPanel: true,
			yearRange: '1930:+0'
		});

		$('#chkall').click(function() {
			var c = this.checked;
			$(':checkbox').prop('checked',c);
		});
        nuevo();
    });
	
	function nuevo(){
		comboCatalogo('bus','departamento',3);
		comboCatalogo('t','tiponomina',1);
		cmbNomina();
	}

	function seleccionaNomina(){
		let fechas = $("#tnomina").val();
		if(fechas!=''){
			let arrfechas = fechas.split('_');
			$("#tfechainicial").val(arrfechas[0]);
			$("#tfechafinal").val(arrfechas[1]);
			console.log(arrfechas[0]+'_'+arrfechas[1])
			$.post("ajax/ajaxtimbrado.php?op=dias", "fechaIni="+arrfechas[0]+"&fechaFin="+arrfechas[1], function(resp){
				//alert(resp);
				$("#tdiaspagados").val(resp);
			});
		}else{
			$("#tfechainicial").val('');
			$("#tfechafinal").val('');
			$("#tdiaspagados").val('');
		}
	}
	
	function buscar(){
		buslista();
	}

	function cmbNomina(){
		$.post("ajax/ajaxtimbrado.php?op=cmbNomina", "", function(resp){
			//alert(resp);
			$("#tnomina").html(resp);
		});
	}
	
	function buslista(){
		var departamento = $("#busdepartamento").val();
		var nombre = $("#busnombre").val();
		$.post("ajax/ajaxtimbrado.php?op=buslistaTimbrado", "departamento="+departamento+"&nombre="+nombre, function(resp){
			//alert(resp);
	  		var row = eval('('+resp+')');
			var echo = "";
			for(i in row){
				if(row[i].estado=='listo'){
					echo+= "<tr style='cursor:pointer'>";
					echo+= "	<td><div id='divchk"+row[i].idcontrato+"'><input type='checkbox' id='chk"+row[i].idcontrato+"' name='"+row[i].idcontrato+"' /></div></td><td>"+row[i].departamento+"</td><td>"+row[i].nombre+"</td><td style='text-align:center'><div id='ico"+row[i].idcontrato+"'><span class='shortcut-icon icon-ellipsis-horizontal'></span></div></td>";
					echo += `<td onclick="setNipEliminar(${row[i].nip})"><span class="shortcut-icon  icon-eraser"></span> </td>`;
					echo+= "<tr>";
				}else{
					echo+= "<tr style='cursor:pointer'>";
					echo+= "	<td><div id='divchk"+row[i].idcontrato+"'></div></td><td>"+row[i].departamento+"</td><td>"+row[i].nombre+"</td><td style='text-align:center'><div id='ico"+row[i].idcontrato+"'><span class='shortcut-icon icon-exclamation-triangle'></span></div></td>";
					echo += `<td onclick="setNipEliminar(${row[i].nip})"><span class="shortcut-icon  icon-eraser"></span> </td>`;
					echo+= "<tr>";
				}
			}
			$("#tbody").html(echo);
		});
	}
	
	function setNipEliminar( nip ) {
		$("#pnip").val( nip );
		$("#modBajaPersonal").modal('show');
	}

	function timbrar(){
		var nt = 0;
		$("input:checkbox:checked").each(function() {
				 var id = $(this).attr('name');
				 if(id!='chkall'){
					 nt++;
				 }
		});
		
		if(nt>0){
			var validacion = validar(camposTXT);
			if(validacion == true){
				var ids = '';
				$("input:checkbox:checked").each(function() {
					 var id = $(this).attr('name');
					 if(id!='chkall'){
						 var params = "idcontrato="+id;
						 params+= "&tiponomina="+$("#ttiponomina").val();
						 params+= "&fechainicial="+$("#tfechainicial").val();
						 params+= "&fechafinal="+$("#tfechafinal").val();
						 params+= "&diaspagados="+$("#tdiaspagados").val();
						 params+= "&fechapago="+$("#tfechapago").val();
						 params+= "&uuidanterior="+$("#tuuid").val();
						 $("#ico"+id).html('<img src="loading.gif" width="17px" heigth="17px" />');
						 $.post("ajax/ajaxtimbrado.php?op=timbrar", params, function(resp){
							//alert(resp);
							
							var row = eval('('+resp+')');
							if(row.status==0){
								$("#ico"+id).html("<span class='shortcut-icon icon-ok'></span>");
								$("#divchk"+id).html("");
								ids+= row.serie+'|'+row.folio+',';
							}else{
								alert(row.mensaje);
								$("#ico"+id).html("<span class='shortcut-icon icon-exclamation-triangle'></span>");
							}						
						 });
					 }
				});
				if(ids!=''){
					ids = ids.slice(0,-1);
					window.open("ajax/generaPDF.php?ids="+ids,"_blank");
				}
			}
		}else{
			alert("Seleccione al menos un empleado para timbrar");
		}
	}
	
	function imprimir(){
		var ids = '';
		$("input:checkbox:checked").each(function() {
			 var id = $(this).attr('name');
			 if(id!='chkall'){				 
				ids+= id+',';
			 }
		});
		if(ids!=''){
			ids = ids.slice(0,-1);
			var params = "ids="+ids;
			params+= "&idtiponomina="+$("#ttiponomina").val();
			params+= "&fechaIni="+$("#tfechainicial").val();
			params+= "&fechaFin="+$("#tfechafinal").val();
			params+= "&diasPagados="+$("#tdiaspagados").val();
			params+= "&fechaPago="+$("#tfechapago").val();
			params+= "&uuidanterior="+$("#tuuid").val();
			window.open("ajax/pregeneraPDF.php?"+params,"_blank");
		}
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
	
	function eliminar(){
		var folio = $("#folio").html();
		if(confirm("¿Desea eliminar el expediente No."+folio+"?")){
			var params = "folio="+folio;
			$.post("ajax/ajaxempleado.php?op=eliminar", params, function(resp){
				if(resp==1){
					alert("El expediente se elimino exitosamente!");
					nuevo();					
				}
				if(resp==0){
					alert("Ocurrió un error, intente nuevamente. Si el problema persiste contacte a soporte");
				}
			});	
		}
	}
	
	function validar(campos){
		var res = true;
		for(a in campos){
			var arr = campos[a].split("_");
			//alert(arr[1]);
			if(arr[1] == "txt"){
				var campo = $("#"+arr[0]).val();
				if(campo==""){
					 $("#"+arr[0]).addClass('bordeRojo');
					 res = false;
				}else{
					 $("#"+arr[0]).removeClass('bordeRojo');
				}
			}
		}
		return res;
	}
	
	$("#btnBajaPersonal").click(function (e) { 
		let fecha = $("#dateBajaPersonal").val();
		let folio = $("#pnip").val();
		if ( fecha != '') {
			fecha = formatDBDate( fecha );
			$.post("/nomina/ajax/ajaxempleado.php", {
				op: 'baja',
				empleado: folio,
				fecha: fecha
			},
				function (data, textStatus, jqXHR) {
					if ( data == 1) {
						alert("Personal dado de baja correctamente.");
						buslista();
					} else {
						alert("No se pudo realizar la baja del trabajador.");
					}
					$("#modBajaPersonal").modal('hide');
					$("#dateBajaPersonal").val('');
				},
				"text"
			);				
		}
		
	});

	function formatDBDate(fecha) {
		fec = fecha.split("/");
		return fec[2]+"-"+fec[1]+"-"+fec[0];	
	}

	$.get("ajax/ajaxincidencias.php", {op: 'actualizaAutomatico'},
		function (data, textStatus, jqXHR) {
			
		},
		"text"
	);