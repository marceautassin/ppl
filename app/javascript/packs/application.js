require("chartkick")
require("chart.js")

import "bootstrap";
import { initSelect2 } from '../plugins/init_select2';
import { changerValue, constructionTableauSelectionne } from '../components/cards.js'
initSelect2();

changerValue();
constructionTableauSelectionne();
