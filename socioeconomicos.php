<?php
	require_once("ajax/control.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<?php require_once('partials/header.php') ?>
	<style>
		.interior{
			padding: 10px;
		}
		.action-bottom-buttons{
		text-align:right;
		margin-top:0px; 
		margin-bottom:0px; 
		padding:5px
		}
		.puntero:hover{
			cursor: pointer;
		}

		.buscaSocioeconomico{
		width:
		}
	</style> 
</head>
<body class="sidebar-<?=$_SESSION['template']?>">
	<!-- Modal BUSLIST -->

	<div class="modal fade" id="busquedaEmpleados" tabindex="-1" aria-labelledby="busquedaEmpleadosLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="busquedaEmpleadosLabel">B&uacute;squeda de Empleado</h5>
			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="btn-close"></button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-4">
					<div class="form-group">
						<label>Departamento</label>
						<select id="selDepartamento" class="form-control"></select>
					</div>
				</div>
				<div class="col-5">
					<div class="form-group">
						<label>Nombre</label>
						<input type="text" id="nombreTrabajador" class="form-control" />
					</div>
				</div>
				<div class="col-3">
					<button class="btn btn-secondary btn-large" id="filtraTrabajador"><i class="mdi mdi-account-search"></i></button>
				</div>
			</div>
			<hr/>
			<div class="row">
				<div class="col-12">
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
			</div>		
		</div>
		<!-- <div class="modal-footer">
			<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
			<button type="button" class="btn btn-primary">Save changes</button>
		</div> -->
		</div>
	</div>
	</div>
	<!-- MODAL BUSLISTA -->
	<div class="main-wrapper">

		<!-- partial:partials/_sidebar.html -->
		<?php require_once('partials/sidebar.php') ?>
    
		<!-- partial -->
	
		<div class="page-wrapper">
					
			<!-- partial:partials/_navbar.html -->
			<?php require_once('partials/navbar.php') ?>
			<!-- partial -->
		<div class="page-content">
			<div class="row">
				<div class="col-12">					
					<div class="row">
						<div class="col-6" style="text-align:left; padding:1em">
							<?php if($_SESSION['permisos'][13]['ver']==1){ ?>
							<button type="button" class="btn btn-dark btn-icon" id="btnBuscarTrabajador"><i data-feather="zoom-in"></i></button>
							<?php } ?>
						</div>
					</div>
					<div class="card">
						<div class="card-header" style="font-size:1.2em; font-weight:bold"> 
							<span>Datos Personales</span>
						</div>
						<!-- /widget-header -->
						<div class="card-body" style="padding:10px">	
							<input type="hidden" id="nip">
							<input type="hidden" id="socioeconomico">
							<div class="row">
								<div class="col-12">
										<label for="">Nombre completo</label>
										<input type="text" name="" id="nombreEmpleado" class="form-control">
								</div>
							</div>
							<hr/>
							<div class="row">
								<div class="col-lg-6">
										<label for="">Calle/Avenida</label>
										<input type="text" name="" id="calle_av" class="form-control">
								</div>
								<div class="col-lg-2">
										<label for="">Número Int.</label>
										<input type="text" name="" id="numInt" class="form-control">
								</div>
								<div class="col-lg-2">
										<label for="">Número Ext.</label>
										<input type="text" name="" id="numExt" class="form-control">
								</div>
								<div class="col-lg-2">
										<label for="">Código postal</label>
										<input type="text" id="cp" class="form-control">
								</div>
							</div>
							<div class="row">
								<div class="col-lg-4">
										<label for="">Colonia</label>
										<input type="text" name="" id="colonia" class="form-control">
								</div>
								<div class="col-lg-4">
										<label>Estado</label>
										<input type="text" name="" id="estado" class="form-control">
								</div>
								<div class="col-lg-4">
										<label for="">Municipio</label>
										<input type="text" name="Municipio" id="municipio" class="form-control">
								</div>
							</div>
							<div class="row">
								<div class="col-lg-4">
										<label for="">Fecha Nacimiento</label>
										<input type="date" name="" id="nacimiento" class="form-control">
								</div>
								<div class="col-lg-4">
										<label for="">Lugar de Nacimiento</label>
										<input type="text" name="" id="lugarNacimiento" class="form-control">
								</div>
								<div class="col-lg-4">
										<label for="">Estado Civil</label>
										<select name="" id="edoCivil" class="form-control">
											<option value="SOLTERA(O)">SOLTERA(O)</option>
											<option value="CASADA(O)">CASADA(O)</option>
											<option value="DIVORCIADA(O)">DIVORCIADA(O)</option>
											<option value="VIUDA(O)">VIUDA(O)</option>
											<option value="UNION LIBRE">UNION LIBRE</option>
										</select>
								</div>
							</div>         
						</div>
						<div class="row">
							<div class="col-12" style="text-align:right; padding:1em">
								<?php if($_SESSION['permisos'][13]['guardar']==1){ ?>
								<button type="button" class="btn btn-success btn-icon" id="guardaPersonal"><i class="mdi mdi-content-save"></i></button>
								<?php } ?>
							</div>
						</div>
					</div>    
					<br/>
					<div class="card oculto"  style="display:none">
						<div class="card-header" style="font-size:1.2em; font-weight:bold"> 
							<span>Datos Económicos</span>
						</div>
						<!-- /widget-header -->
						<div class="card-body" id="content-economico" style="padding:10px">
							<div class="row">
								<div class="span4">
									<table  style="width:100%">
									<tr>
										<th colspan="2">Mensualmente Perciben</th>
									</tr>
									<tbody id="tingreso">
										
									</tbody>
									</table>                  
								</div>
								<div class="span4">
									<table  style="width:100%">
									<tr>
										<th colspan="2">Gasto mensual familiar</th>
									</tr>
									<tbody id="tgasto">
										
									</tbody>
									</table>                  
								</div>
								<div class="span4">
									<table  style="width:100%">
									<tr>
										<th colspan="2">Créditos</th>
									</tr>
									<tbody id="tcreditos">
										
									</tbody>
									</table>                  
								</div>              
							</div>
							<div class="row">
								<div class="col-12" style="text-align:right; padding:1em">
									<button type="button" class="btn btn-secondary btn-icon" onclick="limpiaSeccion('economico')"><i class="mdi mdi-file-outline"></i></button>
									<?php if($_SESSION['permisos'][13]['guardar']==1){ ?>
									<button type="button" class="btn btn-success btn-icon" onclick="guardaSeccion('economico')" id="guardaEconomico"><i class="mdi mdi-content-save"></i></button>
								<?php } ?>
								</div>
							</div>
						</div>        
					</div>    
					<br/>
					<div class="card oculto"  style="display:none">
						<div class="card-header" style="font-size:1.2em; font-weight:bold"> 
							<span>Escolaridad</span>
						</div>
						<!-- /widget-header -->
						<div class="card-body"id="content-escolaridad" style="padding:10px">
							<div id="tescolaridad"></div>
						</div>      					
						<div class="row">
							<div class="col-12" style="text-align:right; padding:1em">
								<button type="button" class="btn btn-secondary btn-icon" onclick="limpiaSeccion('escolaridad')"><i class="mdi mdi-file-outline"></i></button>
								<?php if($_SESSION['permisos'][13]['guardar']==1){ ?>
								<button type="button" class="btn btn-success btn-icon" onclick="guardaSeccion('escolaridad')"><i class="mdi mdi-content-save"></i></button>
								<?php } ?>
							</div>
						</div>                     
					</div>
					<br/>
					<div class="card oculto"  style="display:none">
						<div class="card-header" style="font-size:1.2em; font-weight:bold"> 
							<span>Referencias Vecinales</span>
						</div>
						<!-- /widget-header -->
						<div class="card-body" id="content-vecinales" style="padding:10px">
							<div id="tvecinales"></div>           
						</div>
						<div class="row">
							<div class="col-12" style="text-align:right; padding:1em">
								<button type="button" class="btn btn-secondary btn-icon" onclick="limpiaSeccion('vecinales')"><i class="mdi mdi-file-outline"></i></button>
								<?php if($_SESSION['permisos'][13]['guardar']==1){ ?>
								<button type="button" class="btn btn-success btn-icon" onclick="guardaSeccion('vecinales')"><i class="mdi mdi-content-save"></i></button>
								<?php } ?>
							</div>
						</div>          
					</div>   
					<br/>
					<div class="card oculto"  style="display:none">
						<div class="card-header" style="font-size:1.2em; font-weight:bold"> 
							<span>Colonia y Vivienda</span>
						</div>
						<!-- /widget-header -->
						<div class="card-body" id="content-colonia_vivienda" style="padding:10px">
							<div id="tcolonia_vivienda"></div>         
						</div>
						<div class="row">
							<div class="col-12" style="text-align:right; padding:1em">
								<button type="button" class="btn btn-secondary btn-icon" onclick="limpiaSeccion('colonia_vivienda')"><i class="mdi mdi-file-outline"></i></button>
								<?php if($_SESSION['permisos'][13]['guardar']==1){ ?>
								<button type="button" class="btn btn-success btn-icon" onclick="guardaSeccion('colonia_vivienda')"><i class="mdi mdi-content-save"></i></button>
								<?php } ?>
							</div>
						</div>                    
					</div>   
					<br/>
					<div class="card oculto"  style="display:none">
						<div class="card-header" style="font-size:1.2em; font-weight:bold"> 
							<span>Servicios Médicos</span>
						</div>
						<!-- /widget-header -->
						<div class="card-body" id="content-serv_medicos" style="padding:10px">
							<div id="tserv_medicos"></div>                   
						</div>
						<div class="row">
							<div class="col-12" style="text-align:right; padding:1em">
								<button type="button" class="btn btn-secondary btn-icon" onclick="limpiaSeccion('serv_medicos')"><i class="mdi mdi-file-outline"></i></button>
								<?php if($_SESSION['permisos'][13]['guardar']==1){ ?>
								<button type="button" class="btn btn-success btn-icon" onclick="guardaSeccion('serv_medicos')"><i class="mdi mdi-content-save"></i></button>
								<?php } ?>
							</div>
						</div>           
					</div>     
					<br/>
					<div class="card oculto"  style="display:none">
						<div class="card-header" style="font-size:1.2em; font-weight:bold"> 
							<span>Datos Familiares</span>
						</div>
						<!-- /widget-header -->
						<div class="card-body" id="content-familia" style="padding:10px">
							<div id="tfamilia"></div>
							<hr/>
							<table style="width:100%">
							<tr>
								<th>Nombre</th>
								<th>Parentesco</th>
								<th>Edad</th>
								<th>Escolaridad</th>
								<th>Ocupación</th>
							</tr>
							<tbody id="elementFamiliar">
								
							</tbody>
							</table>               
						</div>
						<div class="row">
							<div class="col-12" style="text-align:right; padding:1em">
								<button type="button" class="btn btn-secondary btn-icon" onclick="limpiaSeccion('familia')"><i class="mdi mdi-file-outline"></i></button>
								<?php if($_SESSION['permisos'][13]['guardar']==1){ ?>
								<button type="button" class="btn btn-success btn-icon" onclick="guardaSeccion('familia')"><i class="mdi mdi-content-save"></i></button>
								<?php } ?>
							</div>
						</div>           
					</div>     
					<br/>
					<div class="card oculto"  style="display:none">
						<div class="card-header" style="font-size:1.2em; font-weight:bold"> 
							<span>Datos Médicos</span>
						</div>
						<!-- /widget-header -->
						<div class="card-body" id="content-medicos" style="padding:10px">
							<div id="tmedicos"></div>             
						</div>
						<div class="row">
							<div class="col-12" style="text-align:right; padding:1em">
								<button type="button" class="btn btn-secondary btn-icon" onclick="limpiaSeccion('medicos')"><i class="mdi mdi-file-outline"></i></button>
								<?php if($_SESSION['permisos'][13]['guardar']==1){ ?>
								<button type="button" class="btn btn-success btn-icon" onclick="guardaSeccion('medicos')"><i class="mdi mdi-content-save"></i></button>
								<?php } ?>
							</div>
						</div>          
					</div>     
					<br/>
					<div class="card oculto"  style="display:none">
						<div class="card-header" style="font-size:1.2em; font-weight:bold"> 
							<span>Sociocultural</span>
						</div>
						<!-- /widget-header -->
						<div class="card-body" id="content-sociocultural" style="padding:10px">
							<div id="tsociocultural"></div>             
						</div>
						<div class="row">
							<div class="col-12" style="text-align:right; padding:1em">
								<button type="button" class="btn btn-secondary btn-icon" onclick="limpiaSeccion('sociocultural')"><i class="mdi mdi-file-outline"></i></button>
								<?php if($_SESSION['permisos'][13]['guardar']==1){ ?>
								<button type="button" class="btn btn-success btn-icon" onclick="guardaSeccion('sociocultural')"><i class="mdi mdi-content-save"></i></button>
								<?php } ?>
							</div>
						</div>           
					</div>     
					<br/>
					<div class="card oculto"  style="display:none">
						<div class="card-header" style="font-size:1.2em; font-weight:bold"> 
							<span>Comentarios Finales</span>
						</div>
						<!-- /widget-header -->
						<div class="card-body" id="content-final" style="padding:10px">
							<div class="row">
								<div class="col-lg-4">
									<label for="">Nombre del evaluador:</label>
								</div>
								<div class="col-lg-8">
									<input type="text" id="nombreEvaluador" class="form-control">
								</div>
							</div>
							<div class="row">
								<div class="col-lg-4">
									<label for="">Fecha de realización:</label>
								</div>
								<div class="col-lg-8">
									<input type="date" id="fechaEvaluacion" class="form-control">
								</div>
							</div>
							<div class="row">
								<div class="col-lg-4">
									<label for="">Comentarios sobre la entrevista:</label>
								</div>
								<div class="col-lg-8">
									<textarea id="comentarios" class="form-control" rows="7"></textarea>
								</div>
							</div>
							<div class="row">
								<div class="col-lg-4">
									<label for="">Agregar comprobantes:</label>
								</div>
								<div class="col-lg-8">
									<input type="file" accept="image/*" id="fotoSocioeconomico" class="form-control">
								</div>
							</div>  
							<div class="row">
								<div class="col-lg-4">
									<label for="">Comprobantes</label>
								</div>
								<div class="col-lg-8" id="comprobantessoc">
									
								</div>
							</div>                
						</div>
						<div class="row">
							<div class="col-12" style="text-align:right; padding:1em">
								<?php if($_SESSION['permisos'][13]['guardar']==1){ ?>
								<button type="button" class="btn btn-success btn-icon" id="guardaFinales"><i class="mdi mdi-content-save"></i></button>
								<?php } ?>
							</div>
						</div>           
					</div>     
				</div>
			</div>
			<!-- /row -->
		</div>
	</div>

	<?php require_once('partials/js.php') ?>
	<!-- End custom js for this page --><script src="js/vue.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.18.0/axios.js"></script>


	<link href="https://unpkg.com/flatpickr@4/dist/flatpickr.min.css" rel="stylesheet">
	<script src="https://unpkg.com/flatpickr@4/dist/flatpickr.min.js"></script>
	<script src="https://unpkg.com/vue-flatpickr-component@7"></script>

	<script>
		// Vue.component('date-picker', VueBootstrapDatetimePicker.default);

 			Vue.component('flat-pickr', VueFlatpickr);
	</script>
	<script type="text/javascript" src="js/socioeconomicos.js"></script>
</body>
</html>    