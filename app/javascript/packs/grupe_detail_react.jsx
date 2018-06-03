// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.
import _ from 'lodash'
import React, { Component } from 'react';
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

import Countdown from 'react-countdown-now';


function RosterIcon(props) {

  let confirmed = ""
  if (props.confirmed) {
    confirmed = (<div> 
      <h3 className="color1">
      Confirmed
      </h3>
    </div>)
  }
  return <div> 
    <div className="col-xs-2 color3 ">
      
      <i className="fa fa-user-circle fa-2x"></i>
      {props.name}  

      { confirmed }
    </div>
  </div>;
}

class GrupeRoster extends Component {
  constructor(){
    super()
  }

  componentDidMount(){
  }

  render() {
    return (
    <div className="row">
      { this.props.users.map( (user, idx) => 
         <RosterIcon confirmed={user.confirmed}
                     name={user.display_name} key={"user"+idx} />) }

      { _.range(this.props.users.length, this.props.capacity).map( x => 
      <div className="col color3 xs-2" key={x}>
        <i className="fa fa-square-o fa-2x"></i>
        Empty spot {x}
      </div>
      ) }

    </div>
    )
  }
}

const Completionist = () => <span>Grupe meeting time over</span>;

const renderer = ({ hours, minutes, seconds, completed }) => {
  if (completed) {
    // Render a completed state
    return <Completionist />;
  } else {
    // Render a countdown
    return <h1><span>{hours}:{minutes}:{seconds}</span></h1>;
  }
};

class GrupeDetailApp extends React.Component {
  constructor(){
    super()
    
    this.state = {
      users: [],
      locked_in_at: null
    }
    this.handleChange = this.handleChange.bind(this);
    this.tick = this.tick.bind(this);
  }

  handleChange(event) {
    var data = Rails.ajax(
      {url: `/grupes/${this.props.grupe.id}.json`,
       type: "GET", dataType: "json",
      success: function(data){
          
          this.setState({
            users: data.users,
            locked_in_at: data.locked_in_at
          })
       }.bind(this)
      })

    
  }

  tick(){
    // this.setState({
    //   date: new Date()
    // });
    this.handleChange()
  }

  componentDidMount(){
    
    this.timerID = setInterval(
      () => this.tick(),
      10000
    );

    this.handleChange()
  }

  componentWillUnmount() {
    clearInterval(this.timerID);
  }


  render() {

    let countdownUI = null;
    if ( this.state.locked_in_at ){
      let time_to_meet = 1000*60*60*5; // 5 hours
      countdownUI = (
        <div className="color2">
        <h2> Group up with your fellow Gruepers! </h2>

        <h3> Meeting time closes in : </h3>
        <Countdown date={new Date(this.state.locked_in_at).getTime() + time_to_meet }
                   renderer={renderer} />
        </div>
      )
    }
    

    return (
      <div className="App">
      
        {countdownUI}
        <GrupeRoster users={this.state.users}
                     capacity={this.props.grupe.capacity}
                     creatorId={this.props.grupe.creator_id} />
      </div>
    );
  }
}

// document.addEventListener('DOMContentLoaded', () => {
  document.addEventListener('turbolinks:load', () => {
  
    var grupeInfo = document.querySelector("#grupeInfo").getAttribute("data-grupeInfo")
    grupeInfo =  JSON.parse(grupeInfo)

    console.log("React")
    
  ReactDOM.render(
    <GrupeDetailApp grupe={grupeInfo} />,
    document.querySelector('#react-app'),
  )
})
