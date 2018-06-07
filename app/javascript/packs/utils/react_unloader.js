
import ReactDOM from 'react-dom'

function unload_it(){
  
  const components = document.querySelectorAll("[data-component-name]");

  components.forEach(function(node){
    ReactDOM.unmountComponentAtNode(node);
  })
}


export { unload_it }