
	var camposTXT = new Array('erfc_txt',
							   'enombre_txt',
							   'eregistropatronal_txt',
							   'ecalle_txt',
							   'enumext_txt',
							   'enumint',
							   'ecolonia_txt',
							   'ecp_txt',
							   'emunicipio_txt',
							   'eemail',
							   'etelefono');
	$(document).ready(function(e) {
		cargaEmpresa();
		comboCatalogo('p','departamento',1);
		comboCatalogo('e','estado',1);
		lista('Deptos');
		lista('Puestos');
    });
	
	
	
	function cargaEmpresa(){
		$.post("ajax/ajaxempresa.php?op=carga", "", function(resp){
			//alert(resp);
			var row = eval('('+resp+')');
			
			reiniciaTXT(camposTXT);
			$("#erfc").val(row.rfc);
			$("#enombre").val(row.nombre_razsoc);
			$("#ecurp").val(row.curp);
			$("#eregistropatronal").val(row.registropatronal);
			$("#ecalle").val(row.calle);
			$("#enumext").val(row.numext);
			$("#enumint").val(row.numint);
			$("#ecolonia").val(row.colonia);
			$("#ecp").val(row.cp);
			comboCatalogoS('e','estado',row.estado);
			$("#emunicipio").val(row.municipio);
			$("#eemail").val(row.email);
			$("#etelefono").val(row.telefono);			
			comboCatalogoS('e','regimenfiscal',row.idregimenfiscal);
		});
	}

	function nuevoDepartamento(){
		$("#did").val('');
		$("#ddescripcion").val('');
	}

	function nuevoPuesto(){
		$("#pid").val('');
		$("#pdescripcion").val('');
		comboCatalogo('p','departamento',1);
	}
	
	function cargaDepartamento(id){
		$.post("ajax/ajaxempresa.php?op=cargaDepto", "id="+id, function(resp){
			//alert(resp);
			var row = eval('('+resp+')');
			$("#did").val(id);
			$("#ddescripcion").val(row.descripcion);
		});
	}
	
	function cargaPuesto(id){
		$.post("ajax/ajaxempresa.php?op=cargaPuesto", "id="+id, function(resp){
			//alert(resp);
			var row = eval('('+resp+')');
			$("#pid").val(id);
			$("#pdescripcion").val(row.descripcion);
			$("#pdepartamento").val(row.iddepartamento);
		});
	}
	
	function lista(id){
		if(id=='Deptos'){
			$.post("ajax/ajaxempresa.php?op=listaDeptos", "", function(resp){
				//alert(resp);
				var row = eval('('+resp+')');
				var echo = "";
				var n=0;
				for(i in row){
					echo+= "<tr style='cursor:point'>";
					echo+= "	<td><input type='checkbox' id='d-"+row[i].id+"' name='d-"+row[i].id+"' /></td>";
					echo+= "	<td style='cursor:point' onclick='cargaDepartamento("+row[i].id+")'>"+row[i].descripcion+"</td>";
					if(row[i].permiso==1)
						echo+= '	<td><button class="btn btn-info" onclick="cargaDepartamento('+row[i].id+')"><i class="mdi mdi-pencil-box-outline"></i></button></td>';
					echo+= "<tr>";
					n++;
				}
				$("#tbodyDeptos").html(echo);
			});	
		}
		if(id=='Puestos'){
			$.post("ajax/ajaxempresa.php?op=listaPuestos", "", function(resp){
				//alert(resp);
				var row = eval('('+resp+')');
				var echo = "";
				var n=0;
				for(i in row){
					echo+= "<tr>";
					echo+= "	<td><input type='checkbox' id='p-"+row[i].id+"' name='p-"+row[i].id+"' /></td>";
					echo+= "	<td style='cursor:point'>"+row[i].departamento+"</td>";
					echo+= "	<td style='cursor:point'>"+row[i].puesto+"</td>";
					if(row[i].permiso==1)
						echo+= '	<td><button class="btn btn-info" onclick="cargaPuesto('+row[i].id+')"><i class="mdi mdi-pencil-box-outline"></i></button></td>';
					echo+= "<tr>";
					n++;
				}
				$("#tbodyPuestos").html(echo);
			});	
		}
	}
	
	function guardarDepto(){
		var descripcion = $("#ddescripcion").val();
		var id = $("#did").val();
		//alert("A")
		if(descripcion.trim()!=""){
			var params = "id="+id;
			params+= "&descripcion=" + descripcion;
			
			$.post("ajax/ajaxempresa.php?op=guardaDepto", params, function(resp){
				//alert(resp);
				if(resp>0){
					//alert("El registro se guardo exitosamente!");
					$("#ddescripcion").val('');
					lista('Deptos');
					comboCatalogo('p','departamento',1);
					nuevoDepartamento();
					okMsg('Listo!','Se agregó el registro correctamente!');
				}else
					notify('Ups!','error',"Ocurrió un error, intente nuevamente. Si el problema persiste contacte a soporte");
			});
		}
	}
	
	function guardarPuesto(){
		var id = $("#pid").val();
		var descripcion = $("#pdescripcion").val();
		var departamento = $("#pdepartamento").val();
		if(descripcion.trim()!=""){
			var params = "id="+id;
			params+= "&descripcion=" + descripcion;
			params+= "&iddepartamento=" + departamento;
			$.post("ajax/ajaxempresa.php?op=guardaPuesto", params, function(resp){
				//alert(resp);
				if(resp>0){
					//alert("El registro se guardo exitosamente!");
					$("#pdescripcion").val('');
					comboCatalogo('p','departamento',1);
					nuevoPuesto();
					lista('Puestos');
					okMsg('Listo!','Se agregó el registro correctamente!');
				}else
                    notify('Ups!','error',"Ocurrió un error, intente nuevamente. Si el problema persiste contacte a soporte");
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
							notify('Listo!','success',"El registro se eliminó exitosamente!");
							if(prefijo=='d')
								lista('Deptos');
							if(prefijo=='p')
								lista('Puestos');							
						}else
                            notify('Ups!','error',"Ocurrió un error, intente nuevamente. Si el problema persiste contacte a soporte");
					});
				 }
			 }
		});
	}
	
	function guardar(){
		var validacion = validar(camposTXT);
						
		if(validacion == true){			
			var params = "rfc=" + $("#erfc").val();
			params+= "&nombre=" + $("#enombre").val();
			params+= "&curp=" + $("#ecurp").val();
			params+= "&registropatronal=" + $("#eregistropatronal").val();
			params+= "&telefono=" + $("#etelefono").val();
			params+= "&email=" + $("#eemail").val();
			params+= "&regimenfiscal=" + $("#eregimenfiscal").val();
			//Datos que se van a pdireccion
			params+= "&calle=" + $("#ecalle").val();
			params+= "&numext=" + $("#enumext").val();
			params+= "&numint=" + $("#enumint").val();
			params+= "&colonia=" + $("#ecolonia").val();
			params+= "&cp=" + $("#ecp").val();
			params+= "&estado=" + $("#eestado").val();
			params+= "&municipio=" + $("#emunicipio").val();
			
			$.post("ajax/ajaxempresa.php?op=guardar", params, function(resp){
				//alert(resp);
				if(resp>0){
					notify('Listo!','success',"El registro se guardo exitosamente!");
					cargaEmpresa();
				}else
                    notify('Ups!','error',"Ocurrió un error, intente nuevamente. Si el problema persiste contacte a soporte");
			});
		}else{
			alert("Llene los campos requeridos");
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
	
	function reiniciaTXT(campos){
		var res = true;
		for(a in campos){
			var arr = campos[a].split("_");
			//alert(arr[1]);
			if(arr[1] == "txt"){
				var campo = $("#"+arr[0]).val();
				$("#"+arr[0]).removeClass('bordeRojo');
				$("#"+arr[0]).val('');				
			}else{
				$("#"+arr[0]).val('');
			}
		}
		return res;
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

	//SCRIPTS CON VUE JS

	vmPuestos = new Vue({
		el:"#puestosSuperiores",
		data:{
			superior: -1,
			dependiente:-1,
			deptoSuperior:-1,
			deptoDependiente:-1,
			puestosSup: [],
			puestosDep: [],
			empleadoSup: [],
			empleadosuperior: -1,
			empleadodependiente: -1,
			empleadoDep: [],
			departamentos:[],
			puestosOrg: [],
			aplicacionOrg:[],
			aplicaSucursal: false,
			sucursales:-1,
			listaSucursales: []
		},
		watch:{
			aplicaSucursal: function () {  
				this.sucursales = -1;
			},
			deptoSuperior: function (id) {
				  axios.get('ajax/ajaxempresa.php',{params:{
					  departamento: id,
					  op:'listaPuestoDepartamento'
				  }}).then((result) => {
					  this.puestosSup = result.data
				  }).catch((err) => {
					  
				  });				
			},
			superior: function (id) {
				axios.get('ajax/ajaxempresa.php',{params:{
					puesto: id,
					op:'listaEmpleadoPuesto'
				}}).then((result) => {
					this.empleadoSup = result.data
				}).catch((err) => {
					 
				});
				
			},
			deptoDependiente: function (id) {
				axios.get('ajax/ajaxempresa.php',{params:{
					departamento: id,
					op:'listaPuestoDepartamento' 
				}}).then((result) => {
					this.puestosDep = result.data
				}).catch((err) => {
					
				});
			},
			dependiente: function (id) {
				axios.get('ajax/ajaxempresa.php',{params:{
					puesto: id,
					op:'listaEmpleadoPuesto'
				}}).then((result) => {
					this.empleadoDep = result.data
				}).catch((err) => {
					
				});			
			}
		},
		methods:{
			fillSucursales: function () { 
				axios.get('ajax/ajaxempresa.php',{
					params:{
						op: "listaSucursales"
					}
				}).then((result) => {
					this.listaSucursales = result.data;
				}).catch((err) => {
					
				});
			 },
			fillPuestos: function () {
				axios.get('ajax/ajaxempresa.php',{params:{
					op: 'listaPuestosOrg'
				}}).then((result) => {
					this.puestos = result.data;
					console.log(this.puestos)
				}).catch((err) => {
					
				});
			},
			fillEmpleados: function () {
				axios.get('ajax/ajaxempresa.php',{params:{
					op: 'listaEmpleadosOrg'
				}}).then((result) => {
					this.puestos = result.data;
					console.log(this.puestos)
				}).catch((err) => {
					
				});
			},
			fillDepartamento: function () { 
				axios.get('ajax/ajaxempresa.php',{params:{
					op: "listaDeptosOrg",
				}}).then((result) => {
					this.departamentos = result.data
				}).catch((err) => {
					
				});
			},
			agregar: function () { 
				axios.post('ajax/ajaxempresa.php',{
					op: "addPuestoSuperior",
					puestoDep: this.dependiente,
					dptoSup: this.deptoSuperior,
					dptoDep:this.deptoDependiente,
					puestoSup: this.superior,
					abstraccion: this.aplicacionOrg,
					sucursal: this.sucursales,
					empleadodependiente: this.empleadodependiente,
					empleadosuperior: this.empleadosuperior
				}).then((result) => {
					if ( Array.isArray( result.data) ) {
						this.puestosOrg = result.data
						okMsg('Listo!','Se agregó el registro correctamente');
					} else {
						miniNotify('warning','No se puede realizar la operación, por favor revise la relación padre-hijo');
					}
				}).catch((err) => {
					
				});

			 },
			getOrganigrama: function(){
				axios.get("ajax/ajaxempresa.php",{ params:{
					op: 'getOrganigrama'
					}
				}).then((result) => {
						this.puestosOrg = result.data					
				}).catch((err) => {
					
				});
			}
		}
	})

	vmPuestos.fillEmpleados();
	vmPuestos.fillPuestos();
	vmPuestos.fillDepartamento();
	vmPuestos.getOrganigrama();
	vmPuestos.fillSucursales();
