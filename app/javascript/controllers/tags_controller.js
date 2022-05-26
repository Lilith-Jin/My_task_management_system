import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

export default class extends Controller {
  connect() {
    
    this.selectInstance = new TomSelect(this.element,{
      plugins: {
        remove_button:{
          title:'Remove this item',
        }
      },
      persist: false,
      create: true
    })
  }
}