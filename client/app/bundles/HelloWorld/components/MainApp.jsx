import PropTypes from 'prop-types';
import React from 'react';
import SimpleMap from './SimpleMap'
import keydown from 'react-keydown';
import configureStore from '../store/helloWorldStore'
import ApolloClient, { createNetworkInterface } from 'apollo-client';
import gql from 'graphql-tag';

const csrf = document.head.querySelector("[name=csrf-token]").content;

const railsNetworkInterface =  createNetworkInterface({
    uri: '/graphql',
    opts: {
        credentials: 'same-origin',
        headers: {
            'X-CSRF-Token': csrf,
        }
    }
});

const client = new ApolloClient({
    networkInterface: railsNetworkInterface});

client.query({
    query: gql`
    query {
      testField
      lmarker (id:39){
        id
        lat
        lng
      }
      lmarkers {
        id
        lat
        lng
      }
    }
  `,
})
    .then(data => console.log(data))
    .catch(error => console.error(error));

class MainApp extends React.Component {
    constructor(props){
        super()

        this.method2 = this.method2.bind(this);
        this.method = this.method.bind(this);
    }

    @keydown('up')
    method(event){

        this.props.updatePos('up')
    }

    @keydown('down')
    method2(event){
        console.log(event);
        console.log(this.props.position);
        console.log('hey from main');
        console.log(this.props);

        this.props.updatePos('down')
    }


    render() {
        return (

            <div className="container">

                <h3>
                    Adi prop, {this.props.name}!
                </h3>
                <hr/>

                <div className="mapBox">
                    <SimpleMap watch={true}/>
                </div>
                <form>
                    <label htmlFor="name">
                        change prop to:
                    </label>
                    <input
                        id="name"
                        type="text"
                        value={this.props.name}
                        onChange={(e) => this.props.updateName(e.target.value)}
                    />
                </form>

            </div>
        );
    }
}

// Simple example of a React "smart" component

import { connect } from 'react-redux';
import * as actions from '../actions/helloWorldActionCreators';

// Which part of the Redux global state does our component want to receive as props?
const mapStateToProps = (state) => (
    {   name: state.myRed.name,
        position: state.myRed.position
    });

// Don't forget to actually use connect!
// Note that we don't export HelloWorld, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default connect(mapStateToProps, actions)(MainApp);


