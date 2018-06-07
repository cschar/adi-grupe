import React, { Component } from 'react';
import ReactDOM from 'react-dom'

import {RosterIcon, GrupeDetailApp} from '../components/GrupeDetailApp'


const RegisteredComponentTypes = {
  RosterIcon : RosterIcon,
  GrupeDetailApp : GrupeDetailApp
};  



function load_it(){

const extractProps = (el) =>
 JSON.parse(el.getAttribute("data-react-props"))

const mountComponent = function(ComponentType, node){
  const props = extractProps(node)
  const element = <ComponentType {...props} />;
  ReactDOM.render(element, node);
}


const containers = document.querySelectorAll("[data-component-name");

containers.forEach(function(el){
  const componentName = el.getAttribute("data-component-name")
  const type = RegisteredComponentTypes[componentName];
  mountComponent(type, el);
})
}

export { load_it }