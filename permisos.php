<?php
	require_once("ajax/control.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<?php require_once('partials/header.php') ?>

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
					<select id="bustipousuario" class="form-control"></select>
				</div>
			</div>
			<div class="col-5">
				<div class="form-group">
					<input type="text" id="busnombre" placeholder="Nombre" class="form-control" />
				</div>
			</div>
			<div class="col-3">
				<button class="btn btn-secondary btn-large" onclick="buslista()"><i class="mdi mdi-account-search"></i></button>
			</div>
		</div>
		<hr/>
		<div class="row">
			<div class="col-12">
                <div class="table-responsive pt-3" style="max-height:600px">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th> Grupo </th>
                                <th> Nombre </th>
                            </tr>
                        </thead>
                        <tbody id="bustbody">
                        </tbody>
                    </table>
                </div>
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
							<button type="button" class="btn btn-secondary btn-icon" onclick="nuevo()"><i class="mdi mdi-file-outline"></i></button>
							<?php if($_SESSION['permisos'][16]['guardar']==1){ ?>
							<button type="button" class="btn btn-success btn-icon" onclick="guardar()"><i class="mdi mdi-content-save"></i></button>
							<?php } ?>
						</div>
					</div>					
					<div class="card">
						<div class="card-header" style="font-size:1.2em; font-weight:bold"> 
							<i class="icon-edit"></i> <span>Accesos y permisos por usuario</span>
						</div>
						<!-- /widget-header -->
						<div class="card-body" style="padding:10px">
							<div class="row">
								<div class="col-12">
									Usuario<br/>
									<div class="input-group" data-target-input="nearest">
										<input type="text" id="usuario" class="form-control" data-target="#serchUsuario" readonly>
										<?php if($_SESSION['permisos'][16]['ver']==1){ ?>
										<button class="input-group-text" data-target="#serchUsuario" onclick="buscar()"><i class="link-icon" data-feather="zoom-in"></i></button>
										<?php } ?>
									</div>
									<input type="text" id="idusuario" style="display:none">
								</div>
							</div>
							<hr/>
							<div class="table-responsive pt-3">
								<table class="table table-bordered">
									<thead>
										<tr>
											<th rowspan="2"> Sección </th>
											<th rowspan="2"> Módulo </th>
											<th rowspan="2"><div class="form-check"><input type="checkbox" class="form-check-input" id="acceso" onClick="checkAllP('acceso')"><label class="form-check-label" for="checkChecked"> Acceso </label></div></th>
											<th colspan="5" style="text-align:center"> Permisos </th>
										</tr>
										<tr>
											<th><div class="form-check"><input type="checkbox" class="form-check-input" id="ver" onClick="checkAllP('ver')"><label class="form-check-label" for="checkChecked"> Ver </label></div></th>
											<th><div class="form-check"><input type="checkbox" class="form-check-input" id="guardar" onClick="checkAllP('guardar')"><label class="form-check-label" for="checkChecked"> Guardar </label></div></th>
											<!-- <th><div class="form-check"><input type="checkbox" class="form-check-input" id="actualizar" onClick="checkAllP('ver')"><label class="form-check-label" for="checkChecked"> Actualizar </label></div></th> -->
											<th><div class="form-check"><input type="checkbox" class="form-check-input" id="borrar" onClick="checkAllP('borrar')"><label class="form-check-label" for="checkChecked"> Borrar </label></div></th>
											<th><div class="form-check"><input type="checkbox" class="form-check-input" id="imprimir" onClick="checkAllP('imprimir')"><label class="form-check-label" for="checkChecked"> Imprimir </label></div></th>
										</tr>
									</thead>
									<tbody id="tbody">
									</tbody>
								</table>							
							</div>							
						</div>
					</div>
				</div>
				<!-- /span6 -->
			</div>
		</div>
	</div>

	<?php require_once('partials/js.php') ?>
	<!-- End custom js for this page -->
	<script type="text/javascript" src="js/permisos.js"></script>
</body>
</html>    