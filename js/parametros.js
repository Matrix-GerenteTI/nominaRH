var camposTXT = new Array('ptolerancia_txt',
							'pretardospfalta_txt',
							'pfaltaspdescuento_txt');
	$(document).ready(function(e) {        	
		comboSucursal();
        comboDepartamento();
		carga();
	});
	
	
	function carga(){
		for(i=0;i<=6;i++){
			$("#e"+i).val('');
			$("#si"+i).val('');
			$("#ei"+i).val('');
			$("#s"+i).val('');
			$('#check'+i).attr('checked', false);
		}
		$("#ptolerancia").val("");
		$("#pretardospfalta").val("");
		$("#pfaltaspdescuento").val("");
		$("#pfaltaspdescuento").val("");
		$("#pmontodescuento").val("");
		let params = "udn="+$("#psucursal").val();
		params+= "&depto="+$("#pdepartamento").val();
		params+= "&puesto="+$("#ppuesto").val();
		params+= "&empleado="+$("#pempleado").val();
		//alert(puesto);
		$.post("ajax/ajaxparametros.php?op=carga", params, function(resp){
			console.log(resp)
			if(resp!=0){
				var row = eval('('+resp+')');
				let n = 0;
				for(i in row){
					if(n==0){
						$("#ptolerancia").val(row[i].tolerancia);
						$("#pretardospfalta").val(row[i].retardospfalta);
						$("#pfaltaspdescuento").val(row[i].faltaspdescuento);
						$("#pmontodescuento").val(row[i].montodescuento);
					}
					if(row[i].status==1)
						$('#check'+row[i].diasemana).attr('checked', true);
					else
						$('#check'+row[i].diasemana).attr('checked', false);
					$("#e"+row[i].diasemana).val(row[i].entrada);
					$("#si"+row[i].diasemana).val(row[i].salidai);
					$("#ei"+row[i].diasemana).val(row[i].entradai);
					$("#s"+row[i].diasemana).val(row[i].salida);
					n++;
				}
				
			}
		});
	}
		
	function guardar(){
		var validacion = validar(camposTXT);
						
		if(validacion == true){			
			var params = "tolerancia=" + $("#ptolerancia").val();
			params+= "&retardos=" + $("#pretardospfalta").val();
			params+= "&faltas=" + $("#pfaltaspdescuento").val();
			params+= "&monto=" + $("#pmontodescuento").val();
			params+= "&sucursal=" + $("#psucursal").val();
			params+= "&departamento=" + $("#pdepartamento").val();
			params+= "&puesto=" + $("#ppuesto").val();
			params+= "&empleado=" + $("#pempleado").val();
			
			for(i=0;i<=6;i++){
				params+= "&entrada"+i+"=" + $("#e"+i).val();
				params+= "&salidai"+i+"=" + $("#si"+i).val();
				params+= "&entradai"+i+"=" + $("#ei"+i).val();
				params+= "&salida"+i+"=" + $("#s"+i).val();
				if($('#check'+i).is(':checked')){					
					params+= "&status"+i+"=1";
				}else{
					params+= "&status"+i+"=0";
				}
			}
			console.log(params)
			$.post("ajax/ajaxparametros.php?op=guardar", params, function(resp){
				//alert(resp);
				console.log(resp)
				if(resp>0){
					notify('Listo!','success',"El registro se guardo exitosamente!");
					carga();
				}else
					notify('Ups!','error',"Ocurrió un error, intente nuevamente. Si el problema persiste contacte a soporte");
			});
		}else{
			miniNotify("warning","Llene los campos requeridos");
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

	//Ing. Manuel Alavazarez
	//ComboBox de la sucursal
	function comboSucursal()
	{
		$.post("ajax/ajaxparametros.php?op=cmbSucursal", "", function(resp){
			$("#psucursal").html(resp);
			comboEmpleado();
		});
	}

    function comboDepartamento()
	{
		$.post("ajax/ajaxparametros.php?op=cmbDepartamento", "", function(resp){
			$("#pdepartamento").html(resp);
			comboPuesto();
		});
	}

    function comboPuesto(){
        let depto = $("#pdepartamento").val();
        $.post("ajax/ajaxparametros.php?op=cmbPuesto", "iddepartamento="+depto, function(resp){
            console.log(resp)
			$("#ppuesto").html(resp);
			comboEmpleado();
            carga();
		});
    }

	function comboEmpleado()
	{
		let idsucursal = $("#psucursal").val();
        let idpuesto = $("#ppuesto").val();
		$.post("ajax/ajaxparametros.php?op=cmbEmpleado", "idsucursal="+idsucursal+"&idpuesto="+idpuesto, function(resp){
			$("#pempleado").html(resp);
            carga();
		});
	}
	
	