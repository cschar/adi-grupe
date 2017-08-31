import PropTypes from 'prop-types';
import React from 'react';
import SimpleMap from './SimpleMap'
import { Map, Marker, Popup, TileLayer } from 'react-leaflet';
import keydown from 'react-keydown';
import configureStore from '../store/helloWorldStore'

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
        console.log('hey');
        console.log(this.props);
        this.props.updatePos('down')
    }

    @keydown(37)
    method3(event){
        console.log(event)
    }


    render() {
        return (

            <div className="container">

                <h3>
                    Hello, {this.props.name}!
                </h3>
                <hr/>
                <div>
                    <SimpleMap />
                </div>
                <form>
                    <label htmlFor="name">
                        Say hello to:
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


export default MainApp;
