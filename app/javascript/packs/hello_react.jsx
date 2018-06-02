// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React, { Component } from 'react';
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

import Countdown from 'react-countdown-now';


const Hello = props => (
  <div>Hello {props.name}!</div>
)

Hello.defaultProps = {
  name: 'David'
}

Hello.propTypes = {
  name: PropTypes.string
}



class GrupeDetailApp extends React.Component {
  constructor(){
    super()

    this.state = {}
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(event) {
    
  }

  render() {
    return (
      <div className="App">
      <div> Hello </div>
        <Countdown date={Date.now() + 10000} />
      </div>
    );
  }
}

// document.addEventListener('DOMContentLoaded', () => {
  document.addEventListener('turbolinks:load', () => {
  
    console.log("React")
  ReactDOM.render(
    <GrupeDetailApp />,
    document.querySelector('#react-app'),
  )
})
