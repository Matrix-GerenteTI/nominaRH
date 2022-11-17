var camposTXT = new Array('pnip',
							   'prfc_txt',
							   'pnombre_txt',
							   'pcurp_txt',
							   'pnss',
							   'pfecnac_txt',
							   'pedad_txt',
							   'pcalle_txt',
							   'pnumext_txt',
							   'pnumint',
							   'pcolonia_txt',
							   'pcp_txt',
							   'pmunicipio_txt',
							   'ptelefono',
							   'pcelular',
							   'pemail',
							   'piniciolaboral_txt',
							   'pantiguedad_txt',
							   'pantiguedadinterna_txt',
							   'psueldobruto_txt',
							   'psalariobase_txt',
							   'psalariodiario_txt',
							   'pcuentabancaria',
							   'psubrfc',
							   'psubporcentaje',
							   'pusuario_txt',
							   'ppassword_txt',
							   'ppasswordr_txt',
							   'nHijas',
							   'nHijos',
							   'txtescolaridad',
							   'tipoSangre',
							   'alergiaMedica'
							   );
							   
	
		
		$("#pfecnac").datepicker({
			changeMonth: true,
            changeYear: true,
			showButtonPanel: true,
			yearRange: '1930:+0'
		});
		$("#piniciolaboral").datepicker({
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
		$("#dateCambioAds").datepicker({
			changeMonth: true,
            changeYear: true,
			showButtonPanel: true,
			yearRange: '1930:+0'
		});		
		
		$("#psueldobruto").keyup(function() {
			calculaSalarios();
		});

        nuevo();
	
	function $_GET(param){
		url = document.URL;
		url = String(url.match(/\?+.+/));
		url = url.replace("?", "");
		url = url.split("&");
		x = 0;
		while (x < url.length){
			p = url[x].split("=");
			if (p[0] == param){
				return decodeURIComponent(p[1]);
			}
			x++;
		}
	}
	
	function checaGET(){
		var v = $_GET("v");
		if(v=="outview"){
			cargarExpediente();
		}
	}

	function calculaSalarios(){
		let sueldobrutodiario = $("#psueldobruto").val();
		let fechainiciolaboral = $("#piniciolaboral").val();
		if(sueldobrutodiario>1 && fechainiciolaboral!=''){
			$.post("ajax/ajaxempleado.php?op=calculaSalarios", "sueldobrutodiario="+sueldobrutodiario+"&fechainiciolaboral="+fechainiciolaboral, function(resp){
				console.log(resp);
				resp = resp * 1;
				if(resp>0){
					$("#psalariobase").val(resp);
					$("#psalariodiario").val(resp);
				}
			});
		}else{
			if(fechainiciolaboral=='' || fechainiciolaboral=='00/00/0000')
				miniNotify("warning","Debe seleccionar la fecha de inicio laboral");
		}
	}
	
	function formatearFecha(fecha){
		fec = fecha.split("-");
		return fec[2]+"/"+fec[1]+"/"+fec[0];	
	}
	
	function obtenerFolio(){
		$.post("ajax/ajaxempleado.php?op=obtenerFolio", "", function(resp){
			//alert(resp);
			$("#pnip").val(resp);
		});
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
	
	function nuevo(){
		$.post("ajax/ajaxempleado.php?op=checaPermiso", "modulo=4&tipo=guardar", function(resp){

			//obtenerFolio();		
			var btnshtml = '';
			// <button type="button" class="btn btn-secondary btn-icon"><i data-feather="file" onclick="nuevo()"></i></button>
			// <button type="button" class="btn btn-success btn-icon"><i data-feather="save" onclick="guardar()"></i></button>
			// <button type="button" class="btn btn-danger btn-icon"><i data-feather="x" onclick="eliminar()"></i></button>
			btnshtml+= '<button type="button" class="btn btn-secondary btn-icon" onclick="nuevo()"><i class="mdi mdi-file-outline"></i></button> ';
			if(resp==1)
				btnshtml+= '<button type="button" class="btn btn-success btn-icon" onclick="guardar()"><i class="mdi mdi-content-save"></i></button> ';
			$("#btnshtml").html(btnshtml);
			$("#btnshtmlbottom").html(btnshtml);
			$("#takePhoto").val('');
			$("#previewfoto").attr('src', 'assets/images/person-icon.png');//intranet/assets/images/person.png
			reiniciaTXT(camposTXT);
			comboCatalogo('p','estado',1);
			comboCatalogo('p','banco',1);
			comboCatalogo('p','periodicidadpago',1);
			comboCatalogo('p','tiporegimen',1);
			comboCatalogo('p','riesgopuesto',1);
			comboCatalogo('p','tipocontrato',1);
			comboCatalogo('p','tiempocontrato',1);
			comboCatalogo('p','tipojornada',1);
			comboCatalogo('p','sucursal',1);
			comboCatalogo('p','tipodoc',1);
			comboCatalogo('p','departamento',1,'puesto');		
			comboCatalogo('bus','departamento',3);
			$("#documentos").html('');
			$("#formHijos").hide();
			buslista();
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
		var estado = $("#busestado").val();
			console.log("departamento="+departamento+"&nombre="+nombre+"&estado="+estado);
		$.post("ajax/ajaxempleado.php?op=buslista", "departamento="+departamento+"&nombre="+nombre+"&estado="+estado, function(resp){
			//alert(resp);
			console.log(resp);
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
	
	function actualizar() {
			let empleado = $("#pnip").val();
			let rfc = $("#prfc").val();
			let nombre = $("#pnombre").val();
			let curp = $("#pcurp").val();			
			let nss = $("#pnss").val();
			let nacimiento = $("#pfecnac").val(formatearFecha());
			let edoCivil =$("#pedocivil").val();
			let sexo = $("#psexo").val();
			let email = $("#pemail").val();
			let telefono = $("#ptelefono").val();
			let celular = $("#pcelular").val();
			//Datos de pdireccion
			let calle = $("#pcalle").val();
			let numCasa = $("#pnumext").val();
			let interior = $("#pnumint").val();
			let colonia = $("#pcolonia").val();
			let codPostal = $("#pcp").val();
			let municipio = $("#pmunicipio").val();
			let estado = $("#pestado").val();
			
			let username = $("#pusuario").val();			
			let password = $("#ppassword").val();			
			let tipo = $("#ptipo").val();
			
			let salarioBase =$("#psalariobase").val();
			let salarioDiario = $("#psalariodiario").val();
			let sualdoBruto = $("#psueldobruto").val();
			let cuentaBancaria =$("#pcuentabancaria").val();
			let subRfc =$("#psubrfc").val();
			let subPorcen = $("#psubporcentaje").val();			
			let sucursal = $("#psucursal").val();
			let departamento = $("#pdepartamento").val();
			let puesto = $("#ppuesto").val();
			let contrato =$("#ptipocontrato").val();
			let tiempocontrato =$("#ptiempocontrato").val();
			let inicioLab = $("#piniciolaboral").val();
			let sindicalizado = $("#psindicalizado").val();
			let regimen = $("#ptiporegimen").val();
			let riesgo = $("#priesgopuesto").val();
			let periodoPago = $("#pperiodicidadpago").val();
			let banco = $("#pbanco").val();
			let religion = $("#religion").val()
			let tieneHijos = $(".hasChild:checked").val() == 0 ? false : true;
			let nHijo = 0;
			let nHija = 0;
			if ( tieneHijos ) {
				nHijo = $("#nHijos").val();
				nHija = $("#nHijas").val();
			}
			let escolaridad  = $("#selEscolaridad").val();
			if ( escolaridad == 'OTRO') {
				escolaridad = $("#txtescolaridad").val();
			}

			let tieneSeguro = $(".hasSeguro:cheked").val();
			let tipoSangre = $("#tipoSangre").val();
			let alergias = $("#alergiaMedica").val();

			$.post("ajax/ajaxempleado.php", {
				op:  'actualizar',
				empleado: empleado,
				rfc: rfc,
				nombre:nombre,
				curp:curp,
				nss:nss,
				nacimiento:nacimiento,
				religion:religion,
				nHijo: nHijo,
				nHija: nHija,
				escolaridad: escolaridad,
				seguro: tieneSeguro,
				tipoSangre: tipoSangre,
				alergias: alergias,
				edoCivil: edoCivil,
				sexo:sexo,
				email:email,
				telefono:telefono,
				celular:celular,
				calle:calle,
				numCasa:numCasa,
				interior:interior,
				colonia:colonia,
				codPostal:codPostal,
				municipio: municipio,
				estado:estado,
				username:username,
				password:password,
				tipo:tipo,
				inicioLabores: inicioLab,
				salarioBase:salarioBase,
				salarioDiario:salarioDiario,
				sueldoBruto:sueldoBruto,
				cuenta:cuentaBancaria,
				subRfc:subRfc,
				subPorcen: subPorcen,
				sucursal: sucursal,
				departamento:departamento,
				puesto:puesto,
				contrato:contrato,
				tiempocontrato:tiempocontrato,
				sindicalizado:sindicalizado,
				regimen:regimen,
				riesgo:riesgo,
				periodoPago:periodoPago,
				banco: banco
			},
				function (data, textStatus, jqXHR) {
					
				},
				"text"
			);

	}
	
//para cuando cambie el select de nivel de estudios y seleccione otro, muestra el input
$("#selEscolaridad").change(function (e) { 
	if ( $( this).val() == 'OTRO' ){
		$("#otrosEstudios").fadeIn();
	}else{
		$("#otrosEstudios").fadeOut();
		$("#txtescolaridad").val("");
	}
	
});

//Para cuando cambian el radio de tiene hijos muestra el desgloce para  indicar el numeo de hijos en caso de que elija SI
$(".hasChild").change(function (e) { 
	if ( $(this).val() == 0 ) {
		$("#formHijos").fadeOut();
		$("#nHijas").val('');
		$("#nHijos").val('');
	} else {
		$("#formHijos").fadeIn();
	}
	
});

$("#busnombre").keyup(function(e){
	let texto = $(this).val();
	console.log(texto)
	buslista();
});

	function loadmodal(nip){
		$("#busquedaEmpleados").modal('toggle');
		cargar(nip);
		
	}

	//cuando den clic en la imagen abrirá el buscador de archivos para actualizarla en el servidor
	$("#previewfoto").click(function (e) { 
		e.preventDefault();
		const idEmpleado = $("#pnip").val();
		if ( idEmpleado != '') {
			$("#takePhoto").click();
		} else {			
			miniNotify("warning","Debe seleccionar primero un empleado");
		}
		
	});

	function subeFoto(){
		const idEmpleado = $("#pnip").val();
		var oFReader = new FileReader();
		oFReader.readAsDataURL(document.getElementById("takePhoto").files[0]);

		oFReader.onload = function (oFREvent) {
			
			document.getElementById("previewfoto").src = oFREvent.target.result;
			//Guardando en  el servidor la imagen del empleado
			let fotoIn = document.getElementById("takePhoto");
			let foto = fotoIn.files[0];
			let data = new FormData();
			data.append("foto", foto);
			data.append('nip', idEmpleado);
			AlertUploadingImage('Cargando Imagen','Esto puede tardar unos segundos...');
			$.ajax({
			url:"ajax/uploadFoto.php",
			type:'POST',
			contentType:false,
			data:data,
			processData:false,
			cache:false}).done(function(resp1){		
				Swal.close();
				if ( resp1 == 1) {						
					//$("#previewfoto").attr('src', '');
					okMsg('Listo!',"El registro se guardo exitosamente!");
					$("#takePhoto").val('');
					nuevo();
					//okMsg('Fotografía guardada!','');
					//miniNotify('success','Fotografía guardada correctamente!');
				} else {							
					errorMsg('No se pudo guardar la foto!','');
					//miniNotify('error','No se pudo guardar la foto!');
				}
			});

		};
	}

	$("#takePhoto").change(function() {
		var oFReader = new FileReader();
		oFReader.readAsDataURL(document.getElementById("takePhoto").files[0]);
		oFReader.onload = function (oFREvent) {			
			document.getElementById("previewfoto").src = oFREvent.target.result;
		}
    });


	function cargar(nip){
		$("#previewfoto").attr('src', 'assets/images/loadimg.gif');
		reiniciaTXT(camposTXT);
		$.post("ajax/ajaxempleado.php?op=cargar", "nip="+nip, function(resp){
			console.log(resp);
			$(".btn-guarda").attr('href','javascript:actualizar();')
			var row = eval('('+resp+')');
			//Habilitamos o no el botón de reingreso o baja
			var btnshtml = '';
			console.log(row.permisos)
			// <button type="button" class="btn btn-secondary btn-icon"><i data-feather="file" onclick="nuevo()"></i></button>
			// <button type="button" class="btn btn-success btn-icon"><i data-feather="save" onclick="guardar()"></i></button>
			// <button type="button" class="btn btn-danger btn-icon"><i data-feather="x" onclick="eliminar()"></i></button>
			if(row.status==1){
				btnshtml+= '<button type="button" class="btn btn-secondary btn-icon" onclick="nuevo()"><i class="mdi mdi-file-outline"></i></button> ';
				if(row.permisos.guardar==1){
					btnshtml+= '<button type="button" class="btn btn-success btn-icon" onclick="guardar()"><i class="mdi mdi-content-save"></i></button> ';
				}
				if(row.permisos.borrar==1){
					btnshtml+= '<button type="button" class="btn btn-danger btn-icon" onclick="eliminar()"><i class="mdi mdi-logout"></i></button> ';
				}
			}else{
				btnshtml+= '<button type="button" class="btn btn-secondary btn-icon" onclick="nuevo()"><i class="mdi mdi-file-outline"></i></button> ';
				if(row.permisos.guardar==1){
					btnshtml+= '<button type="button" class="btn btn-success btn-icon" onclick="guardar()"><i class="mdi mdi-content-save"></i></button> ';
					btnshtml+= '<button type="button" class="btn btn-info btn-icon" onclick="reingreso()"><i class="mdi mdi-login"></i></button> ';
				}
			}
			$("#btnshtml").html(btnshtml);
			$("#btnshtmlbottom").html(btnshtml);			

			//Datos de pempleado
			$("#pnip").val(row.nip);
			$("#prfc").val(row.rfc);
			$("#pnombre").val(row.nombre);
			$("#pcurp").val(row.curp);			
			$("#pnss").val(row.nss);
			$("#pfecnac").val(formatearFecha(row.fechanac));
			calculaTiempo('pfecnac','pedad','edad');
			$("#pedocivil").val(row.edocivil);
			$("#psexo").val(row.sexo);
			$("#pemail").val(row.email);
			$("#ptelefono").val(row.telefono);
			$("#pcelular").val(row.celular);
			$("#previewfoto").attr('src', row.foto);//intranet/assets/images/person.png
			//Datos  de sangre, escolaridad y familia
				$("#religion").val( row.religion);
				let hijos = (row.numhijos).split("-");
				if ( hijos[0] != 0 || hijos[1] != 0) {
					$(".hasChild[value=1]").attr( 'checked' , true );
					$("#formHijos").fadeIn();
					$("#nHijas").val( hijos[1] );
					$("#nHijos").val( hijos[0] );
				}else{
					$(".hasChild[value=0]").attr( 'checked' , true );
					$("#formHijos").fadeOut();
					$("#nHijas").val( '0' );
					$("#nHijos").val('0');
				}
				const escolaridades = ['NINGUNO','PRIMARIA','SECUNDARIA','PREPARATORIA','LICENCIATURA','MAESTRIA','DOCTORADO','´POSGRADO'];
				if ( escolaridades.includes( row.nivelestudios) ) {
					$(`#selEscolaridad option[value="${row.nivelestudios}"]`).prop('selected', true);
					$("#otrosEstudios").fadeOut();
				}else{
					$(`#selEscolaridad option[value="OTRO"]`).prop('selected', true);
					$("#otrosEstudios").fadeIn();
					$("#txtescolaridad").val( row.nivelestudios);
				}
				if ( row.asegurado == 's') {
					$(".hasSeguro[value=1]").attr( 'checked' , true );
				} else {
					$(".hasSeguro[value=0]").attr( 'checked' , true );
				}

				$("#tipoSangre").val( row.tiposangre);
				$("#alergiaMedica").val( row.alergias);

			//Datos de pdireccion
			$("#pcalle").val(row.calle);
			$("#pnumext").val(row.numext);
			$("#pnumint").val(row.numint);
			$("#pcolonia").val(row.colonia);
			$("#pcp").val(row.cp);
			comboCatalogoS('p','estado',row.estado);
			$("#pmunicipio").val(row.municipio);
			//Datos de pcontrato
			comboCatalogoS('p','sucursal',row.idsucursal);
			comboCatalogoS('p','departamento',row.iddepartamento);
			comboCatalogoS('p','puesto',row.idpuesto,'departamento',row.iddepartamento);
			comboCatalogoS('p','tipocontrato',row.idtipocontrato);
			comboCatalogoS('p','tiempocontrato',row.idtiempocontrato);
			comboCatalogoS('p','tipojornada',row.idtipojornada);
			comboCatalogoS('p','tiporegimen',row.idtiporegimen);
			comboCatalogoS('p','riesgopuesto',row.idriesgopuesto);
			comboCatalogoS('p','periodicidadpago',row.idperiodicidadpago);
			comboCatalogoS('p','banco',row.idbanco);
			$("#piniciolaboral").val(formatearFecha(row.fechainiciolab));
			calculaTiempo('piniciolaboral','pantiguedad','antiguedadSAT');
			$("#psalariobase").val(row.salariobase);
			$("#psalariodiario").val(row.salariodiario);
			$("#psueldobruto").val(row.sueldobruto);
			$("#pcuentabancaria").val(row.cuentabancaria);
			$("#psubrfc").val(row.subrfc);
			$("#psubporcentaje").val(row.subporcentaje);
			$("#pusuario").val(row.username);
			$("#ppassword").val(row.password);
			$("#ppasswordr").val(row.password);			
			$("#ptipo").val(row.tipo);
			getDoctos();
		});
	}
	
	function eliminar(){
		confirmy('Baja de empleado','question','¿Desea dar de baja al empleado?','Si','No','modalBaja','','confirmEliminar','');
	}

	function modalBaja(params){
		$("#modBajaPersonal").modal('show');
	}

	function confirmEliminar(params){
		var folio = $("#pnip").val();
		var params = "nip="+folio;
		confirmy('Eliminar empleado','question','¿Desea eliminar el registro del empleado?','Si','No','bajasPersonal',params)
	}

	function reingreso(){
		var folio = $("#pnip").val();	
		let salario = $("#psalariodiario").val();		
		let sucursal = $("#psucursal").val();
		let departamento = $("#pdepartamento").val();
		let puesto = $("#ppuesto").val();	
		let inicioLab = $("#piniciolaboral").val();
		let salarioBase =$("#psalariobase").val();
		let sueldobruto =$("#psueldobruto").val();
		let cuentaBancaria =$("#pcuentabancaria").val();
		let subRfc =$("#psubrfc").val();
		let subPorcen = $("#psubporcentaje").val();	
		let contrato =$("#ptipocontrato").val();
		let tiempocontrato =$("#ptiempocontrato").val();
		let sindicalizado = $("#psindicalizado").val();
		let regimen = $("#ptiporegimen").val();
		let riesgo = $("#priesgopuesto").val();
		let periodoPago = $("#pperiodicidadpago").val();
		let banco = $("#pbanco").val();
		let params = "nip="+folio;
		params+= "&salariodiario="+salario;
		params+= "&sucursal="+sucursal;
		params+= "&departamento="+departamento;
		params+= "&puesto="+puesto;
		params+= "&iniciolaboral="+inicioLab;
		params+= "&sueldobruto="+sueldobruto;
		params+= "&salariobase="+salarioBase;
		params+= "&cuentabancaria="+cuentaBancaria;
		params+= "&subrfc="+subRfc;
		params+= "&subporcentaje="+subPorcen;
		params+= "&tipocontrato="+contrato;
		params+= "&tiempocontrato="+tiempocontrato;
		params+= "&sindicalizado="+sindicalizado;
		params+= "&tiporegimen="+regimen;
		params+= "&riesgopuesto="+riesgo;
		params+= "&periodicidadpago="+periodoPago;
		params+= "&banco="+banco;
		confirmy('Reingreso de empleado','question','¿Desea registrar el reingreso del empleado No.'+folio+'?','Si','No','reingresadoOk',params);
	}

	function reingresadoOk(params){
		$.post("ajax/ajaxempleado.php?op=reingreso", params, function(resp){	
			if(resp==1){
				okMsg('Listo!',"El empleado se reingresó correctamente!");
			}
			if(resp==0){
				errorMsg('Ups!',"Ocurrió un error, intente nuevamente. Si el problema persiste contacte a soporte");
			}
		});	
	}
	
	$("#btnBajaPersonal").click(function (e) { 
		let fecha = $("#dateBajaPersonal").val();
		let folio = $("#pnip").val();
		let txtobservaciones = $("#txtBajaPersonal").val();
		
		if ( fecha != '') {
			fecha = formatDBDate( fecha );
			$.post("/nomina/ajax/ajaxempleado.php", {
				op: 'baja',
				empleado: folio,
				fecha: fecha,
				tipo: 'baja',
				observaciones: txtobservaciones
			},
				function (data, textStatus, jqXHR) {
					console.log(data)
					if ( data == 1) {
						okMsg('Listo!',"Personal dado de baja correctamente.");
						nuevo();
					} else {
						errorMsg('Ups!',"No se pudo realizar la baja del trabajador.");
					}
					$("#modBajaPersonal").modal('hide');
					$("#dateBajaPersonal").val('');
				},
				"text"
			);				
		}
		
	});
	
	function bajasPersonal(params) {
		$.post("ajax/ajaxempleado.php?op=eliminar", params, function(resp){
	
				if(resp==1){
					okMsg('Listo!',"El empleado se desactivo correctamente!");
					nuevo();					
				}
				if(resp==0){
					errorMsg('Ups!',"Ocurrió un error, intente nuevamente. Si el problema persiste contacte a soporte");
				}
			});	
	}
	
	function existuser(){
		$.post("ajax/ajaxempleado.php?op=existuser", "username="+$("#pusuario").val()+"&nip="+$("#pnip").val(), function(resp){
			//alert(resp);
			if(resp==1)
				return true;
			else
				return false;
		});
	}

	function guardar(){
		$.post("ajax/ajaxempleado.php?op=existuser", "username="+$("#pusuario").val()+"&nip="+$("#pnip").val(), function(resp){
			//alert(resp);
			if(resp!=1){
				miniNotify('error',"El nombre de usuario que intenta registrar ya existe!");
				return false;
			}
		});
		var foto = $("#takePhoto").val();
		//$("#takePhoto").val('');
		var validacion = validar(camposTXT);
		var pass1 = $("#ppassword").val();
		var pass2 = $("#ppasswordr").val();
		if(validacion == true && pass1==pass2){			
			var params = "nip=" + $("#pnip").val();
			//Datos que se van a pempleado
			params+= "&rfc=" + $("#prfc").val();
			params+= "&nombre=" + $("#pnombre").val();			
			params+= "&curp=" + $("#pcurp").val();
			params+= "&nss=" + $("#pnss").val();
			params+= "&fecnac=" + $("#pfecnac").val();
			params+= "&edocivil=" + $("#pedocivil").val();
			params+= "&sexo=" + $("#psexo").val();
			params+= "&telefono=" + $("#ptelefono").val();
			params+= "&celular=" + $("#pcelular").val();
			params+= "&email=" + $("#pemail").val();
			//Datos que se van a pdireccion
			params+= "&calle=" + $("#pcalle").val();
			params+= "&numext=" + $("#pnumext").val();
			params+= "&numint=" + $("#pnumint").val();
			params+= "&colonia=" + $("#pcolonia").val();
			params+= "&cp=" + $("#pcp").val();
			params+= "&estado=" + $("#pestado").val();
			params+= "&municipio=" + $("#pmunicipio").val();
			//Datos de usuario
			params+= "&username=" + $("#pusuario").val();
			params+= "&password=" + $("#ppassword").val();
			params+= "&tipo=" + $("#ptipo").val();
			//Datos que se van a pcontrato
			params+= "&sucursal=" + $("#psucursal").val();
			params+= "&departamento=" + $("#pdepartamento").val();
			params+= "&puesto=" + $("#ppuesto").val();
			params+= "&tipocontrato=" + $("#ptipocontrato").val();
			params+= "&tiempocontrato=" + $("#ptiempocontrato").val();
			params+= "&tipojornada=" + $("#ptipojornada").val();
			params+= "&iniciolaboral=" + $("#piniciolaboral").val();
			params+= "&sindicalizado=" + $("#psindicalizado").val();
			params+= "&tiporegimen=" + $("#ptiporegimen").val();
			params+= "&riesgopuesto=" + $("#priesgopuesto").val();
			params+= "&periodicidadpago=" + $("#pperiodicidadpago").val();
			params+= "&sueldobruto=" + $("#psueldobruto").val();
			params+= "&salariobase=" + $("#psalariobase").val();
			params+= "&salariodiario=" + $("#psalariodiario").val();
			params+= "&banco=" + $("#pbanco").val();
			params+= "&cuentabancaria=" + $("#pcuentabancaria").val();
			params+= "&subrfc=" + $("#psubrfc").val();
			params+= "&subporcentaje=" + $("#psubporcentaje").val();
			let religion = $("#religion").val()
			let tieneHijos = $(".hasChild:checked").val() == 0 ? false : true;
			let nHijo = 0;
			let nHija = 0;
			if ( tieneHijos ) {
				nHijo = $("#nHijos").val();
				nHija = $("#nHijas").val();
			}
			let escolaridad  = $("#selEscolaridad").val();
			if ( escolaridad == 'OTRO') {
				escolaridad = $("#txtescolaridad").val();
			}

			let tieneSeguro = $(".hasSeguro:checked").val();
			let tipoSangre = $("#tipoSangre").val();
			let alergias = $("#alergiaMedica").val();
			params += `&religion=${religion}&nHijo=${nHijo}&nHija=${nHija}&escolaridad=${escolaridad}&seguro=${tieneSeguro}&tipoSangre=${tipoSangre}&alergias=${alergias}`;

			
			$.post("ajax/ajaxempleado.php?op=guardar", params, function(resp){
				console.log(resp);
				if(resp>0){
					if(foto.length>4){
						subeFoto();
					}else{
						nuevo();
						okMsg('Listo!',"El registro se guardo exitosamente!");
					}
					//cargar(resp);
					//$("#busquedaEmpleados").modal('toggle');
				}else{
					if(resp==-1){
                        errorMsg('Ups!',"El nombre de usuario ya existe en otras conexiones, intente con otro");
					}else{
                     	errorMsg('Ups!',"Ocurrió un error, intente nuevamente. Si el problema persiste contacte a soporte");
					}
				}
			});
		}else{
			if(pass1!=pass2)
				miniNotify('error',"Las contraseñas de usuario no coinciden. Vuelva a escribirlas.");
			else
				miniNotify('error',"Llene los campos requeridos");
		}
	}
	
	function printContrato() {			
		var idempleado = $("#pnip").val();
		if(idempleado>0){
			$.get("/nomina/ajax/controladores/formateria/contrato.php", {
				empleado : idempleado
			},
				function (data, textStatus, jqXHR) {
				console.log(data);
					window.open(data, "_blank");
				},
				"text"
			);
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
	
	function imprimir(){
		var folio = $("#folio").html();
		window.open("impIngreso.php?folio="+folio,"_blank");
		//alert("Ha ocurrido un problema con la configuracion de la impresion");	
	}
	
	function comboCatalogoS(prefijo,catalogo,valor,padre,valorpadre){
		var id = "";
		if(typeof padre != 'undefined'){
			$.post("ajax/ajaxempresa.php?op=comboSelected", "catalogo="+catalogo+"&valor="+valor+"&padre="+padre+"&valorpadre="+valorpadre, function(resp){
				//alert(resp);
				$("#"+prefijo+""+catalogo).html(resp);
			});
		}else{
			$.post("ajax/ajaxempresa.php?op=comboSelected", "catalogo="+catalogo+"&valor="+valor, function(resp){
				//alert(resp);
				$("#"+prefijo+""+catalogo).html(resp);
			});
		}
	}
	
	// Scripts extras agregados 07.01.19
	$("#actAdscripcion").click(function (e) { 

		$("#modCambioAdscripcion").modal('show');
	});

	$("#btnCambiaAds").click(function (e) { 
		let sucursal = $("#psucursal").val();
		let departamento = $("#pdepartamento").val();
		let puesto = $("#ppuesto").val();
		let nip = $("#pnip").val();
		let fecha =  $("#dateCambioAds").val();

		$.post("/nomina/ajax/ajaxempleado.php", {
			op: 'updateAdscripcion',
			sucursal: sucursal,
			departamento:  departamento,
			puesto: puesto,
			empleado: nip,
			fecha: fecha,
			tipo:'cambioAdscrip'
		},
			function (data, textStatus, jqXHR) {
				if ( data == 1) {
					okMsg('Listo!',"Cambio de adscripción realizada");
				} else if( data == 0 ) {
					errorMsg('Ups!',"No se pudo efectuar el cambio, por favor intente nuevamete.")
				}else if( data == -1){
					notify('Atención!','warning',"Cambio realizado correctamente, pero no se guardó el cambio de adscripción en el historial");
				}else{
					errorMsg('Ups!',"Ocurrió un error interno en el servido, por favor contacte al personal encargado");
				}
				$("#modCambioAdscripcion").modal('hide');
			},
			"text"
		);
		
	});
	// Fin scripts 07.01.19
	
	function getDoctos(){
		//alert("Entra");
		var nip = $("#pnip").val();
		//alert("marca="+marca+"&linea="+modelo+"&modelo="+anio+"&sucursal="+sucursal);
		$.post("ajax/ajaxempleado.php?op=getDoctos", "nip="+nip, function(resp){
			//alert(resp);
			$("#documentos").html(resp);
		});
	}

	function delImg(id){
		confirmy('Eliminar documento','question','¿Esta seguro de eliminar el documento?','Si','No','delDocto',id);
	}

	function delDocto(id){
		$.post("ajax/ajaxempleado.php?op=deldocto", "id="+id, function(resp){
			//alert(resp);
			getDoctos()
		});
	}
	
	function subirDoc(){
		var tipo = $("#ptipodoc").val();
		var nip = $("#pnip").val();
		if(nip>0){
			var inputFileImage = document.getElementById("parchivo");
			var file = inputFileImage.files[0];
			var data = new FormData();
			data.append('archivo',file);
			data.append('tipo',tipo);
			data.append('nip',nip);
			var url = "ajax/uploadDocto.php";
			AlertUploadingDoc('Cargando Documento','Esto puede tardar unos segundos...')
			$.ajax({
				url:url,
				type:'POST',
				contentType:false,
				data:data,
				processData:false,
				cache:false}).done(function(resp1){		
					console.log(resp1);
					Swal.close();
					if ( resp1 == 1) {						
						okMsg('Documento cargado!','');
						//miniNotify('success','Fotografía guardada correctamente!');
					} else {							
						errorMsg('No se pudo guardar el documento!','');
						//miniNotify('error','No se pudo guardar la foto!');
					}
					getDoctos();
				});
		}else{
			miniNotify("warning","Debe seleccionar primero un empleado");
		}
	}

	function formatearFecha(fecha){
		fec = fecha.split("-");
		return fec[2]+"/"+fec[1]+"/"+fec[0];	
	}

	function formatDBDate(fecha) {
		fec = fecha.split("/");
		return fec[2]+"-"+fec[1]+"-"+fec[0];	
	}
	