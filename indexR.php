<?php
	require_once("ajax/control.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Sistema para Timbrado de N&oacute;mina</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap-responsive.min.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600"
        rel="stylesheet">
<link href="css/font-awesome.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<link href="css/pages/dashboard.css" rel="stylesheet">
<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
</head>
<body>
	<!--  Modal para baja con registro de fecha del empleado -->
<div id="modBajaPersonal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Bajas de empleados</h4>
      </div>
      <div class="modal-body">
	  	<div style="width:50%; margin-left:25%;">
			<div class="form-group">
				<input type="hidden" id="pnip">
			  	<label for="">Fecha de Baja</label>
				  <input type="text" id="dateBajaPersonal">
			  </div>
		  </div>
	  </div>
      <div class="modal-footer">
		<button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
		<button type="button" class="btn btn-default" id="btnBajaPersonal">Confirmar</button>
      </div>
    </div>
  </div>
</div>



<?php require_once('header.php'); ?>
<!-- /navbar -->
<?php require_once('menu.php'); ?>
<!-- /subnavbar -->
<div class="main">
  <div class="main-inner">
    <div class="container">
      <div class="row">
        <div class="span12">
          <div class="widget widget-nopad">
            <div class="form-actions" style="margin-top:0px; margin-bottom:0px; padding:5px">
            	<table width="100%" cellpadding="0" cellspacing="0">
                	<tr>
						<td width="75px">
							
						</td>
                    	<td>
							<table align="right" cellpadding="0" cellspacing="0">
								<tr>
									<td>
										<div class="shortcuts"> 
											
											<a href="javascript:timbrar();" class="shortcut"><i class="shortcut-icon icon-file-code-o"></i><span class="shortcut-label">Timbrar</span></a>&nbsp;
											<!--<a href="javascript:enviar();" class="shortcut"><i class="shortcut-icon icon-envelope-o"></i><span class="shortcut-label">Enviar</span></a>&nbsp;-->
											<a href="javascript:imprimir();" class="shortcut"><i class="shortcut-icon icon-print"></i><span class="shortcut-label">Imprimir</span></a>&nbsp;
											<!--<a href="javascript:cancelar();" class="shortcut"><i class="shortcut-icon icon-ban"></i><span class="shortcut-label">Eliminar</span></a>-->
										</div>
									</td>
								</tr>
							</table>
                      	</td>
                   	</tr>
              	</table>
            </div>
			<div class="widget-content" style="padding:10px">
				<table width="100%">
					<tr>
						<td>
							Tipo de N&oacute;mina<br/>
							<select id="ttiponomina" style="width:92%">
							</select>
						</td>
						<td>
							Fecha inicial<br/>
							<input type="text" id="tfechainicial" style="width:95%" value="<?php echo date("d/m/Y"); ?>" />
						</td>
						<td>
							Fecha final<br/>
							<input type="text" id="tfechafinal" style="width:95%" value="<?php echo date("d/m/Y"); ?>" />
						</td>
						<td>
							N&uacute;mero de d&iacute;as pagados<br/>
							<input type="text" id="tdiaspagados" style="width:95%" />
						</td>
					</tr>
				</table> 
				<table width="60%">
					<tr>
						<td>
							Fecha de pago<br/>
							<input type="text" id="tfechapago" style="width:95%" value="<?php echo date("d/m/Y"); ?>" />
						</td>
						<td>
							Sustituir UUID<br/>
							<input type="text" id="tuuid" style="width:95%" />
						</td>
					</tr>
				</table> 
            </div>
            <!-- /widget-header -->
            <div class="widget-content" style="padding:10px">
				<table width="100%">
					<tr>
						<td>
							Departamento<br/>
							<select id="busdepartamento" style="width:92%">
							</select>
						</td>
						<td>
							Empleado<br/>
							<input type="text" id="busnombre" style="width:95%" />
						</td>
						<td align="right" width="75px">
							<div class="shortcuts"> 
								<a href="javascript:buslista();" class="shortcut"><i class="shortcut-icon icon-search"></i><span class="shortcut-label">Fitlrar</span></a>&nbsp;
							</div>
						</td>
						
					</tr>
				</table>
				<br/>
				<table class="table table-striped table-bordered">
				<thead>
					<tr>
						<th width="10px"><input type="checkbox" id="chkall" name="chkall"></th>
						<th width="25%"> Departamento </th>
						<th> Nombre </th>
						<th class="td-actions"> </th>
						<th style="width:5%" class="td-actions"></th>
					</tr>
				</thead>
				<tbody id="tbody">
				</tbody>
				</table>   
            </div>
          </div>
          <!-- /widget -->
        </div>
        <!-- /span6 -->
      </div>
      <!-- /row --> 
    </div>
    <!-- /container --> 
  </div>
  <!-- /main-inner --> 
</div>
<!-- /main  --
<div class="footer">
  <div class="footer-inner">
    <div class="container">
      <div class="row">
        <div class="span12"> &copy; 2017 Timbrado de N&oacute;mina. <a href="http://www.xiontecnologias.com/">Creado por XION Tecnologias</a></div>
        <!-- /span12 -- 
      </div>
      <!-- /row -- 
    </div>
    <!-- /container -- 
  </div>
  <!-- /footer-inner -- 
</div>
<!-- /footer --> 
<!-- Le javascript
================================================== --> 
<!-- Placed at the end of the document so the pages load faster --> 
<script src="js/jquery-1.7.2.min.js"></script> 
<script src="js/bootstrap.js"></script> 
<script src="js/jquery-ui.js"></script>
<script type="text/javascript">
	var camposTXT = new Array('tfechainicial_txt',
							   'tfechafinal_txt',
							   'tfechapago_txt',
							   'tdiaspagados_txt');
							   
	$(document).ready(function(e) {
		$.datepicker.regional['es'] = {
			closeText: 'Cerrar',
			currentText: 'Hoy',
			monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
			monthNamesShort: ['Enero','Febrero','Marzo','Abril', 'Mayo','Junio','Julio','Agosto','Septiembre', 'Octubre','Noviembre','Diciembre'],
			dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
			dayNamesShort: ['Dom','Lun','Mar','Mié','Juv','Vie','Sáb'],
			dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sá'],
			weekHeader: 'Sm',
			dateFormat: 'dd/mm/yy',
			firstDay: 1,
			isRTL: false,
			showMonthAfterYear: false,
			yearSuffix: ''};
		$.datepicker.setDefaults($.datepicker.regional['es']);
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
	}
	
	function buscar(){
		buslista();
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
</script>
</body>
</html>
