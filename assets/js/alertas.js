function alertify(titulo,mensaje){
    let timerInterval
  Swal.fire({
    title: titulo,
    html: mensaje,
    timer: 3000,
    timerProgressBar: true,
    didOpen: () => {
      Swal.showLoading()
      timerInterval = setInterval(() => {
        //const content = Swal.getHtmlContainer()
      }, 100)
    },
    willClose: () => {
      clearInterval(timerInterval)
    }
  }).then((result) => {
    /* Read more about handling dismissals below */
    // if (result.dismiss === Swal.DismissReason.timer) {
    //   console.log('I was closed by the timer')
    // }
  })
}

function notify(titulo,icono,mensaje){
    Swal.fire({
        title: titulo,
        text: mensaje,
        icon: icono
    })
}

function AlertUploadingImage(titulo,mensaje){
    Swal.fire({
        title: titulo,
        text: mensaje,
        allowOutsideClick: false,
        imageUrl: 'assets/images/uploadimg.gif',
        allowEscapeKey: false,
        allowEnterKey:false,
        showConfirmButton: false,
        showDenyButton: false,
        showCancelButton: false,
        imageWidth: 300
    })
}

function AlertUploadingDoc(titulo,mensaje){
    Swal.fire({
        title: titulo,
        text: mensaje,
        allowOutsideClick: false,
        imageUrl: 'assets/images/cloud-upload.gif',
        allowEscapeKey: false,
        allowEnterKey:false,
        showConfirmButton: false,
        showDenyButton: false,
        showCancelButton: false,
        imageWidth: 300
    })
}

function AlertLoading(titulo,mensaje){
    Swal.fire({
        title: titulo,
        text: mensaje,
        allowOutsideClick: false,
        imageUrl: 'assets/images/loading.gif',
        allowEscapeKey: false,
        allowEnterKey:false,
        showConfirmButton: false,
        showDenyButton: false,
        showCancelButton: false,
        imageWidth: 300
    })
}

function okMsg(titulo,mensaje){
    Swal.fire({
        title: titulo,
        text: mensaje,
        allowOutsideClick: false,
        icon: 'success',
        timer: 3000,
        allowEscapeKey: false,
        allowEnterKey:false,
        showConfirmButton: false,
        showDenyButton: false,
        showCancelButton: false
    })
}

function errorMsg(titulo,mensaje){
    Swal.fire({
        title: titulo,
        text: mensaje,
        allowOutsideClick: false,
        icon: 'error',
        timer: 3000,
        allowEscapeKey: false,
        allowEnterKey:false,
        showConfirmButton: false,
        showDenyButton: false,
        showCancelButton: false
    })
}
function miniNotify(icono,mensaje){
    const Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true,
    });
    
    Toast.fire({
        icon: icono,
        title: mensaje
    })
}

function confirmy(titulo,icono,mensaje,textBtnOk,textBtnCancel,funcionOk,paramsOk='',funcionCancel=null,paramsCancel=''){
    const swalWithBootstrapButtons = Swal.mixin({
        customClass: {
            confirmButton: 'btn btn-success me-2',
            cancelButton: 'btn btn-danger me-2'
        },
        buttonsStyling: true,
    })
    
    swalWithBootstrapButtons.fire({
        title: titulo,
        text: mensaje,
        icon: icono,
        showCancelButton: true,
        confirmButtonText: textBtnOk,
        cancelButtonText: textBtnCancel,
        reverseButtons: true
    }).then((result) => {
        if (result.value) {
            window[funcionOk](paramsOk);
        } else if (result.dismiss === Swal.DismissReason.cancel){
            if(funcionCancel!=null)
                window[funcionCancel](paramsCancel);
        }
      })
}