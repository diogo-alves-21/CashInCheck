import ModalController from '../common/modal_controller';

export default class extends ModalController {
  static values = { type: String };

  open(event) {
    const button = event.target.closest('[data-action*="goal-update-modal#open"]');
    const type = button?.dataset.modalType;

    const reinforceBtn = document.querySelector('[data-goal-update-modal-target=\'reinforceBtn\']');
    const reinforceLabel = document.querySelector('[data-goal-update-modal-target=\'reinforceLabel\']');
    const mobilizeBtn = document.querySelector('[data-goal-update-modal-target=\'mobilizeBtn\']');
    const mobilizeLabel = document.querySelector('[data-goal-update-modal-target=\'mobilizeLabel\']');

    const input = document.querySelector('[data-goal-update-modal-target=\'input\']');
    input.value='';
    const max_value = input?.dataset.currentCents / 100;

    if (type == 'mobilize') { // take
      reinforceBtn.classList.add('d-none');
      reinforceLabel.classList.add('d-none');
      mobilizeBtn.classList.remove('d-none');
      mobilizeLabel.classList.remove('d-none');
      input.setAttribute('max', max_value);
    } else { // put
      mobilizeBtn.classList.add('d-none');
      mobilizeLabel.classList.add('d-none');
      reinforceBtn.classList.remove('d-none');
      reinforceLabel.classList.remove('d-none');
      input.removeAttribute('max');
    }

    super.open(event);
  }

}
