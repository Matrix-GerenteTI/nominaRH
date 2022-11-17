<?php
	require_once("ajax/control.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<?php require_once('partials/header.php') ?>

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
						<div class="col-12" style="text-align:right; padding:1em" id="btnshtml">
							<button type="button" class="btn btn-secondary btn-icon" onclick="timbrar()" disabled><i class="shortcut-icon icon-file-code-o"></i></button>
							<?php if($_SESSION['permisos'][11]['imprimir']==1){ ?>
							<button type="button" class="btn btn-success btn-icon" onclick="imprimir()"><i class="shortcut-icon icon-print"></i></button>
							<?php } ?>
						</div>
					</div>	
					<div class="card">
						<div class="card-body" style="padding:10px">
							<div class="row">
								<div class="col-lg-3">
										Tipo de N&oacute;mina<br/>
										<select id="ttiponomina" class="form-control"></select>									
								</div>
								<div class="col-lg-6">	
										Nómina<br/>
										<select id="tnomina" class="form-control" onchange="seleccionaNomina()"></select>	
										<input type="text" id="tfechainicial" class="form-control" style="display:none" />
										<input type="text" id="tfechafinal" class="form-control" style="display:none" />								
								</div>
								<div class="col-lg-3">
										N&uacute;mero de d&iacute;as pagados<br/>
										<input type="text" id="tdiaspagados" class="form-control" readonly />									
								</div>
							</div>
							<div class="row">
								<div class="col-lg-3">
										Fecha de pago<br/>
										<input type="text" id="tfechapago" class="form-control" value="<?php echo date("d/m/Y"); ?>" />	
										<input type="text" id="tuuid" class="form-control" style="display:none" disabled />							
								</div>
								<!-- <div class="col-lg-3">	
										Sustituir UUID<br/>
										<input type="text" id="tuuid" class="form-control" disabled />								
								</div> -->
							</div>
						</div>
					</div>
					<br/>
					<div class="card">
						<div class="card-body" style="padding:10px">
							<div class="row">
								<div class="col-lg-4">
									Departamento<br/>
									<select id="busdepartamento" class="form-control"></select>								
								</div>
								<div class="col-lg-5">	
									Empleado<br/>
									<input type="text" id="busnombre" class="form-control" />							
								</div>
								<div class="col-lg-3">
									<br/>	
									<button type="button" class="btn btn-dark btn-icon" onclick="buscar()"><i data-feather="zoom-in"></i></button>
								</div>
							</div>
							<hr/>
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
	</div>

	<?php require_once('partials/js.php') ?>
	<!-- End custom js for this page -->
	<script type="text/javascript" src="js/timbrado.js"></script>
</body>
</html>    