
import ReactDOM from 'react-dom'

function unload_it(){
  console.log("react unloader")
  const components = document.querySelectorAll("[data-component-name]");

  components.forEach(function(node){
    ReactDOM.unmountComponentAtNode(node);
  })
}


export { unload_it }