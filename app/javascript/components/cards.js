const tableauDesLiens = document.querySelectorAll('.card-body>a');
const tableauDesBoutons = document.querySelectorAll('.card-body>.button_multi');
const buttonSelections = document.querySelector('.button_multi')
const tableauDesCheckBox = document.querySelectorAll('.checkbox_card');
 const docSelectionne = [];

const changerCard = (button_multi_selection) => {
    const tableauDesLiens2 = document.querySelectorAll('.card-body>a');
  if (button_multi_selection.value === 'true') {
      tableauDesLiens2.forEach( (lien) =>{
        lien.remove();
      })
      tableauDesBoutons.forEach( (bouton) => {
        bouton.classList.remove('invisible');
        document.querySelector('.buttons-multi').classList.remove('invisible');
        document.querySelector('.buttons-multi').classList.add('buttons-multi-transition');
        buttonSelections.classList.remove('invisible');
        bouton.disabled = false;
      })
  } else {
    let i = 0;
    document.querySelectorAll('.card-body').forEach( (card) => {
      card.insertAdjacentElement('afterbegin',tableauDesLiens[i]);
      i += 1;
    });
    tableauDesBoutons.forEach( (bouton) => {
      bouton.classList.add('invisible');
      document.querySelector('.buttons-multi').classList.add('invisible');
      document.querySelector('.buttons-multi').classList.remove('buttons-multi-transition');
      bouton.disabled = true;
      buttonSelections.disabed = true;
    })
  }
}

const changerValue = () => {
  const button_multi_selection = document.querySelector('#selection_multiple_doc');
  button_multi_selection.addEventListener('click', () => {
    if ( button_multi_selection.value === 'true') {
      button_multi_selection.value = 'false';
      button_multi_selection.classList.remove('btn-primary');
      button_multi_selection.classList.add('btn-warning');
      tableauDesCheckBox.forEach( (checkbox) => {
        checkbox.classList.add('invisible');
        checkbox.checked = false;
      })
      docSelectionne.splice(0,docSelectionne.length);
      document.querySelector('#downloads_ids').value = "";
      document.querySelector('#prints_ids').value = "";
    } else {
      button_multi_selection.value = 'true';
      button_multi_selection.classList.remove('btn-warning');
      button_multi_selection.classList.add('btn-primary');
      tableauDesCheckBox.forEach( (checkbox) => {
        checkbox.classList.remove('invisible');
      })
    }
    changerCard(button_multi_selection);
  });
};

const constructionTableauSelectionne = () => {
  const buttonsCards = document.querySelectorAll('.button_multi');
  const checkboxCards = document.querySelectorAll('.checkbox_card');
  buttonsCards.forEach( (bouton) => {
    bouton.addEventListener('click', () => {
      checkboxCards.forEach( (checkbox) => {
        if (checkbox.id === bouton.value) {
          const checkBoxSelectionne = checkbox;
          if (checkBoxSelectionne.checked) {
            checkBoxSelectionne.checked = false;
            docSelectionne.splice(docSelectionne.indexOf(bouton.value), 1);
          } else {
            checkBoxSelectionne.checked = true;
            docSelectionne.push(bouton.value);
          };
        };
      });
      document.querySelector('#downloads_ids').value = docSelectionne;
      document.querySelector('#prints_ids').value = docSelectionne;
    });
  });
};

// clcik button changer value
// selon la value supp ou add a et/ou checkbox
export { changerValue, constructionTableauSelectionne}
