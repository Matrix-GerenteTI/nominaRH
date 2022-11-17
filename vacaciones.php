<?php
	require_once("ajax/control.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<?php require_once('partials/header.php') ?>
<link rel="stylesheet" href="/nomina/css/datepicker.min.css">
<style>



.wrapper {
  margin: 0 auto;
  padding: 40px;
  max-width: 800px;
}

.table {
  margin: 0 0 40px 0;
  width: 100%;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.2);
  display: table;
}
@media screen and (max-width: 580px) {
  .table {
    display: block;
  }
}

.rowtable {
  display: table-row;
  background: #f6f6f6;
}
.rowtable:nth-of-type(odd) {
  background: #e9e9e9;
}
.rowtable.header {
  font-weight: 900;
  color: #ffffff;
  background: #ea6153;
}
@media screen and (max-width: 580px) {
  .rowtable {
    padding: 14px 0 7px;
    display: block;
  }
  .rowtable.header {
    padding: 0;
    height: 6px;
  }
  .rowtable.header .cell {
    display: none;
  }
  .rowtable .cell {
    margin-bottom: 10px;
  }
  .rowtable .cell:before {
    margin-bottom: 3px;
    content: attr(data-title);
    min-width: 98px;
    font-size: 10px;
    line-height: 10px;
    font-weight: bold;
    text-transform: uppercase;
    color: #969696;
    display: block;
  }
}

.cell {
  padding: 6px 12px;
  display: table-cell;
}
@media screen and (max-width: 580px) {
  .cell {
    padding: 2px 16px;
    display: block;
  }
}

    
    .grid-1 {
        display: grid;
        
        width: 100%;
        max-width: 2048px;
        margin: 0 auto;
        
        grid-template-columns: repeat(auto-fill, minmax(30em, 1fr));
        
        grid-gap: 20px;
        
    }
    .form-grid{
        display: grid;
        margin: 0 auto;
        grid-template-columns: repeat(auto-fill, minmax(20em, 1fr));
    }



    .container-lista{
        display: grid;
        margin: 0 auto;
        grid-template-columns: repeat(auto-fill, minmax(50em, 1fr));
    }

    .grid-1 .items{
        padding: 10px;
    }
    .-selected- .dp-note {
    bottom: 2px;
    background: #fff;
    opacity: .5;
}

.dp-note {
    background: #DF013A;
    width: 4px;
    height: 4px;
    border-radius: 50%;
    left: 50%;
    bottom: 1px;
    -webkit-transform: translateX(-50%);
    transform: translateX(-50%);
}
.dp-note, .nav {
    position: absolute;
}

</style>
</head>
<body class="sidebar-<?=$_SESSION['template']?>">
<!-- Modal BUSLIST -->

<div class="modal fade" id="busquedaEmpleados" tabindex="-1" aria-labelledby="busquedaEmpleadosLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="busquedaEmpleadosLabel">B&uacute;squeda de Empleado</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="btn-close"></button>
      </div>
      <div class="modal-body">
	  	<div class="row">
			<div class="col-4">
				<div class="form-group">
                    Departamento<br/>
                    <select id="busdepartamento" class="form-control"><option value='%'></option></select>
				</div>
			</div>
			<div class="col-5">
				<div class="form-group">
                    Nombre<br/>
					<input type="text" id="busnombre" class="form-control" />
				</div>
			</div>
			<div class="col-3">
                <br/>
				<button class="btn btn-secondary btn-large" onclick="buslista()"><i class="mdi mdi-account-search"></i></button>
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
                            <?php if($_SESSION['permisos'][18]['ver']==1){ ?>
                            <button type="button" class="btn btn-dark btn-icon" onclick="buscar()"><i data-feather="zoom-in"></i></button>
                            <?php } ?> 
                        </div>
                    </div>		

                    <div class="card">
                        <div class="card-header" style="font-size:1.2em; font-weight:bold"> 
                          <i class="icon-edit"></i> <span>Vacaciones</span>
                        </div>
                        <!-- /widget-header -->
                        <div class="card-body" style="padding:10px">
                            <section class="grid-1">
                                <div class="items" >
                                    <div>
                                        <input type="hidden" id="nip" >
                                        <label for="">Empleado</label>
                                        <input type="text" name="" id="nombre" class="form-control">
                                    </div>
                                    <div>
                                        <label for="">Fecha de Inicio Laboral</label>
                                        <input type="text" name="" id="fechaInicioLab" class="form-control" disabled >      
                                    </div>                            
                                    <div>
                                        <label for="">Antiguedad Laboral</label>
                                        <input type="text" name="" id="antiguedad" class="form-control" disabled >                                
                                    </div>
                                    <div>
                                        <label for="">Derecho a vacaciones </label>
                                        <input type="text" name="" id="tieneVacaciones" class="form-control" disabled >
                                    </div>
                                    <div>
                                        <label for=""># Días programados</label>
                                        <input type="text" name="" id="diasProgramados" class="form-control" disabled>
                                    </div>
                                    <div class="form-grid">
                                            <div >
                                                    <label for="">Periodo Vacacional Act. </label>
                                                    
                                                                <input type="text"
                                                                class="form-control datepicker-here "
                                                                placeholder="Establecer periodo"
                                                                data-language='es'
                                                                data-min-view="months"
                                                                autocomplete="off" 
                                                                data-view="months"
                                                                data-date-format="MM yyyy"
                                                                id="inicioPeriodo" 
                                                                class="form-control"
                                                                />      
                                                                                        
                                            </div>

                                    </div>
                                    <div>
                                        <label for="">Observaciones</label>
                                        <textarea name="" id="observaciones" class="form-control"></textarea>
                                    </div>
                                </div>
                                <div class="items">
                                    <div class="form-grid">
                                        <div id="fechasProgramada" class="datepicker-here" ></div>
                                        <div>
                                                <div id="contentConfirmaVacaciones" style="display:none">
                                                    <h3>Confirmar los siguientes Día(s) para Vacaciones: <span id="txtFechasConfirmar"></span></h3>
                                                    <button id="confirmaVacaciones" class="shortcut">Confirmar</button>
                                                </div>
                                                
                                                <div style="display:none" id="containerCancelaVacaciones">
                                                    <h3>El trabajador tiene vacaciones programadas en los dias: <span id="txtFechasCancelar"></span>  , ¿deseas cancelarla? </h3>   
                                                    <button id="cancelarDiaVacacion">Confirmar</button>
                                                    <button>Cancelar</button>                                        
                                                </div>                        
                                        </div>
                                    </div>

                                </div>
                            </section>
                            
                    </div>
                    <br/>
                    <div class="card">
                      <div class="card-header" style="font-size:1.2em; font-weight:bold"> 
                        <i class="icon-edit"></i> <span>Trabajadores Programados</span>
                      </div>
                      <!-- /widget-header -->
                      <div class="card-body" style="padding:10px">
                        <div class="items">
                            <div class="form-grid">
                                <input type="text"
                                class="form-control datepicker-here"
                                placeholder="Filtrar por periodo"
                                data-language='es'
                                data-min-view="years"
                                autocomplete="off" 
                                data-view="years"
                                data-date-format="yyyy"
                                value="<?=date('Y')?>"
                                id="filtroPeriodo"
                                />
                            </div>
                        </div>
                        <hr/>
                        <div class="col-12">
                            <div class="table"  id="trabajadoresProgramados">                                
                            </div>  
                        </div> 
                        </div>               
                    </div>
                </div>
            </div>
		</div>
	</div>

	<?php require_once('partials/js.php') ?>
	<!-- End custom js for this page -->
    <script src="js/jquery-ui.js"></script>
    <script src="/nomina/js/datepicker.min.js"></script>
    <script src="/nomina/js/datepicker.es.js"></script>
	<script type="text/javascript" src="js/vacaciones.js"></script>
</body>
</html>  