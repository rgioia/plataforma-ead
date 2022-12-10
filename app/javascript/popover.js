window.addEventListener('load', (event) => {
  initPage();
});

window.addEventListener('turbo:render', (event) => {
  initPage();
});

function initPage() {
  // initialize popovers
  let popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
  popoverTriggerList.map(function (popoverTriggerEl) {
    return new bootstrap.Popover(popoverTriggerEl)
  });
}