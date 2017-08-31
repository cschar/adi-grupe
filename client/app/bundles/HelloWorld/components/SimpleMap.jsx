import React from 'react';
import { Map, Marker, Popup, TileLayer } from 'react-leaflet';
import keydown from 'react-keydown';
import updatePos from '../actions/helloWorldActionCreators';

// const position = [51.505, -0.09];
class SimpleMap extends React.Component {


    @keydown('c')
    method3(event){
        console.log(event)
        this.props.updatePos('down')
    }

    render() {

        return (
            <div>

            <Map center={this.props.position} zoom={6} className="mapBox">
                <Marker position={this.props.position}>
                    <Popup>
                        <span>A pretty CSS3 popup.<br/>Easily customizable.</span>
                    </Popup>
                </Marker>
            </Map>


            </div>
        );

    }
}


const DEFAULT_VIEWPORT = {
    center: [51.505, -0.09],
    zoom: 13,
}


import { connect } from 'react-redux';
// Which part of the Redux global state does our component want to receive as props?
const mapStateToProps = (state) => (
    {   name: state.myRed.name,
        position: state.myRed.position
    });

export default connect(mapStateToProps,updatePos)(SimpleMap);