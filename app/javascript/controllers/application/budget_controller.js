import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [];

  connect() {
    // this.startDateInput = document.getElementById('budget_start_date');
    // this.endDateInput = document.getElementById('budget_end_date');
    // this.endDateInput.disabled = true;
    // this.startDateInput.addEventListener('change', this.startDateChanged.bind(this));


    const categorySelect = document.querySelector('#budget_category_id');
    const walletSelect = document.querySelector('#budget_wallet_id');
    categorySelect.disabled = true;
    walletSelect.disabled = true;
    categorySelect.tomselect.disable();
    walletSelect.tomselect.disable();
  }

  groupChanged(event) {
    const groupId = event.target.value;

    const categorySelect = document.querySelector('#budget_category_id');
    const walletSelect = document.querySelector('#budget_wallet_id');

    if (!groupId) {
      categorySelect.disabled = true;
      categorySelect.tomselect.disable();
      categorySelect.tomselect.clear();
      categorySelect.tomselect.clearOptions();
      walletSelect.disabled = true;
      walletSelect.tomselect.disable();
      walletSelect.tomselect.clear();
      walletSelect.tomselect.clearOptions();
      return;
    }


    const newCategoryUrl = `/groups/${groupId}/categories.json`;

    categorySelect.dataset.tomSelectRemoteUrlValue = newCategoryUrl;
    categorySelect.disabled = false;
    categorySelect.tomselect.enable();
    // Reload the Tom Select
    if (categorySelect.tomselect) {
      categorySelect.tomselect.clear();
      categorySelect.tomselect.clearOptions();
      categorySelect.tomselect.load();
    }

    const newWalletUrl = `/groups/${groupId}/wallets.json`;
    walletSelect.dataset.tomSelectRemoteUrlValue = newWalletUrl;
    walletSelect.disabled = false;
    walletSelect.tomselect.enable();
    // Reload the Tom Select
    if (walletSelect.tomselect) {
      walletSelect.tomselect.clear();
      walletSelect.tomselect.clearOptions();
      walletSelect.tomselect.load();
    }


    // const groupId = event.currentTarget.value
    // const categorySelect = document.getElementById("budget_category_id")
    // const walletSelect = document.getElementById("budget_wallet_id")

    // if (!groupId) {
    //   categorySelect.innerHTML = ""
    //   walletSelect.innerHTML = ""
    //   categorySelect.disabled = true
    //   categorySelect.tom_select.disabled = true
    //   walletSelect.disabled = true
    //   walletSelect.tom_select.disabled = true
    //   categorySelect.insertAdjacentHTML("beforeend",
    //     `<option value="">Selecione um grupo primeiro</option>`)
    //   walletSelect.insertAdjacentHTML("beforeend",
    //     `<option value="">Selecione um grupo primeiro</option>`)
    //   return
    // }

    // fetch(`/groups/${groupId}/categories.json`)
    //   .then(res => res.json())
    //   .then(categories => {
    //     categorySelect.innerHTML = ""
    //     categorySelect.insertAdjacentHTML("beforeend",
    //       `<option value="">Selecione uma categoria</option>`)
    //     categories.forEach(cat => {
    //       categorySelect.insertAdjacentHTML("beforeend",
    //         `<option value="${cat.id}">${cat.name}</option>`)
    //     })
    //     categorySelect.disabled = false;
    //     categorySelect.tom_select.disabled = false;
    //   })
    //   .catch(err => {
    //     console.error("Could not load categories:", err)
    //   })

    // fetch(`/groups/${groupId}/wallets.json`)
    //   .then(res => res.json())
    //   .then(wallets => {
    //     walletSelect.innerHTML = ""
    //     walletSelect.insertAdjacentHTML("beforeend",
    //       `<option value="">Selecione uma wallet</option>`)
    //     wallets.forEach(wallet => {
    //       walletSelect.insertAdjacentHTML("beforeend",
    //         `<option value="${wallet.id}">${wallet.name}</option>`)
    //     })
    //     walletSelect.disabled = false
    //     walletSelect.tom_select.disabled = false
    //   })
    //   .catch(err => {
    //     console.error("Could not load wallets:", err)
    //   })
  }

  startDateChanged(event) {
    const startDateValue = event.target.value;

    if (startDateValue) {
      this.endDateInput.disabled = false;
      this.endDateInput.min = startDateValue;

      if (this.endDateInput.value && this.endDateInput.value < startDateValue) {
        this.endDateInput.value = '';
      }
    } else {

      this.endDateInput.disabled = true;
      this.endDateInput.value = '';
      this.endDateInput.removeAttribute('min');
    }
  }
}
