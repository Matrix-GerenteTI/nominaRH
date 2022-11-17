<?php
	require_once("ajax/control.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<?php require_once('partials/header.php') ?>
	<link rel="stylesheet" href="assets/vendors/bootstrap-datepicker/bootstrap-datepicker.min.css">
<!-- Modal BUSLIST -->
</head>
<body class="sidebar-<?=$_SESSION['template']?>">
<div class="modal fade" id="busquedaEmpleados" tabindex="-1" aria-labelledby="busquedaEmpleadosLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="busquedaEmpleadosLabel">B&uacute;squeda de Empleado</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="btn-close"></button>
      </div>
      <div class="modal-body">
	  	<div class="row">
			<div class="col-4">
				<div class="form-group">
					<select id="busestado" class="form-control">
						<option value="1">Acitvo</option>
						<option value="99">Inactivo</option>
					</select>
					<select id="busdepartamento" style="display:none"></select>
				</div>
			</div>
			<div class="col-5">
				<div class="form-group">
					<input type="text" id="busnombre" placeholder="Nombre" class="form-control" />
				</div>
			</div>
			<div class="col-3">
				<button class="btn btn-secondary btn-large"><i class="mdi mdi-account-search"></i></button>
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
						<div class="col-12" style="text-align:right; padding:1em">
							<?php if($_SESSION['permisos'][2]['guardar']==1){ ?>
							<button type="button" class="btn btn-success btn-icon" onclick="guardar()"><i class="mdi mdi-content-save"></i></button>
							<?php } ?>
						</div>
					</div>
					<div class="card">
						<div class="card-header" style="font-size:1.2em; font-weight:bold"> 
							<i class="icon-edit"></i> <span>Datos de la Empresa</span>
						</div>
						<!-- /widget-header -->
						<div class="card-body" style="padding:10px">
							<div class="row">
								<div class="col-4 col-lg-2">
									<label>RFC</label>
									<input type="text" id="erfc" class="form-control" />
								</div>
								<div class="col-8 col-lg-5">
									Nombre<br/>
									<input type="text" id="enombre" class="form-control" />
								</div>
								<div class="col-6 col-lg-3">
									CURP<br/>
									<input type="text" id="ecurp" class="form-control" />
								</div>
								<div class="col-6 col-lg-2">
									Registro patronal<br/>
									<input type="text" id="eregistropatronal" class="form-control" />
								</div>
							</div>							
							<div class="row">
								<div class="col-8 col-lg-3">
										Calle<br/>
										<input type="text" id="ecalle" class="form-control" />
								</div>
								<div class="col-4 col-lg-2">
										Numero Ext.<br/>
										<input type="text" id="enumext" class="form-control" />
								</div>
								<div class="col-4 col-lg-2">
										Numero Int.<br/>
										<input type="text" id="enumint" class="form-control" />
								</div>
								<div class="col-5 col-lg-3">
										Colonia<br/>
										<input type="text" id="ecolonia" class="form-control" />
								</div>
								<div class="col-3 col-lg-2">
										C.P.<br/>
										<input type="text" id="ecp" class="form-control" />
								</div>
							</div>						
							<div class="row">
								<div class="col-6 col-lg-3">
										Estado<br/>
										<select id="eestado" class="form-control">
										</select>
								</div>
								<div class="col-6 col-lg-3">
										Municipio<br/>
										<input type="text" id="emunicipio" class="form-control" />
								</div>
								<div class="col-6 col-lg-3">
										Correo electr&oacute;nico<br/>
										<input type="text" id="eemail" class="form-control" />
								</div>
								<div class="col-6 col-lg-3">
										Tel&eacute;fono<br/>
										<input type="text" id="etelefono" class="form-control" />
								</div>
							</div>						
							<div class="row">
								<div class="col-12">
										R&eacute;gimen fiscal<br/>
										<select id="eregimenfiscal" class="form-control">
										</select>
								</div>
							</div>
						</div>
					</div>
					<!-- /widget -->
            	</div>
            	<!-- /span12 -->
        	</div>
			<br/>
        	<!-- /row --> 
			<div class="row">
				<div class="col-12 col-lg-6">
					<div class="card">
						<div class="card-header" style="font-size:1.2em; font-weight:bold"> 
							<i class="icon-sitemap"></i> <span>Departamentos</span>
						</div>
						<!-- /widget-header -->
						<div class="card-body" style="padding:10px">						
							<div class="row">
								<div class="col-6 col-lg-8">
									Departamento
									<input type="text" id="ddescripcion" class="form-control" />
									<input type="text" id="did" style="display:none" />
								</div>
								<div class="col-6 col-lg-4">
									&nbsp;<br/>
									<button type="button" class="btn btn-secondary btn-icon" onclick="nuevoDepartamento()"><i class="mdi mdi-file-outline"></i></button>
									<?php if($_SESSION['permisos'][2]['guardar']==1){ ?>
									<button type="button" class="btn btn-success btn-icon" onclick="guardarDepto()"><i class="mdi mdi-content-save"></i></button>
									<?php }if($_SESSION['permisos'][2]['borrar']==1){ ?>
                					<button type="button" class="btn btn-danger btn-icon" onclick="eliminar('d','departamento')"><i class="mdi mdi-minus"></i></button>
									<?php } ?>
								</div>
							</div>
							<hr/>
                			<div class="table-responsive pt-3" style="max-height:500px">
								<table class="table table-bordered">
									<thead>
										<tr>
											<th width="10px"><input type="checkbox" id="chkall" name="chkall"></th>
											<th> Departamento </th>
											<th> </th>
										</tr>
									</thead>
									<tbody id="tbodyDeptos">
										
									</tbody>
								</table>
							</div>
						</div>
					</div>                    
        		</div>
				<br/>
            	<div class="col-12 col-lg-6">
					<div class="card">
						<div class="card-header" style="font-size:1.2em; font-weight:bold"> 
							<i class="icon-suitcase"></i> <span>Puestos</span>
						</div>
						<!-- /widget-header -->
						<div class="card-body" style="padding:10px">
											
							<div class="row">
								<div class="col-12 col-lg-4">
									Puesto<br/>
									<input type="text" id="pdescripcion" class="form-control"/>
									<input type="text" id="pid" style="display:none" />
								</div>
								<div class="col-5 col-lg-4">
									Departamento<br/>
									<select id="pdepartamento" class="form-control">
									</select>
								</div>
								<div class="col-5 col-lg-4">
									&nbsp;<br/>
									<button type="button" class="btn btn-secondary btn-icon" onclick="nuevoPuesto()"><i class="mdi mdi-file-outline"></i></button>
									<?php if($_SESSION['permisos'][2]['guardar']==1){ ?>
									<button type="button" class="btn btn-success btn-icon" onclick="guardarPuesto()"><i class="mdi mdi-content-save"></i></button>
									<?php }if($_SESSION['permisos'][2]['borrar']==1){ ?>
                					<button type="button" class="btn btn-danger btn-icon" onclick="eliminar('p','puesto')"><i class="mdi mdi-minus"></i></button>
									<?php } ?>
								</div>
							</div>
							<hr/>
                			<div class="table-responsive pt-3" style="max-height:500px">
								<table class="table table-bordered">
									<thead>
									<tr>
										<th width="10px"><input type="checkbox" id="chkall" name="chkall"></th>
										<th> Departamento </th>
										<th> Puesto </th>
										<th> </th>
									</tr>
									</thead>
									<tbody id="tbodyPuestos">
									
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<!-- /widget -->
				</div>
				<!-- /span6 -->
        	</div>
			<br/>
			<div class="row">
				<div class="col-12" id="puestosSuperiores">
					<div class="card">
						<div class="card-header" style="font-size:1.2em; font-weight:bold"> 
							<i class="icon-sitemap"></i> <span>Organigrama</span>
						</div>
						<!-- /widget-header -->
						<div class="card-body" style="padding:10px">											
							<div class="row">
								<div class="col-12 col-lg-4">
									Departamento p. superior<br>
									<select class="form-control" v-model="deptoSuperior" >
										<option value="-1">Selecciona un departamento</option>
										<option v-for="departamento in departamentos" :value="departamento.id">{{departamento.descripcion}}</option>
									</select>
								</div>
								<div class="col-12 col-lg-4">
									Puesto Superior<br>
									<select class="form-control" v-model="superior">
										<option value="-1">Selecciona un puesto</option>
										<option v-for="puesto in puestosSup" :value="puesto.id">{{puesto.descripcion}}</option>
									</select>
								</div>
								<div class="col-12 col-lg-4">
									Empleado dependiente<br>
									<select class="form-control" v-model="empleadosuperior">
										<option value="-1">Selecciona un empleado</option>
										<option v-for="empleado in empleadoSup" :value="empleado.nip">{{empleado.nombre}}</option>
									</select>	
								</div>
							</div>											
							<div class="row">
								<div class="col-12 col-lg-4">
									Departamento p. dependiente<br>
									<select class="form-control" v-model="deptoDependiente">
										<option value="-1">Selecciona un departamento</option>
										<option v-for="departamento in departamentos" :value="departamento.id">{{departamento.descripcion}}</option>
									</select>
								</div>
								<div class="col-12 col-lg-4">
									Puesto dependiente<br>
									<select class="form-control" v-model="dependiente">
										<option value="-1">Selecciona un puesto</option>
										<option v-for="puesto in puestosDep" :value="puesto.id">{{puesto.descripcion}}</option>
									</select>	
								</div>
								<div class="col-12 col-lg-4">
									Empleado dependiente<br>
									<select class="form-control" v-model="empleadodependiente">
										<option value="-1">Selecciona un empleado</option>
										<option v-for="empleado in empleadoDep" :value="empleado.nip">{{empleado.nombre}}</option>
									</select>	
								</div>
							</div>											
							<div class="row">
								<div class="col-12 col-lg-12">
									<div id="botones" class="shortcuts"> 
										<?php if($_SESSION['permisos'][2]['guardar']==1){ ?>
											<br/>
										<button @click.prevent="agregar" class="btn btn-success"><i class="shortcut-icon icon-plus"></i> Agregar</button>&nbsp;
										<?php } ?> 
									</div>	
								</div>
							</div>		
								<table style="display:none">	
									<tr>
										<td><b>Aplica a sucursal:</b></td>
										<td>  <input type="checkbox" v-model="aplicaSucursal"  ></td>
										<td></td>
									</tr>
									<tr v-show="aplicaSucursal" >
											<td> <b>Selecciona Sucursal</b> </td>
											<td>
													<select v-model="sucursales" >
														<option value="-1">Selecciona sucursal</option>
														<option v-for="sucursal in listaSucursales"  :value="sucursal.id">{{sucursal.descripcion}}</option>
													</select>
											</td>
									</tr>
									<tr>
										<td><b>Aplica a organigrama:</b></td>
										<td><input type="checkbox" v-model="aplicacionOrg" value="Dir">&nbsp;Dirección&ensp;
										<input type="checkbox" v-model="aplicacionOrg" value="Ger">&nbsp;Gerencial&ensp;
										<input type="checkbox" v-model="aplicacionOrg" value="Jef">&nbsp;Jefaturas&ensp;</td>
									</tr>
								</table>
							<br><br>
							<table class="table table-striped table-bordered">
								<thead>
								<thead>
											<tr>
												<th width="10px"></th>
												<th> Empleado </th>
												<th> Jefe Inmediato </th>
												<th></th>
											</tr>
									</thead>
									<tbody is="tr-organigrama" :puestos="puestosOrg">
									</tbody>
								</thead>
							</table>									
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<?php require_once('partials/js.php') ?>
	<!-- End custom js for this page -->
	<script src="js/vue.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.18.0/axios.js"></script>
	<script src="assets/components/tabla-organigrama.js"></script>
	<script type="text/javascript" src="js/empresa.js">
	

	
</script>
</body>
</html>    