<?php
	require_once("ajax/control.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>RR.HH <?=$_SESSION['titulo']?></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="assets/datetimepicker/css/datetimepicker.min.css">
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
<script src="js/jquery-1.7.2.min.js"></script> 
<script src="js/bootstrap.js"></script> 
<script src="js/jquery-ui.js"></script>

<script src="js/vue.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.18.0/axios.js"></script>


<link href="https://unpkg.com/flatpickr@4/dist/flatpickr.min.css" rel="stylesheet">
<script src="https://unpkg.com/flatpickr@4/dist/flatpickr.min.js"></script>
<script src="https://unpkg.com/vue-flatpickr-component@7"></script>

	<script>
		// Vue.component('date-picker', VueBootstrapDatetimePicker.default);

 			Vue.component('flat-pickr', VueFlatpickr);
	</script>
</head>
<body>
<!-- Modal -->
<div id="busquedaEmpleados" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">B&uacute;squeda de Empleado</h4>
      </div>
      <div class="modal-body">
        
		<table width="100%">
			<tr>
				<td>
					Departamento<br/>
					<select id="busdepartamento" style="width:92%">
					</select>
				</td>
				<td>
					Nombre<br/>
					<input type="text" id="busnombre" style="width:95%" />
				</td>
				<td align="right">
					<div class="shortcuts"> 
						<a href="javascript:buslista();" class="shortcut"><i class="shortcut-icon icon-search"></i><span class="shortcut-label"></span></a>&nbsp;
					</div>
				</td>
			</tr>
		</table>
		<br/>
		<table class="table table-striped table-bordered">
		<thead>
			<tr>
				<th> Departamento </th>
				<th> Nombre </th>
			</tr>
		</thead>
		<tbody id="bustbody">
		</tbody>
		</table>
		
		
      </div>
      <div class="modal-footer">
        <!--<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>-->
      </div>
    </div>

  </div>
</div>
<!-- Termina Modal -->
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
         
				<div class="form-actions" style="text-align:right; margin-top:0px; margin-bottom:0px; padding:5px">
					<table width="100%" cellpadding="0" cellspacing="0">
						<tr>
							<td width="75px">
								<div class="shortcuts"> 
									<a href="javascript:buscar();" class="shortcut"><i class="shortcut-icon icon-search"></i><span class="shortcut-label">Buscar</span></a>&nbsp;
								</div>
							</td>
							<td>
								<table align="right" cellpadding="0" cellspacing="0">
									<tr>
										<td>
											
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
				<!-- /widget-header -->
				<div class="widget-content" style="padding:10px">
					<table width="100%">
						<tr>
							<td width="10%">
								NIP<br/>
								<input type="text" id="inip" style="width:85%" readonly />
							</td>
							<td width="40%">
								Nombre<br/>
								<input type="text" id="inombre" style="width:95%" readonly />
							</td>
							<td>
								Departamento<br/>
								<input type="text" id="idepartamento" style="width:92%" readonly />
							</td>
							<td>
								Puesto<br/>
								<input type="text" id="ipuesto" style="width:92%" readonly />
							</td>
						</tr>
					</table>
					<ul class="nav nav-tabs">
						<li class="active"><a data-toggle="tab" href="#percepciones">Percepciones</a></li>
						<li><a data-toggle="tab" href="#deducciones">Deducciones</a></li>
						<li><a data-toggle="tab" href="#otrospagos">Otros Pagos</a></li>
						<li><a data-toggle="tab" href="#incapacidades">Incapacidades</a></li>
						<li><a data-toggle="tab" href="#jubilacion">Jubilaci&oacute;n/Pensi&oacute;n/Retiro</a></li>
						<li><a data-toggle="tab" href="#separacion">Separaci&oacute;n/Indemnizaci&oacute;</a></li>
					</ul>

					<div class="tab-content">
						<div id="percepciones" class="tab-pane fade in active">
							<div class="panel-group">

								<div class="panel panel-default">
									<div class="panel-heading">Percepci&oacute;n</div>
									<div class="panel-body">
										<table width="100%">
											<tr>
												<td>
													Tipo<br/>
													<select id="percepciones_tipopercepcion" style="width:97%">
													</select>
												</td>
												<td width="20%">
													Importe Gravado<br/>
													<input type="number" id="percepciones_gravado" style="width:92%"  />
												</td>
												<td width="20%">
													Importe exento<br/>
													<input type="number" id="percepciones_excento" style="width:92%"  />
												</td>	
												<td width="75px">
													<div class="shortcuts"> 
														<a href="javascript:add('percepciones');" class="shortcut"><i class="shortcut-icon icon-plus"></i><span class="shortcut-label">Agregar</span></a>&nbsp;
													</div>
												</td>
											</tr>
										</table>
										<table width="70%">
											<tr>
												<td>
													(Acciones o T&iacute;tulos) Valor del mecado<br/>
													<input type="number" id="percepciones_valormercado" style="width:92%" />
												</td>
												<td>
													(Acciones o T&iacute;tulos) Precio al otorgarse<br/>
													<input type="number" id="percepciones_preciootorgarse" style="width:92%" />
												</td>	
											</tr>
										</table>
										<table class="table table-striped table-bordered">
										<thead>
										    <tr>
												<th> Tipo de percepci&oacute;n </th>
												<th> Importe Gravado </th>
												<th> Importe Exento </th>
												<th> Valor del Mercado </th>
												<th> Precio a Otorgarse </th>
												<th class="td-actions"> </th>
										    </tr>
										</thead>
										<tbody id="tbodypercepciones">
										</tbody>
										</table>
									</div>
								</div>

								<div class="panel panel-default">
								    <div class="panel-heading">Horas extra</div>
								    <div class="panel-body">
										<table width="100%">
											<tr>
												<td width="20%">
													D&iacute;as<br/>
													<input type="number" id="horasextra_dias" style="width:92%" />
												</td>
												<td>
													Tipo de horas<br/>
													<select id="horasextra_tipohoras" style="width:97%">
													</select>
												</td>
												<td width="20%">
													Horas extra<br/>
													<input type="number" id="horasextra_horasextra" style="width:92%" />
												</td>
												<td width="20%">
													Importe pagado<br/>
													<input type="number" id="horasextra_importepagado" style="width:92%"/>
												</td>												
												<td width="75px">
													<div class="shortcuts"> 
														<a href="javascript:add('horasextra');" class="shortcut"><i class="shortcut-icon icon-plus"></i><span class="shortcut-label">Agregar</span></a>&nbsp;
													</div>
												</td>
											</tr>
										</table>
										<table width="70%">
											<tr>
												<td>
													Importe Gravado<br/>
													<input type="number" id="horasextra_gravado" style="width:92%" />
												</td>
												<td>
													Importe Exento<br/>
													<input type="number" id="horasextra_exento" style="width:92%" />
												</td>	
											</tr>
										</table>
										<table class="table table-striped table-bordered">
										<thead>
										    <tr>
												<th> Tipo de Horas </th>
												<th> D&iacute;as </th>
												<th> Horas Extra </th>
												<th> Importe Pagado </th>
												<th> Importe Gravado </th>
												<th> Importe Exento </th>
												<th class="td-actions"> </th>
										    </tr>
										</thead>
										<tbody id="tbodyhorasextra">
										</tbody>
										</table>
									</div>
								</div>
								
							</div>
						</div>
						<div id="deducciones" class="tab-pane fade">
							<input type="hidden" id="trabajadorId">
							<table width="100%">
								<tr>
									<td width="30%">
										Tipo<br/>
										<select v-model="tipoDeduccion" id="deducciones_tipodeduccion" style="width:97%">
											<option value="-1">Seleeciona una opción</option>
										</select>
									</td>
									<td width="30%">
									  	Fecha de cargo<br>
										  
											  <!-- <my-date-picker v-model="fechaCargo" ></my-date-picker>
											   -->
											   <flat-pickr v-model="fechaCargo" class="input" style="width:90%"></flat-pickr> 
												
										  <!-- <input type="text" v-model= "fechaCargo" style="width:90%"  id="fechaCargo"><i class="btn-icon-only icon-calendar" style="font-size:16px"> </i> -->
									</td>
									<td width="20%">
										Importe<br/>
										<input type="number" v-model ='importe'  style="width:95%"  />
									</td>		
									<td width="20%">
										<label>Programar</label> 
									 	<input type="checkbox"  v-model="deduccionAuto" name="" @click="visibleProgramar"> 
										 
									</td>										
									<td width="65px">
										<div class="shortcuts"> 
											<a href="" @click.prevent="addDeduccion" class="shortcut"><i class="shortcut-icon icon-plus"></i><span class="shortcut-label">Agregar</span></a>&nbsp;
										</div>
									</td>
								</tr>
								<tr >
									<td width="30%" v-show="deduccionAuto">
										Tipo Programación<br>
										<select style="width:95%"  v-model="tipoProgramacion" >
											<option value="1">Quincenal</option>
											<option value="2">Mensual</option>
											<option value="3">Anual</option>
										</select>
									</td>
								   <td v-show="deduccionAuto">
										Fecha vencimiento<br>
										<flat-pickr v-model="vencimientoCargo" class="input" style="width:90%"></flat-pickr> 
										
								   </td>
								</tr>
							</table>
							<table class="table table-striped table-bordered">
							<thead>
								<tr>
									<th> Tipo de deducci&oacute;n </th>
									<th> Importe </th>
									<th>Fecha de Cargo</th>
									<th>Frecuencia</th>
									<th>Vigencia</th>
									<th class="td-actions"> </th>
								</tr>
							</thead>
							<tbody id="tbodydeducciones">
							</tbody>
							</table>
						</div>
						<div id="otrospagos" class="tab-pane fade">
							<div class="panel-group">

								<div class="panel panel-default">
									<div class="panel-heading">Otro Pago</div>
									<div class="panel-body">
										<table width="100%">
											<tr>
												<td>
													Tipo<br/>
													<select id="otrospagos_tipootropago" style="width:97%">
													</select>
												</td>
												<td width="20%">
													Importe<br/>
													<input type="number" id="otrospagos_importe" style="width:92%"  />
												</td>												
												<td width="75px">
													<div class="shortcuts"> 
														<a href="javascript:add('otrospagos');" class="shortcut"><i class="shortcut-icon icon-plus"></i><span class="shortcut-label">Agregar</span></a>&nbsp;
													</div>
												</td>
											</tr>
										</table>
										<table>
											<tr>
												<td>
													(Subsidio al Empleo) Subsidio causaro<br/>
													<input type="number" id="otrospagos_subsidiocausado" style="width:92%" />
												</td>	
											</tr>
										</table>
										<table width="100%">
											<tr>
												<td width="20%">
													(Compensaci&oacute;n Saldo a Favor) A&ntilde;o<br/>
													<input type="number" id="otrospagos_anio" style="width:92%" />
												</td>
												<td width="20%">
													(Compensaci&oacute;n Saldo a Favor) Saldo a favor<br/>
													<input type="number" id="otrospagos_saldofavor" style="width:92%" />
												</td>
												<td width="20%">
													(Compensaci&oacute;n Saldo a Favor) Remanente saldo a favor<br/>
													<input type="number" id="otrospagos_remanente" style="width:92%"/>
												</td>	
											</tr>
										</table>
										<table class="table table-striped table-bordered">
										<thead>
										    <tr>
												<th> Tipo de Otro Pago </th>
												<th> Importe </th>
												<th> Subsidio </th>
												<th> Saldo a Favor </th>
												<th> A&ntilde;o </th>
												<th> Remanente </th>
												<th class="td-actions"> </th>
										    </tr>
										</thead>
										<tbody id="tbodyotrospagos">
										</tbody>
										</table>
									</div>
								</div>

								
							</div>
						</div>
						<div id="incapacidades" class="tab-pane fade">
							<table width="100%">
								<tr>
									<td>
										Tipo<br/>
										<select id="incapacidades_tipoincapacidad" style="width:97%">
										</select>
									</td>												
									<td width="20%">
										D&iacute;as<br/>
										<input type="number" id="incapacidades_dias" style="width:95%"  />
									</td>
									<td width="20%">
										Importe<br/>
										<input type="number" id="incapacidades_importe" style="width:95%"  />
									</td>											
									<td width="75px">
										<div class="shortcuts"> 
											<a href="javascript:add('incapacidades');" class="shortcut"><i class="shortcut-icon icon-plus"></i><span class="shortcut-label">Agregar</span></a>&nbsp;
										</div>
									</td>
								</tr>
							</table>
							<table class="table table-striped table-bordered">
							<thead>
								<tr>
									<th> Tipo de incapacidad </th>
									<th> D&iacute;as </th>
									<th> Importe </th>
									<th class="td-actions"> </th>
								</tr>
							</thead>
							<tbody id="tbodyincapacidades">
							</tbody>
							</table>
						</div>
						<div id="jubilacion" class="tab-pane fade">
							<table width="100%">
								<tr>											
									<td>
										Tipo<br/>
										<select id="jubilaciones_tipopercepcion" style="width:97%">
										</select>
									</td>												
									<td>
										Importe Exento<br/>
										<input type="number" id="jubilaciones_gravado" style="width:95%"  />
									</td>
									<td>
										Importe Gravado<br/>
										<input type="number" id="jubilaciones_exento" style="width:95%"  />
									</td>											
									<td width="75px">
										<div class="shortcuts"> 
											<a href="javascript:add('jubilaciones');" class="shortcut"><i class="shortcut-icon icon-plus"></i><span class="shortcut-label">Agregar</span></a>&nbsp;
										</div>
									</td>
								</tr>
							</table>
							<table width="100%">
								<tr>											
									<td>
										Total en una exhibici&oacute;n<br/>
										<input type="number" id="jubilaciones_unaexhibicion" style="width:95%"  />
									</td>												
									<td>
										Total en parcialidades<br/>
										<input type="number" id="jubilaciones_parcialidades" style="width:95%"  />
									</td>
									<td>
										Monto diario<br/>
										<input type="number" id="jubilaciones_diario" style="width:95%"  />
									</td>
									<td>
										Ingreso acumulable<br/>
										<input type="number" id="jubilaciones_acumulable" style="width:95%"  />
									</td>
									<td>
										Ingreso no acumulable<br/>
										<input type="number" id="jubilaciones_noacumulable" style="width:95%"  />
									</td>
								</tr>
							</table>
							<table class="table table-striped table-bordered">
							<thead>
								<tr>
									<th> Tipo </th>
									<th> Una Exhibici&oacute;n </th>
									<th> Parcialidades </th>
									<th> Monto Diario </th>
									<th> Acumulable </th>
									<th> No Acumulable </th>
									<th> Gravado </th>
									<th> Exento </th>
									<th class="td-actions"> </th>
								</tr>
							</thead>
							<tbody id="tbodyjubilaciones">
							</tbody>
							</table>
						</div>
						<div id="separacion" class="tab-pane fade">
							<table width="100%">
								<tr>											
									<td>
										Tipo<br/>
										<select id="separaciones_tipopercepcion" style="width:97%">
										</select>
									</td>												
									<td>
										Importe Exento<br/>
										<input type="number" id="separaciones_gravado" style="width:95%"  />
									</td>
									<td>
										Importe Gravado<br/>
										<input type="number" id="separaciones_exento" style="width:95%"  />
									</td>									
									<td width="75px">
										<div class="shortcuts"> 
											<a href="javascript:add('separaciones');" class="shortcut"><i class="shortcut-icon icon-plus"></i><span class="shortcut-label">Agregar</span></a>&nbsp;
										</div>
									</td>
								</tr>
							</table>
							<table width="100%">
								<tr>											
									<td>
										Total pagado<br/>
										<input type="number" id="separaciones_pagado" style="width:95%"  />
									</td>												
									<td>
										A&ntilde;os de servicio<br/>
										<input type="number" id="separaciones_anios" style="width:95%"  />
									</td>
									<td>
										&Uacute;ltimo sueldo mensual ordinario<br/>
										<input type="number" id="separaciones_sueldo" style="width:95%"  />
									</td>
									<td>
										Ingreso acumulable<br/>
										<input type="number" id="separaciones_acumulable" style="width:95%"  />
									</td>
									<td>
										Ingreso no acumulable<br/>
										<input type="number" id="separaciones_noacumulable" style="width:95%"  />
									</td>		
								</tr>
							</table>
							<table class="table table-striped table-bordered">
							<thead>
								<tr>
									<th> Tipo </th>
									<th> Pagado </th>
									<th> A&ntilde;os Servicio </th>
									<th> &Uacute;ltimo Sueldo </th>
									<th> Acumulable </th>
									<th> No Acumulable </th>
									<th> Gravado </th>
									<th> Exento </th>
									<th class="td-actions"> </th>
								</tr>
							</thead>
							<tbody id="tbodyseparaciones">
							</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
          </div>
        </div>
        <!-- /span6 -->
      </div>
      <!-- /row --> 
    </div>
    <!-- /container --> 
  </div>
  <!-- /main-inner --> 
</div>
<!-- /footer --
<div class="footer">
  <div class="footer-inner">
    <div class="container">
      <div class="row">
        <div class="span12"> &copy; 2017 Timbrado de N&oacute;mina. <a href="http://www.xiontecnologias.com/">Creado por XION Tecnologias</a></div>
        <!-- /span12 - 
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

<script type="text/javascript">
	
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
			alert("Debe seleccionar primero a un empleado para realizar esta accion");
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
					if(j!='id')
						if ( row[i][j] == 'null'  || row[i][j] == null) {
							echo+= "	<td>No aplica</td>";
						}
						else{
							echo+= "	<td>"+row[i][j]+"</td>";
						}
				}
				echo+= '	<td class="td-actions" ><a href="javascript:del(\''+id+'\','+row[i].id+');" class="btn btn-danger btn-small" title="Eliminar"><i class="btn-icon-only icon-remove"> </i></a></td>';
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

</script>
</body>
</html>