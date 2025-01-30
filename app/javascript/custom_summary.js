document.addEventListener("DOMContentLoaded", function() {
  const editLink = document.getElementById('edit-summary-link');
  const addLink = document.getElementById('add-summary-link');
  const summaryContent = document.getElementById('summary-content');
  const summaryForm = document.getElementById('summary-edit-form');
  const form = document.getElementById('summary-form');

  if (editLink) {
    editLink.addEventListener('click', function() {
      summaryContent.style.display = 'none';
      summaryForm.style.display = 'block';
    });
  }

  if (addLink) {
    addLink.addEventListener('click', function() {
      summaryForm.style.display = 'block';
      addLink.style.display = 'none';
    });
  }
});
