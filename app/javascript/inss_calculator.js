// inss_calculator.js

document.addEventListener('turbo:load', function() {
  const salaryInput = document.getElementById('salary');
  const inssDiscountInput = document.getElementById('inss_discount');

  if (salaryInput && inssDiscountInput) {
    salaryInput.addEventListener('input', function() {
      const salary = parseFloat(salaryInput.value);
      console.log('Salário:', salary);
      fetch('/proponents/calculate_inss_discount', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({ salary: salary })
      })
      .then(response => response.json())
      .then(data => {
        inssDiscountInput.value = data.discount.toFixed(2); // Exibe o desconto do INSS
      })
      .catch(error => {
        console.error('Erro ao calcular desconto do INSS:', error);
      });
    });
  }
});
